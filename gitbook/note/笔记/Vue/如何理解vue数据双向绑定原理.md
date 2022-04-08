Vue 数据双向绑定原理是通过数据劫持结合发布者-订阅者模式的方式来实现的，首先是对数据进行监听，然后当监听的属性发生变化时则告诉订阅者是否要更新，若更新就会执行对应的更新函数从而更新视图

![](../_resources/v2-10f94b6de4ff367903ea4c8c8aa6e_827a93beb2f44b4bb.jpg)

## **MVC 模式**

以往的 MVC 模式是单向绑定，即 Model 绑定到 View，当我们用 JavaScript 代码更新 Model 时，View 就会自动更新

![](../_resources/v2-379cb77a473bf0c7c449f701b8a17_786bab4b86ed48c9a.jpg)

## **MVVM 模式**

MVVM 模式就是 Model–View–ViewModel 模式。它实现了 View 的变动，自动反映在 ViewModel，反之亦然。对于双向绑定的理解，就是用户更新了 View，Model 的数据也自动被更新了，这种情况就是双向绑定。再说细点，就是在单向绑定的基础上给可输入元素 input、textare 等添加了 change(input)事件,(change 事件触发，View 的状态就被更新了)来动态修改 model。

![](../_resources/v2-10c092ce5f24e44625165228cd4f2_32399ac432d348dda.jpg)

## **双向绑定原理**

vue 数据双向绑定是通过数据劫持结合发布者-订阅者模式的方式来实现的

我们已经知道实现数据的双向绑定，首先要对数据进行劫持监听，所以我们需要设置一个监听器 Observer，用来监听所有属性。如果属性发上变化了，就需要告诉订阅者 Watcher 看是否需要更新。因为订阅者是有很多个，所以我们需要有一个消息订阅器 Dep 来专门收集这些订阅者，然后在监听器 Observer 和订阅者 Watcher 之间进行统一管理的。接着，我们还需要有一个指令解析器 Compile，对每个节点元素进行扫描和解析，将相关指令（如 v-model，v-on）对应初始化成一个订阅者 Watcher，并替换模板数据或者绑定相应的函数，此时当订阅者 Watcher 接收到相应属性的变化，就会执行对应的更新函数，从而更新视图。

**因此接下去我们执行以下 3 个步骤，实现数据的双向绑定：**

- （1）实现一个监听器 Observer，用来劫持并监听所有属性，如果有变动的，就通知订阅者。
- （2）实现一个订阅者 Watcher，每一个 Watcher 都绑定一个更新函数，watcher 可以收到属性的变化通知并执行相应的函数，从而更新视图。
- （3）实现一个解析器 Compile，可以扫描和解析每个节点的相关指令（v-model，v-on 等指令），如果节点存在 v-model，v-on 等指令，则解析器 Compile 初始化这类节点的模板数据，使之可以显示在视图上，然后初始化相应的订阅者（Watcher）。

![](../_resources/v2-f356f2023758b0a503e4200596f94_101c57cc3cc54ada8.jpg)

## **实现一个 Observer**

Observer 是一个数据监听器，其实现核心方法就是 Object.defineProperty( )。如果要对所有属性都进行监听的话，那么可以通过递归方法遍历所有属性值，并对其进行 Object.defineProperty( )处理
如下代码实现了一个 Observer。

```javascript
function Observer(data) {    this.data = data;    this.walk(data);
}

Observer.prototype = {    
  walk: function(data) {
    var self = this;        //这里是通过对一个对象进行遍历，对这个对象的所有属性都进行监听
    Object.keys(data).forEach(function(key) {
      self.defineReactive(data, key, data[key]);
    });
  },
  defineReactive: function(data, key, val) {
    var dep = new Dep();      // 递归遍历所有子属性
    var childObj = observe(val);
    Object.defineProperty(data, key, {
      enumerable: true,
      configurable: true,
      get: function getter () {
        if (Dep.target) {
        // 在这里添加一个订阅者
        console.log(Dep.target)
        dep.addSub(Dep.target);
        } 
      return val;
      },
      // setter，如果对一个对象属性值改变，就会触发setter中的dep.notify(),
      //通知watcher（订阅者）数据变更，执行对应订阅者的更新函数，来更新视图。
      set: function setter (newVal) {
        if (newVal === val) {
          return;
        }
      val = newVal;
      // 新的值是object的话，进行监听
      childObj = observe(newVal);
      dep.notify();
    }
  });
 }
};
function observe(value, vm) {    if (!value || typeof value !== 'object') {
return;
 }    return new Observer(value);
};// 消息订阅器Dep，订阅器Dep主要负责收集订阅者，然后在属性变化的时候执行对应订阅者的更新函数
function Dep () {
this.subs = [];
}
Dep.prototype = {  /**
 * [订阅器添加订阅者]
 * @param  {[Watcher]} sub [订阅者]
 */
 addSub: function(sub) {
 this.subs.push(sub);
 },  // 通知订阅者数据变更
 notify: function() {
 this.subs.forEach(function(sub) {
 sub.update();
 });
 }
};
Dep.target = null;
```

在 Observer 中，当初我看别人的源码时，我有一点不理解的地方就是 `Dep.target`是从哪里来的，相信有些人和我会有同样的疑问。这里不着急，当写到 Watcher 的时候，你就会发现，这个 `Dep.target`是来源于 Watcher。

## **实现一个 Watcher**

Watcher 就是一个订阅者。用于将 Observer 发来的 update 消息处理，执行 Watcher 绑定的更新函数。

**如下代码实现了一个 Watcher**

```
function Watcher(vm, exp, cb) {
this.cb = cb;
this.vm = vm;
this.exp = exp;
this.value = this.get();  // 将自己添加到订阅器的操作}

Watcher.prototype = {    update: function() {
this.run();
 },    run: function() {
 var value = this.vm.data[this.exp];
 var oldVal = this.value;
 if (value !== oldVal) {
 this.value = value;
 this.cb.call(this.vm, value, oldVal);
 }
 },    get: function() {
 Dep.target = this;  // 缓存自己
 var value = this.vm.data[this.exp]  // 强制执行监听器里的get函数
 Dep.target = null;  // 释放自己
 return value;
 }
};
```

在我研究代码的过程中，我觉得最复杂的就是理解这些函数的参数，后来在我输出了这些参数之后，函数的这些功能也容易理解了。vm，就是之后要写的 SelfValue 对象，相当于 Vue 中的 new Vue 的一个对象。exp 是 node 节点的 v-model 或 `v-on：click`等指令的属性值。

上面的代码中就可以看出来，在 Watcher 的 getter 函数中，`Dep.target`指向了自己，也就是 Watcher 对象。在 getter 函数中，

```
var value = this.vm.data[this.exp]  // 强制执行监听器里的get函数。
这里获取vm.data[this.exp] 时，会调用Observer中Object.defineProperty中的get函数
get: function getter () {
if (Dep.target) {
// 在这里添加一个订阅者
console.log(Dep.target)
dep.addSub(Dep.target);
}
return val;
},
```

从而把 watcher 添加到了订阅器中，也就解决了上面 `Dep.target`是哪里来的这个问题。

## **实现一个 Compile**

Compile 主要的作用是把 new SelfVue 绑定的 dom 节点，（也就是 el 标签绑定的 id）遍历该节点的所有子节点，找出其中所有的 v-指令和" { {}} ".

- （1）如果子节点含有 v-指令，即是元素节点，则对这个元素添加监听事件。（如果是 v-on，则 `node.addEventListener('click'）`，如果是 v-model，则 `node.addEventListener('input'))`。接着初始化模板元素，创建一个 Watcher 绑定这个元素节点。
- （2）如果子节点是文本节点，即" { { data }} ",则用正则表达式取出" { { data }} "中的 data，然后 `var initText = this.vm[exp]`，用 initText 去替代其中的 data。

## **实现一个 MVVM**

可以说 MVVM 是 Observer，Compile 以及 Watcher 的“boss”了，他需要安排给 Observer，Compile 以及 Watche 做的事情如下

- （1）Observer 实现对 MVVM 自身 model 数据劫持，监听数据的属性变更，并在变动时进行 notify
  （2）Compile 实现指令解析，初始化视图，并订阅数据变化，绑定好更新函数
  （3）Watcher 一方面接收 Observer 通过 dep 传递过来的数据变化，一方面通知 Compile 进行 view update。
  最后，把这个 MVVM 抽象出来，就是 vue 中 Vue 的构造函数了，可以构造出一个 vue 实例。

## 最后写一个 html 测试一下我们的功能

```
<!DOCTYPE html><html lang="en"><head>
 <meta charset="UTF-8">
 <title>self-vue</title></head><style>
 #app {
 text-align: center;
 }</style><body>
 <div id="app">
 <h2>{ {title}}</h2>
 <input v-model="name">
 <h1>{ {name}}</h1>
 <button v-on:click="clickMe">click me!</button>
 </div></body><script src="js/observer.js"></script>
 <script src="js/watcher.js"></script>
 <script src="js/compile.js"></script>
 <script src="js/mvvm.js"></script>
 <script type="text/javascript">
 var app = new SelfVue({
 el: '#app',
 data: {
 title: 'hello world',
 name: 'canfoo'
 },
 methods: {
 clickMe: function () {
 this.title = 'hello world';
 }
 },
 mounted: function () {
 window.setTimeout(() => {
 this.title = '你好';
 }, 1000);
 }
 });</script></html>
```

**先执行 mvvm 中的 new SelfVue(...)，在 mvvm.js 中，**

```
observe(this.data);
new Compile(options.el, this);
```

先初始化一个监听器 Observer，用于监听该对象 data 属性的值。
然后初始化一个解析器 Compile，绑定这个节点，并解析其中的 v-，" { {}} "指令，（每一个指令对应一个 Watcher）并初始化模板数据以及初始化相应的订阅者，并把订阅者添加到订阅器中（Dep）。这样就实现双向绑定了。
**如果 v-model 绑定的元素，**

**即输入框的值发生变化，就会触发 Compile 中的**

```
node.addEventListener('input', function(e) {
var newValue = e.target.value;
if (val === newValue) {
return;
 }
 self.vm[exp] = newValue;
 val = newValue;
 });
```

`self.vm[exp] = newValue;`这个语句会触发 mvvm 中 SelfValue 的 setter，以及触发 Observer 对该对象 name 属性的监听，即 Observer 中的 `Object.defineProperty（）`中的 setter。setter 中有通知订阅者的函数 `dep.notify`,Watcher 收到通知后就会执行绑定的更新函数。
最后的最后就是效果图啦：

![](../_resources/v2-23770e5bcfad60ce53217646e99a5_745d2b80260943c3b.jpg)

以上就是如何理解 vue 数据双向绑定原理的详细内容，更多请关注我！！！！！！！
