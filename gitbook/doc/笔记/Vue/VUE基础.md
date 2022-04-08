# MVVM

- M - Model，模型，数据
- V - View，视图
- VM - ViewModel

采用数据双向绑定（data-binding）：View的变动，自动反映在 ViewModel，反之亦然

# Vue

[官网](https://cn.vuejs.org/)

- v2.x
- v3.x

Vue **不支持** IE8 及以下版本，因为 Vue 使用了 IE8 无法模拟的 ECMAScript 5 （Object.defineProperty()）特性

安装两种版本：

- 开发版本：包含了警告与调试信息
- 生产版本：删除了与调试相关的信息，作了压缩混淆

## 声明式渲染

Vue.js 的核心是一个允许采用简洁的模板语法来声明式地将数据渲染进 DOM 的系统

```html
<div id="app">
    { { message }}
</div>

<script>
    const vm = new Vue({
      el: '#app', // element，代表了 view
      data: { // 代表了 Model
        message: 'Hello'
      }
    })
</script>
```

- el 表示关联的视图
- data 表示要渲染的数据
- 创建的 Vue() 实例相当于是 MVVM 架构中的 VM （ViewModel）
- 所有东西都是**响应式的**（数据被修改后，视图会自动重新渲染）

## Vue 实例

### 数据与方法

**数据：**

- 当一个 Vue 实例被创建时，它将 `data` 对象中的所有的 property 加入到 Vue 的**响应式系统**中，即会将 data 中定义的各属性直接挂载到 Vue 实例下，可以使用 Vue 实例直接调用到 data 中定义的各属性（如果 data 对象中有以 `$` 或 `_` 开头的属性，不会直接挂载到 Vue 实例下），当data中数据被更新时，会自动更新页面渲染。
- **只有当实例被创建时就已经存在于 `data` 中的 property 才是响应式的。**
- 在 vue 实例下有 `$data` 属性，代表的就是 data 对象。
- 在 vue 实例下有 `$options` 属性，代表的是创建 Vue 实例时的选项对象。

**方法：**

- 创建 Vue 实例时，在 `methods` 选项中定义的方法也会被直接挂载到 Vue 实例下。

## 模板语法

### 插值

#### 文本

```html
{ { expression }}
```

双花括号之间书写的是 JS 表达式，主要用于绑定渲染文本数据。

双大括号会将数据解释为普通文本，而非 HTML 代码。（对于 HTML 文本，{ {  }} 语法会进行转义处理，目的是为了避免出现 XSS 攻击）

#### html

v-html 指令

#### attrubutes

v-bind 指令

### 指令

就是在 HTML 标签中新添加的一些（以 `v-*` 开头的）有特殊意义的属性，利用这些属性，在 Vue 中可以实现相应的功能处理。

- v-html: 渲染 HTML 文本

- v-text: 渲染纯文本

- v-bind: 动态绑定属性值，在标签中绑定属性值是不能使用 `{ {}}` 语法，而是需要使用 `v-bind` 指令。可简写为 `:`

- v-on: 注册事件监听，可简写为 `@`，可以使用修饰符,v-on可以接受JavaScript代码，也可以接收一个方法名，还可以再内联JavaScript语句中调用方法,有时也需要在内联语句处理器中访问原始的 DOM 事件。可以用特殊变量 `$event` 把它传入方法：

  ````html
  <button v-on:click="counter += 1">Add 1</button>
    <!-- `greet` 是在下面定义的方法名 -->
  <button v-on:click="greet">Greet</button>
  <button v-on:click="say('hi', $event)">Say hi</button>
  ````

  **事件修饰符**：使用事件修饰符可以实现事件方法，避免了在方法中处理Dom事件细节，从而只需要考虑纯粹的数据逻辑。

  - `.stop` - 调用 `event.stopPropagation()`。
  - `.prevent` - 调用 `event.preventDefault()`。
  - `.capture` - 添加事件侦听器时使用 capture 模式。
  - `.self` - 只当事件是从侦听器绑定的元素本身触发时才触发回调。
  - `.{keyCode | keyAlias}` - 只当事件是从特定键触发时才触发回调。
  - `.native` - 监听组件根元素的原生事件。
  - `.once` - 只触发一次回调。
  - `.left` - (2.2.0) 只当点击鼠标左键时触发。
  - `.right` - (2.2.0) 只当点击鼠标右键时触发。
  - `.middle` - (2.2.0) 只当点击鼠标中键时触发。
  - `.passive` - (2.3.0) 以 `{ passive: true }` 模式添加侦听器

  事件修饰符可以串联，有先后顺序，前面的先执行，后面的后执行

  ```html
  <a v-on:click.prevent.self></a>
  <a v-on:clic.self.prevent></a>
  ```

  如：用 `v-on:click.prevent.self` 会阻止**所有的点击**，而 `v-on:click.self.prevent` 只会阻止对元素自身的点击。

  **按键修饰符**：Vue 允许为 `v-on` 在监听键盘事件时添加按键修饰符：

  ```html
  <input v-on:keyup.13="submit">
  ```

  常用按键码别名：

  - `.enter`
  - `.tab`
  - `.delete` (捕获“删除”和“退格”键)
  - `.esc`
  - `.space`
  - `.up`
  - `.down`
  - `.left`
  - `.right`

  可以用如下修饰符来实现仅在按下相应按键时才触发鼠标或键盘事件的监听器。

  - `.ctrl`

  - `.alt`

  - `.shift`

  - `.meta`

    ```html
    <!-- Ctrl + Click -->
    <div v-on:click.ctrl="doSomething">Do something</div>
    ```

- 与条件渲染相关：
  - v-if: 操作的是 DOM 树中节点的销毁、重建
  
  - v-else-if:
  
  - v-else:
  
  - v-show: 操作的是 CSS 样式中的 display
  
    ```html
    <div v-if="type === 'A'"> A </div>
    <div v-else-if="type === 'B'"> B </div>
    <div v-else> Not A/B </div>
    ```
  
    要在多个元素上使用v-if，可以使用`<temlpate>`元素包裹，并在上面使用v-if，最终渲染将不包含`<temlplate>`元素
  
    ```html
    <template v-if="ok">
      <p>Paragraph 1</p>
      <p>Paragraph 2</p>
    </template>
    ```
  
- **v-if vs v-show（面试）**：`v-if` 有更高的切换开销，而 `v-show` 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 `v-show` 较好；如果在运行时条件很少改变，则使用 `v-if` 较好。
  
- 与列表渲染相关：

  - v-for: 

  ```html
  <li v-for="item in array"></li>
  <li v-for="item of array"></li>
  <li v-for="(item, index) in array"></li>
  <li v-for="(item, index) of array"></li>
  
  <li v-for="value in object"></li>
  <li v-for="value of object"></li>
  <li v-for="(value, key) in object"></li>
  <li v-for="(value, key) of object"></li>
  <li v-for="(value, key, index) in object"></li>
  <li v-for="(value, key, index) of object"></li>
  
  <li v-for="n in number"></li>
  <!--渲染5次，从1到5-->
  <li v-for="n of 5"></li>
  ```

  - v-for 与 v-if 一起使用**（面试）**：**不推荐**同时使用 `v-if` 和 `v-for`。2.x 中当 `v-if` 与 `v-for` 一起使用时，`v-for` 具有比 `v-if` 更高的优先级；而 3.x 的版本中则反过来。
  - 建议尽可能在使用 `v-for` 时提供 `key` attribute，除非遍历输出的 DOM 内容非常简单，或者是刻意依赖默认行为以获取性能上的提升。使用了`key`属性后，Vue会检测key来复用元素，而不是每次都重复渲染。
  - 在自定义组件中使用v-for必须使用ke

- v-once: 只渲染元素和组件**一次**

- v-pre: 原样显示

- v-cloak: 这个指令保持在元素上直到关联实例结束编译。通常结合 css 规则：`[v-cloak] { display: none }` 一起使用，避免看到未经编译的视图模板内容。

- v-model: `v-model` 指令在表单 `<input>`、`<textarea>` 及 `<select>` 元素上替代value、option等创建双向数据绑定。

- v-solt: 具名插槽使用，可简写为`#`

## 计算属性与侦听器

### 计算属性

特点：

- 对复杂的逻辑表达式进行简化运算，方便阅读

- **计算属性值能够被缓存**，只要依赖项不发生变化，就会一直使用缓存的值。只在相关响应式依赖发生改变时它们才会重新求值。

  ```js
  computed: {
      attrbute: {
          // 计算属性的 getter
          get: function () {
              return this.activeClass === 'active'
          },
          //设置setter属性后计算属性就可以使用 = 赋值
          set: function (val) {
              return val
          }
      }
    }
  ```

  

#### vs method（面试）

- 计算属性可被缓存，方法不能被缓存
- **计算属性是基于它们的响应式依赖进行缓存的**。只在相关响应式依赖发生改变时它们才会重新求值。这就意味着只要依赖项还没有发生改变，多次访问计算属性会立即返回之前的计算结果，而不必再次执行函数，而方法每调用一次都会执行一次函数。

#### 为什么需要缓存？

假设我们有一个性能开销比较大的计算属性 **A**，它需要遍历一个巨大的数组并做大量的计算。然后我们可能有其他的计算属性依赖于 **A**。如果没有缓存，我们将不可避免的多次执行 **A** 的 getter！如果你不希望有缓存，请用方法来替代。

### 侦听器（侦听属性）

当需要在数据变化时执行异步或开销较大的操作时，使用侦听器这个方式是最有用的。

```js
watch: {
    message: function (val) {
        this.msg = 'change' + val
    }
}
```



#### vs 计算属性（面试）

- 计算属性可被缓存，侦听属性不能被缓存
- 侦听属性中可包含异步操作等动作，而计算属性中不能包含
- 计算属性通常是由一个或多个响应式数据计算出一个值返回；而侦听属性通常是监听一个数据的变化，由这一个数据的变化可能影响到另外的一个或多个数据的变化

## class 与 style 绑定

vue 对节点绑定 class 与 style 进行了功能增加，除了可以绑定字符串外，也可以绑定对象或数组。

### class绑定

```html
<div
  class="static"
  v-bind:class="{ active: isActive, 'text-danger': hasError }"
></div>
```

其中active这个class存在与否将取决于isActive的布尔值，v-bind:class也可以与普通的class attribute共存，也可以绑定计算属性来定义class对象，计算属性最后返回一个class对象值即可；

也可以把一个数组传给v-bind:class，数组中可以使用对象语法和三元运算符

```html
<div v-bind:class="[isActive ? activeClass :'',errorClass]"></div>
<div v-bind:class="[{ active: isActive }, errorClass]"></div>
```

当在一个自定义组件上使用 `class` property 时，这些 class 将被添加到该组件的根元素上面。这个元素上已经存在的 class 不会被覆盖。

```js
<!--声明组件-->
Vue.component('my-component', {
  template: '<p class="foo bar">Hi</p>'
})
```

使用组件时添加一些class：

```html
<my-component class="baz boo"></my-component>

<!--渲染结果为-->
<p class="foo bar baz boo">Hi</p>
```



### style绑定

```html
<div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
```

```js
data: {
  activeColor: 'red',
  fontSize: 30
}
```

css属性名可以使用小驼峰或者短横线分隔

直接绑定到一个样式对象上通常更好，这样模板更清晰

```html
<div v-bind:style="styleObject"></div>
```

```````js
data: {
  styleObject: {
    color: 'red',
    fontSize: '13px'
  }
}
```````

对象语法常常结合返回对象的计算属性使用

```html
<div v-bind:style="[baseStyles, overridingStyles]"></div>
```

使用数组语法可以将多个样式对象应用到同一个元素上

当 `v-bind:style` 使用需要添加浏览器引擎前缀的 CSS property 时，如 `transform`，Vue.js 会自动侦测并添加相应的前缀。

## 条件渲染

v-if、v-show 指令

**v-if vs v-show**

`v-if` 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。

`v-if` 也是**惰性的**：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。

相比之下，`v-show` 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。

一般来说，`v-if` 有更高的切换开销，而 `v-show` 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 `v-show` 较好；如果在运行时条件很少改变，则使用 `v-if` 较好。

## 列表渲染

v-for 指令

绑定 key

### 数组更新检测

#### 变更方法（变异方法）

调用这些方法后，原数组本身会受影响：

- push()
- pop()
- unshift()
- shift()
- splice()
- sort()
- reverse()

调用变更方法后修改数组后，页面会响应式渲染

#### 替换数组

如 slice() 、concat() 这类方法，调用后原数组本身不受影响，页面没有响应式渲染，如果需要将调用结果响应式渲染，可使用替换数组的方式，即利用 `=` 赋值运算符重新将数组数据值修改。

## 事件处理

v-on 指令

### 内联处理器中的方法

可以传递 $event 代表事件对象

### 事件修饰符：

- .stop
- .prevent

## 表单处理

v-model 指令

v-model 是语法糖。

`v-model` 会忽略所有表单元素的 `value`、`checked`、`selected` attribute 的初始值而总是将 Vue 实例的数据作为数据来源。你应该通过 JavaScript 在组件的 `data` 选项中声明初始值。

`v-model` 在内部为不同的输入元素使用不同的 property 并抛出不同的事件：

- text 和 textarea 元素使用 `value` property 和 `input` 事件；
- checkbox 和 radio 使用 `checked` property 和 `change` 事件；
- select 字段将 `value` 作为 prop 并将 `change` 作为事件。

```html
<input v-model="message" placeholder="edit me">
<input type="checkbox" id="checkbox" v-model="checked">
new Vue({
  el: '...',
  data: {
    checkedNames: []
  }
})
<select v-model="selected">
    <option disabled value="">请选择</option>
    <option>A</option>
</select>
```

**修饰符**：

`.lazy`：在默认情况下，`v-model` 在每次 `input` 事件触发后将输入框的值与数据进行同步。你可以添加 `lazy` 修饰符，从而转为在 `change` 事件之后进行同步

`.number`：将用户的输入值转为数值类型

`.trim`：自动过滤用户输入的首尾空白字符

## 过滤器

Vue.js 允许你自定义过滤器，可被用于一些常见的文本格式化。过滤器可以用在两个地方：**双花括号插值和 `v-bind` 表达式** (后者从 2.1.0+ 开始支持)。过滤器应该被添加在 JavaScript 表达式的尾部，由“管道”符号指示：

```js
<!-- 在双花括号中 -->
{ { message | capitalize }}

<!-- 在 `v-bind` 中 -->
<div v-bind:id="rawId | formatId"></div>
```

你可以在一个组件的选项中定义本地的过滤器：

```
filters: {
  capitalize: function (value) {
    if (!value) return ''
    value = value.toString()
    return value.charAt(0).toUpperCase() + value.slice(1)
  }
}
```

或者在创建 Vue 实例之前全局定义过滤器：

```
Vue.filter('capitalize', function (value) {
  if (!value) return ''
  value = value.toString()
  return value.charAt(0).toUpperCase() + value.slice(1)
})

new Vue({
  // ...
})
```

当全局过滤器和局部过滤器重名时，会采用局部过滤器。

## 组件系统

组件系统是 Vue 的另一个重要概念，因为它是一种抽象，允许我们使用小型、独立和通常可复用的组件构建大型应用。

在 Vue 里，一个组件本质上是一个拥有预定义选项的一个 Vue 实例。

### 定义组件

因为组件是可复用的 Vue 实例，所以它们与 `new Vue` 接收相同的选项，例如 `data`、`computed`、`watch`、`methods` 以及生命周期钩子等。仅有的例外是像 `el` 这样根实例特有的选项。

#### 选项

```js
const options = {
    // template 是关联视图的html模板
    template: `
		<h1>自定义的组件</h1>
	`,
    data: function () {
        return {
            message: 'hello'
        }
    }
}
```

一个组件的`data`选项必须是一个函数，因此每个对象实例可以维护一份被返回对象的独立的拷贝，如果不这样，一个组件实例被改变就会影响到其他组件实例。

#### 注册组件

**全局：**

```js
Vue.component(name, options)
//或者通过字面量
Vue.component(name, {
    // template 是关联视图的html模板
    template: `
		<h1>自定义的组件</h1>
	`
})
```

**局部：**

```js
new Vue({
    el: '#app',
    data: {
        message: 'hello'
    },
    components: {
        'sub-header': {
            template: `
                <h1>自定义的组件</h1>
              `
        }
    }
})
```

在父组件的选项对象中添加 `components` 字段，注册父组件中可以使用到的子组件（即局部注册）

#### 使用组件

将组件名作为自定义标签名来使用，使用标签名时，采用短横线命名规范（即多个单词之间使用 `-` 分隔）

### 组件的data 为什么必须是一个函数（面试）

组件是可被复用的，同一个组件创建出的不同实例彼此之间应该是相互独立的。对象是引用数据类型，如果组件选项中的 data 属性是一个普通对象，则同一个组件所创建出来的所有实例会共享（共用）同一个data对象的数据，则任意一个实例对 data 中数据修改时，其它实例都会受影响。

**将 data 定义为一个函数，在该函数体内部返回一个普通对象**，这样，当创建组件实例时，会调用 data() 方法，获取返回的新数据对象，则各组件实例间就有自己独立的数据对象了（互不受影响），这与实际开发更符合。

### 组件通信（面试）

组件与组件之间传递数据

#### 父子组件通信：

- **父传子：**利用 `props` 属性传递

  使用组件时数据不会自动传递到组件里，因为组件有自己独立的作用域。要将数据传到子组件里，我们要使用prop，在子组件中注册：

  ```js
  const options = {
      template: `
          <li> { {abc}} </li>
      `,
      props: ['todos']
  }
  ```

  一个组件默认可以拥有任意数量的 prop，任何值都可以传递给任何 prop。

  一个prop被注册之后，你就可以在父组件中把数据作为一个自定义attribute传递进来：

  ```html
  <todo-list-item :todos="Todo"/>
  ```

  - **子传父：**利用事件。在父组件中使用子组件时，绑定一个自定义事件；在子组件中需要传递数据时，触发($emit())在父组件中绑定的事件即可。

  ```html
  <!--父组件中-->
  <todo-input @add="addTodoItem" />
  <!--在子组件中通过事件处理传递数据-->
  <input @keydown.enter="handleAdd" />
  <script>
      handleAdd() {
          // 在子组件的事件处理函数中触发父组件中绑定的 add 事件，向父组件传递数据,父组件通过事件处理函数接收并处理数据
          this.$emit('add', this.inputVlaue)
      }
  </script>
  ```

  

#### 跨组件跨层级通信：

- 转换为父子组件通信
- event-bus（事件总线）：借助事件，将数据从一个组件中传递到另一个组件中。
  - 利用 Vue 对象实例的 `$on()` 与 `$emit()` 方法
  
  - `$on()` 用于注册事件监听
  
  - `$emit()` 用于触发指定的事件
  
  - 通信（传递数据）：在 Vue 原型上添加 $bus 属性；在需要接收数据的组件中，调用 `$on()` 注册事件监听，在需要传递数据的组件中，调用 `$emit()` 触发事件并传递数据
  
    ```js
    //1.向Vue 的原型中添加一个自定义的 $bus 属性用于在组件间传递数据（event-bus）
    //在Vue的原型中添加的属性，在每个Vue实例及组件实例中都可以通过原型链调用到该属性(在相应的js文件而不是.vue组件文件中)
    Vue.prototype.$bus = new Vue()
    //2.在接收数据的组件中调用$on注册事件监听，在生命周期中如created方法中注册，即当组件创建完成后执行
    created() {
        //在实例创建完成后执行
        this.$bus.$on('remove', this.removeTodoItem)//监听remove事件，调用removeTodoItem方法
    }
    //3.在发送数据的组件中调用$emit触发自定义的事件，传递数据
    handleRemve() {
        this.$bus.$emit('remove', this.item.id)
    }
    ```

- 使用vuex

### Props 属性

Prop 是你可以在组件上注册的一些自定义 attribute。当一个值传递给一个 prop attribute 的时候，它就变成了那个组件实例的一个 property。

props 是组件从父组件接收到的数据:

```js
{
    props: ['propName1', 'propName2']
}
```

- 可以简单定义一个数组，声明组件所能接收并处理的属性名称。
- 组件 props 属性中接收到的数据也会被直接挂载到组件实例下，可以直接打点调用
- 也可以将 props 定义为一个对象，可实现对属性的验证

```js
{
  props: {
    // 基础的类型检查 (`null` 和 `undefined` 会通过任何类型验证)
    propA: Number,
    // 多个可能的类型
    propB: [String, Number],
    // 必填的字符串
    propC: {
      type: String,
      required: true
    },
    // 带有默认值的数字
    propD: {
      type: Number,
      default: 100
    },
    // 带有默认值的对象
    propE: {
      type: Object,
      // 对象或数组默认值必须从一个工厂函数获取
      default: function () {
        return { message: 'hello' }
      }
    },
    // 自定义验证函数
    propF: {
      validator: function (value) {
        // 这个值必须匹配下列字符串中的一个
        return ['success', 'warning', 'danger'].indexOf(value) !== -1
      }
    }
  }
}
```

注意：

- props 应该是只读的，即不要修改组件获得到的属性值
- 如果业务中涉及到可能修改属性的值，则需要尝试转换为 data 或 computed 计算属性的方式重新设计。

#### 单个根元素

当构建一个组件时，你的模板如果包含多个元素，Vue会报错：`every component must have a single root element (每个组件必须只有一个根元素)。`你可以将模板的内容包裹在一个父元素内，来修复这个问题

## 单文件组件

后缀名为 `*.vue` 的文件，在 webpack 中处理该类型的文件，会使用 `vue-loader` 的 `loader` 来处理。

```vue
<template>
	<!-- View 布局结构 -->
</template>

<script>
	// JS 交互逻辑
</script>

<style>
	/* 样式 */
</style>
```

在 vs-code 中可安装 `Vetur` 插件，在 `*.vue` 文件中才会有代码高亮及部分代码提示功能。

### 插槽

作用：在使用组件时，向组件内部分发内容。可以是字符串、HTML标签或其他组件

使用：`<slot>``</slot>` 相当于是一个占位符，如果是非命名插槽，只能传一组数据，而命名插槽可以通过name传多组数据，当组件渲染时，`solt`标签内的内容将会被替换为传进来的内容。

`solt`标签内可以设置内容作为后备（默认）内容，当使用组件时没有传递任何数据就会使用默认内容渲染

规则：父级模板里的所有内容都是在父级作用域中编译的；子模板里的所有内容都是在子作用域中编译的。所以插槽中传递的数据只能是父作用域下的

#### 命名插槽（具名插槽）

`<slot name="slot-name">`

在使用具名插槽分发内容时，可以使用 `slot` 属性或 `v-slot` 指令

- slot 属性是 v2.6 之前版本中使用的
- v-slot 指令是 v2.6 中新增的语法，现在推荐使用 `v-slot` 指令
  - v-slot 指令需要用在 `<template>` 标签内部，即：`<template v-slot:slotName>`
  - `v-slot` 可以简写为 `#`

在组件中定义插槽

```html
<div class="container">
  <header>
    <slot name="header"></slot>
  </header>
  <main>
    <slot></slot>
  </main>
  <footer>
    <slot name="footer"></slot>
  </footer>
</div>
```

在父组件中使用插槽：

```html
<base-layout>
  <template v-slot:header>
    <h1>Here might be a page title</h1>
  </template>
  <p>A paragraph for the main content.</p>
  <p>And another one.</p>

  <template v-slot:footer>
    <p>Here's some contact info</p>
  </template>
</base-layout>
```

注意 **`v-slot` 只能添加在 `<template>` 上** (只有一种例外情况)，这一点和已经废弃的 `slot` attribute 不同。

独占默认插槽的缩写语法：当被提供的内容*只有*默认插槽时，组件的标签才可以被当作插槽的模板来使用。这样我们就可以把 `v-slot` 直接用在组件上：

## 生命周期

生命周期：指的是一个 Vue 实例或组件从开始创建，到最终销毁，全阶段所经历的所有过程。

<img src="https://img-blog.csdnimg.cn/7e691d8815944fcc8350d12e7f52327b.png" alt="在这里插入图片描述" style="zoom:200%;" />

### 生命周期钩子（函数）（面试）

就是在组件正常的生命周期过程中，提供了一些回调函数，在这些回调函数中可以添加用户自己的代码，完成特定的自定义功能。

### create 阶段

- beforeCreate()：在实例初始化之后，进行数据侦听和事件/侦听器的配置之前同步调用
- created() - 可以调用到 data 中的数据，在实例创建完成后被立即同步调用。在这一步中，实例已完成对选项的处理，意味着以下内容已被配置完毕：数据侦听、计算属性、方法、事件/侦听器的回调函数。然而，挂载阶段还没开始，且 `$el` property 目前尚不可用。

### mount 阶段

- beforeMount()：在挂载开始之前被调用：相关的 `render` 函数首次被调用。

  **该钩子在服务器端渲染期间不被调用。**

- mounted() - 实例被挂载后调用，这时 `el` 被新创建的 `vm.$el` 替换了。如果根实例挂载到了一个文档内的元素上，当 `mounted` 被调用时 `vm.$el` 也在文档内。

  注意 `mounted` **不会**保证所有的子组件也都被挂载完成。如果你希望等到整个视图都渲染完毕再执行某些操作，可以在 `mounted` 内部使用 vm.$nextTick

  **到该生命周期钩子函数中，才可以获取到渲染后的 DOM 节点**

### update 阶段

当数据发生变化时，会进行 update 更新阶段

- beforeUpdate()：在数据发生改变后，DOM 被更新之前被调用。这里适合在现有 DOM 将要被更新之前访问它，比如移除手动添加的事件监听器。

  **该钩子在服务器端渲染期间不被调用，因为只有初次渲染会在服务器端进行。**

- updated()：在数据更改导致的虚拟 DOM 重新渲染和更新完毕之后被调用。

  当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用[计算属性](https://cn.vuejs.org/v2/api/#computed)或 [watcher](https://cn.vuejs.org/v2/api/#watch) 取而代之。

  注意，`updated` **不会**保证所有的子组件也都被重新渲染完毕。如果你希望等到整个视图都渲染完毕，可以在 `updated` 里使用 [vm.$nextTick](https://cn.vuejs.org/v2/api/#vm-nextTick)

  **该钩子在服务器端渲染期间不被调用。**

### destroy 阶段

通常在销毁阶段会销毁哪些资源（面试）：启动的定时器、主动注册的事件监听、未完成的网络请求、打开的 socket 连接等

- beforeDestroy()：实例销毁之前调用。在这一步，实例仍然完全可用。

  **该钩子在服务器端渲染期间不被调用。**

- destroyed()：实例销毁后调用。该钩子被调用后，对应 Vue 实例的所有指令都被解绑，所有的事件监听器被移除，所有的子实例也都被销毁。

  **该钩子在服务器端渲染期间不被调用。**

## 渲染函数（render）-了解

简单的说，在vue中我们使用模板HTML语法来组建页面的，使用render函数我们可以用js语言来构建DOM。因为vue是虚拟DOM，所以在拿到template模板时也要转译成VNode的函数，而用render函数构建DOM，vue就免去了转译的过程。

当使用render函数描述虚拟DOM时，vue提供一个函数，这个函数是就构建虚拟DOM所需要的工具。官网上给他起了个名字叫createElement。还有约定它的简写叫h

```js
render(createElement) {
    // render
}
```

- createElement() 创建的虚拟节点元素
- createElement() 有三个参数：标签、属性、孩子节点

在组件中可以这样使用：

```js
Vue.component('anchored-heading', {
  render: function (createElement) {
    return createElement(
      'h' + this.level,   // 标签名称
      this.$slots.default // 子节点数组
    )
  },
  props: ['level']
})
```



### 虚拟DOM

[vue核心之虚拟DOM(vdom) - 简书 (jianshu.com)](https://www.jianshu.com/p/af0b398602bc)

```html
<div class="container">
    <span title="提示" class="_span">span_1</span>
    <a href="/">链接</a>
</div>
```

会被编译为 render() 渲染函数中的内容：

```js
render(createElement) {
    return createElement(
        'div',
        { className: 'container' },
        [
            createElement(
                'span',
                { title: '提示', className: '_span' },
                ['span_1']
            ),
            createElement(
                'a',
                { href: '/' },
                ['链接']
            ),
        ]
    )
}
```

调用后，返回一个对象：

```js
{
    tag: 'div',
    props: { className: 'container' },
    children: [
        {
            tag: 'span',
           	props: { title: '提示', className: '_span' },
            children: ['span_1']
        },
        {
            tag: 'a',
           	props: { href: '/' },
            children: ['链接']
        },
    ]
}
```

这是一个保存在内存中的虚拟 DOM 元素结构，这个结构与实体 DOM 树结构映射。Vue 通过建立一个**虚拟 DOM** 来追踪自己要如何改变真实 DOM。请仔细看这行代码：

```
return createElement('h1', this.blogTitle)
```

`createElement` 到底会返回什么呢？其实不是一个*实际的* DOM 元素。它更准确的名字可能是 `createNodeDescription`，因为它所包含的信息会告诉 Vue 页面上需要渲染什么样的节点，包括及其子节点的描述信息。

我们把这样的节点描述为“虚拟节点 (virtual node)”，也常简写它为“**VNode**”。“虚拟 DOM”是我们对由 Vue 组件树建立起来的整个 VNode 树的称呼。

- `Vnode`必须唯一：组件树中的所有VNode必须是唯一的，如果需要重复多次的元素/组件，可以使用工厂函数来实现
- 使用JavaScript代替模板功能，如v-if、v-for、v-model
- 事件&按键修饰符：对于 `.passive`、`.capture` 和 `.once` 这些事件修饰符，Vue 提供了相应的前缀可以用于 `on`

**JSX**：通过Babel插件，可以在Vue中使用JSX语法，他可以让我们回到接近模板的语法上

```html
render: function (h) { // h 表示createElement的别名
    return (
      <AnchoredHeading level={1}>
        <span>Hello</span> world!
      </AnchoredHeading>
    )
  }
```



## 响应式原理（了解）

### 数据劫持

当你把一个普通的 JavaScript 对象传入 Vue 实例作为 `data` 选项，Vue 将遍历此对象所有的 property，并使用 `Object.defineProperty` 把这些 property 全部转为 getter/setter。`Object.defineProperty` 是 ES5 中一个无法 shim 的特性，这也就是 Vue 不支持 IE8 以及更低版本浏览器的原因。

这些 getter/setter 对用户来说是不可见的，但是在内部它们让 Vue 能够追踪依赖，在 property 被访问和修改时通知变更。

每个组件实例都对应一个 **watcher** 实例，它会在组件渲染的过程中把“接触”过的数据 property 记录为依赖。之后当依赖项的 setter 触发时，会通知 watcher，从而使它关联的组件重新渲染。

```js
// 数据
    const data = {
      message: 'Hello'
    }
    // 布局模板
    const htmlTemplate = document.querySelector('#app').innerHTML
    // 渲染函数
    function render() {
      document.querySelector('#app').innerHTML = htmlTemplate.replace('{ { message }}', data.message)
    }
    render()
    // 数据劫持处理
    let _message = data.message
    Object.defineProperty(data, 'message', {
      configurable: true,
      enumerable: true,
      get() { // 用于获取属性值
        // TODO....
        return _message
      },
      set(val) { // 用于设置属性值
        _message = val
        // TODO.......
        render()
      }
    })
```



v2.x 版本中，使用 `Object.defineProperty()` 实现数据劫持

v3.x 版本中，使用 `Proxy` 实现数据劫持

### 声明响应式property

由于 Vue 不允许动态添加根级响应式 property，所以你必须在初始化实例前声明所有根级响应式 property，哪怕只是一个空值：

```js
var vm = new Vue({
  data: {
    // 声明 message 为一个空值字符串
    message: ''
  },
  template: '<div>{ { message }}</div>'
})
// 之后设置 `message`
vm.message = 'Hello!'
```

如果你未在 `data` 选项中声明 `message`，Vue 将警告你渲染函数正在试图访问不存在的 property。

### 异步更新队列

可能你还没有注意到，Vue 在更新 DOM 时是**异步**执行的。只要侦听到数据变化，Vue 将开启一个队列，并缓冲在同一事件循环中发生的所有数据变更。如果同一个 watcher 被多次触发，只会被推入到队列中一次。这种在缓冲时去除重复数据对于避免不必要的计算和 DOM 操作是非常重要的。然后，在下一个的事件循环“tick”中，Vue 刷新队列并执行实际 (已去重的) 工作。Vue 在内部对异步队列尝试使用原生的 `Promise.then`、`MutationObserver` 和 `setImmediate`，如果执行环境不支持，则会采用 `setTimeout(fn, 0)` 代替。

## keep-alive

`<keep-alive>` 包裹动态组件时，会**缓存**不活动的组件实例，而不是销毁它们。

当组件在 `<keep-alive>` 内被切换，它的 `activated` 和 `deactivated` 这两个生命周期钩子函数将会被对应执行。

## nextTick()--面试

在下次 DOM 更新循环结束之后执行延迟回调。

在修改数据之后立即使用这个方法，获取更新后的 DOM。

# Vue CLI

Vue CLI 是一个基于 Vue.js 进行快速开发的完整系统，其内部封装了 webpack 的相关配置。

## 安装

版本问题：

2.x 版本创建的项目，会在项目根目录中有多余的关于 webpack 配置的目录及文件。通常是 `config` 与 `build` 目录及目录内的文件。

3.x/4.x 版本创建的项目，是将 webpack 的配置专门封装到npm包中，在项目根目录下没有相关的 webpack 配置文件存在。

全局安装 vue-cli:

```bash
$ npm install -g @vue/cli
```

安装成功后，可在 cmd 命令提示符下执行 `vue --version` 测试查看版本信息：

```bash
$ vue --version
```

## 创建项目

图形化用户界面（GUI）：

```bash
$ vue ui
```

命令行：

1. 执行创建项目命令：

```bash
$ vue create vue-cli-demo
```

2. 开始利用向导选择项目中使用到的特性：

```bash
Please pick a preset:

> Manually select features
```

3. 确认项目中的特性：

```bash
Check the features needed for your project: (Press <space> to select, <a> to toggle all, <i> to invert selection)

>(*) Choose Vue version
>(*) Babel
>(*) CSS Pre-processors
>(*) Linter / Formatter
```

4. 选择 vue 版本：

```bash
Choose a version of Vue.js that you want to start the project with (Use arrow keys)
> 2.x
```

5. 选择 css 预处理器：

```bash
Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported by default): (Use arrow keys)
> Sass/SCSS (with node-sass)
```

6. 选择 ESLint

```bash
Pick a linter / formatter config: (Use arrow keys)
> ESLint + Standard config
```

7. 保存代码时验证代码是否符合规范

```bash
Pick additional lint features: (Press <space> to select, <a> to toggle all, <i> to invert selection)
>(*) Lint on save
```

8. 选择在独立文件中保存配置文件

```bash
Where do you prefer placing config for Babel, ESLint, etc.? (Use arrow keys)
> In dedicated config files
```

9. 是否将此前步骤中的选择保存为模板供以后创建项目使用

```bash
Save this as a preset for future projects? (y/N) N
```

10. 自动根据前述选择，开始创建项目结构并安装依赖资源

## package.json

### npm scripts

```json
{
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint"
  },
}
```

- serve：启动开发环境的任务，会打开开发环境下的 webpack-dev-server 服务器，默认监听 8080 端口
- build：启动构建任务，主要用于构建生产环境下的代码
- lint：启动规范格式化任务，可将不满足规范的代码格式化

可以使用 `npm run` 执行

### 关于 @vue/cli-service 包

内部封装了 webpack 配置，`npm scripts` 中的任务执行就依赖于这个包。

## 项目目录结构

```bash
|--project
|--public # 单页面应用页面所在目录
|--src # 源代码
|--|--main.js # 应用的入口JS文件
|--|--App.vue # 单文件组件
|--.eslintrc.js # eslint 规范配置文件
|--babel.config.js # babel 配置文件
|--package.json # 应用配置文件
```

# Vuex

Vuex 是一个专为 Vue.js 应用程序开发的**状态管理模式**。

采用**集中式**存储管理应用的所有组件的状态，并以相应的规则保证**状态以一种可预测的方式发生变化**。

通常使用 vuex 来管理应用中各组件会共享共用的数据。

每一个 Vuex 应用的核心就是 store（仓库）。“store”基本上就是一个容器，它包含着你的应用中大部分的**状态 (state)**。Vuex 和单纯的全局对象有以下两点不同：

1. Vuex 的状态存储是响应式的。当 Vue 组件从 store 中读取状态的时候，若 store 中的状态发生变化，那么相应的组件也会相应地得到高效更新。
2. 你不能直接改变 store 中的状态。改变 store 中的状态的唯一途径就是显式地**提交 (commit) mutation**。这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。

## 概念

- store：仓库，是一个容器，包含着你的应用中大部分的**状态 (state)**

- state：状态，组件需要共享的数据

- getter：是 store 中的计算属性，相当于组件中的 computed，Vuex 允许我们在 store 中定义“getter”（可以认为是 store 的计算属性）。就像计算属性一样，getter 的返回值会根据它的依赖被缓存起来，且只有当它的依赖值发生了改变才会被重新计算。

  Getter 接受 state 作为其第一个参数,也可以接受其他getter作为第二个参数

  ```js
  getters: {
      doneTodos: (state, getters) => {
        return state.todos.filter(todo => todo.done)
      }
    }
  ```

  getter可以通过**属性**访问，在通过属性访问时是作为 Vue 的响应式系统的一部分缓存其中的；也可以通过**方法**访问，通过getter返回一个函数，来实现给getter传参

  ```js
  store.getters.doneTodos // 通过属性访问
  getters: {
    // ...
    getTodoById: (state) => (id) => { // 在getter中返回函数
      return state.todos.find(todo => todo.id === id)
    }
  }
  store.getters.getTodoById(2) // 通过方法访问
  ```

  

- mutation：是函数结构，修改状态数据，用于进行 state 的**同步更新**，约定，**mutation 是唯一能够进行状态更新的位置**

  Vuex 中的 mutation 非常类似于事件：每个 mutation 都有一个字符串的 **事件类型 (type)** 和 一个 **回调函数 (handler)**。这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数：

  ```js
  const store = new Vuex.Store({
    state: {
      count: 1
    },
    mutations: {
      increment (state) {
        // 变更状态
        state.count++
      }
    }
  })
  ```

  mutation更像是事件注册，不能直接调用，要以相应的type调用`sotre.commit`方法

  ```js
  store.commit('increment')
  ```

  提交mutation 的另一种方式是直接使用**包含`type`属性的对象**，当使用对象风格的提交方式，整个对象都作为载荷传给 mutation 函数，因此 handler 保持不变

  ```js
  mutations: {
    increment (state, payload) {
      state.count += payload.amount
    }
  }
  ```

  ```js
  store.commit({
    type: 'increment',
    amount: 10
  })
  ```

  在**组件**中使用 `this.$store.commit('xxx')` 提交 mutation

  **提交载荷**：你可以向 `store.commit` 传入额外的参数，即 mutation 的 **载荷（payload）**，载荷可以是一个变量，但大多数情况应该是一个对象：

  ```js
  mutations: {
    increment (state, payload) {
      state.count += payload.amount
    }
  }
  ```

  ```js
  store.commit('increment', {
      amount: 10
  })
  ```

  

- action：是函数结构，类似于mutation，区别是：

  - Action 提交的是 mutation，而不是直接变更状态。
  - Action 可以包含任意异步操作。

  Action 通过 `store.dispatch` 方法触发：

  ```js
  store.dispatch('increment')
  ```

   在**组件中**使用 `this.$store.dispatch('xxx')` 分发 action

  **mutation 必须同步执行**，而Action 就不受约束！我们可以在 action 内部执行**异步**操作：

  ```js
  actions: {
    incrementAsync ({ commit }) {
      setTimeout(() => {
        commit('increment')
      }, 1000)
    }
  }
  ```

   `store.dispatch` 可以处理被触发的 action 的处理函数返回的 Promise，并且 `store.dispatch` 仍旧返回 Promise：

  ```js
  actions: {
    // ...
    actionB ({ dispatch, commit }) {
      return dispatch('actionA').then(() => {
        commit('someOtherMutation')
      })
    }
  }
  ```

  注意：一个 `store.dispatch` 在不同模块中可以触发多个 action 函数。在这种情况下，只有当所有触发函数完成后，返回的 Promise 才会执行。

- module：模块，可将 store 分割成一个个的小的 module，各 module 有自己的 state、getter、mutation、action，甚至子 module

## 使用

### 安装

```bash
$ npm i vuex
```

### 创建 store

```js
import Vue from 'vue'
import Vuex from 'vuex'

// 使用核心插件 Vuex
Vue.use(Vuex)

// 创建 Store
const store = new Vuex.Store({
  state: {
      // todos 中保存所有待办事项，在 todo-input、todo-list 组件中都会使用到
    todos: [{
      id: 1,
      title: '复习 JavaScript',
      completed: false
    }]
  },
  getters: {},
  mutations: { // 唯一进行状态更新的地方
      removeTodoItem(state, id) {
      state.todos = state.todos.filter(todo => todo.id !== id)
    },
    addTodoItem(state, title) {
      state.todos.push({
        id: state.length + 1,
        title,
        completed: false
      })
  },
  actions: {},
  modules: {}
})

// 导出
export default store
```

### 注入到 Vue 根实例中

```js
import Vue from 'vue'
import store from './store'

new Vue({
    // ...
    store
})
```

将 store 注入 Vue 根实例后，在所有的组件实例中，都可以使用 `this.$store` 调用到 `store` 对象

```js
handleModify() {
  // 调用 store 中 mutation 方法，实现状态更新
  // mutation 方法不能直接被调用到，而是需要使用
  // $store.commit(type, payload) 来提交 mutation
  this.$store.commit('toggleTodoItem', this.item.id)
}
```



### 编写 state及更新 state 的mutation

```js
mutations: {
    modifyState (state, id) {
      state.todos.forEach(current => {
        if (current.id === id) {
          current.state = !current.state
        }
      })
    },
    removeItem (state, id) {
      state.todos = state.todos.filter(current => {
        return current.id !== id
      })
    }
}
```



### 组件中调用 state 及 mutation

```js
{
    computed: {
        todos() {
            this.$store.state.todos
        }
    },
    methods: {
        handler() {
            this.$store.commit('mutation-type', 'payload')
        }
    }
}
```

注意，在组件中不能直接调用到 mutation 方法，而是需要使用 `$store.commit()` 来提交 `mutation` （类似于使用 $emit() 触发事件）

也可以使用 `mapMutations` 辅助函数将组件中的 methods 映射为 `store.commit` 调用（需要在根节点注入 `store`）

```js
import { mapMutations } from 'vuex'
export default {
  // ...
  methods: {
    ...mapMutations([
      'increment', // 将 `this.increment()` 映射为 `this.$store.commit('increment')`

      // `mapMutations` 也支持载荷：
      'incrementBy' // 将 `this.incrementBy(amount)` 映射为 `this.$store.commit('incrementBy', amount)`
    ]),
    ...mapMutations({
      add: 'increment' // 将 `this.add()` 映射为 `this.$store.commit('increment')`
    })
  }
}
```

### 严格模式

# SPA

**S**ingle **P**age **A**pplication

单页面应用

是只有一张Web页面的应用，是加载单个HTML 页面并在用户与应用程序交互时动态更新该页面的Web应用程序。

浏览器一开始会加载必需的HTML、CSS和JavaScript，所有的操作都在这张页面上完成，都由JavaScript来控制。

## 前端路由

前端路由，不会发送 html 页面请求到服务器，就能直接实现界面切换（是在 JS 中完成）。

由于是单页面应用，服务器上只保存了一个 html 页面，所以浏览器访问到该页面时，也会将引用的 js 下载到浏览器本地。

在页面中仍然存在超级链接可以点击切换页面，但这种切换页面并不是真正访问服务器上的 html 页面，而是通过 JS 来实现界面切换（DOM操作）。

```js
window.onhashchange = function() {
  console.log('hash change', location.hash)
  switch(location.hash) {
    case '#home':
      document.querySelector('.page').innerHTML = '这是首页'
      break
    default:
      document.querySelector('.page').innerHTML = '404'
  }
}
```



### 模式

- hash：在URL中采用#号来作为当前视图的地址，改变#号后的参数，页面并不会重载。
- history：利用 h5 中 history 新增的 API: pushState()、replaceState() ，在调用这些 API 时不会发送新的请求到后端（页面不会重新加载）。
  - history 模式的路由表面上与访问服务端的路由一致（相比 hash 模式来说，没有 `#`）
  - history 模式的路由使用需要在服务器上进行相关配置

# Vue Router

Vue.js 官方的路由管理器

## 使用

### 安装

```bash
$ npm i vue-router
```

### 创建 VueRouter 实例

```js
import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home'
import About from '../views/About'
import Profile from '../views/Profile'

// 使用 vue-router 核心插件
Vue.use(VueRouter)

// 创建 VueRouter 实例
const router = new VueRouter({
  mode: 'hash', // 前端路由模式：hash、history
  routes: [ // 静态路由配置信息
    {
      path: '/home',
      component: Home
    }
  ]
})

export default router
```

### 注入到 Vue 根实例中

```js
import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
```

将 router 注入 Vue 根实例后，可在后代组件中使用到两个属性（面试）：

- `$router`：指代的是 VueRouter 实例
- `$route`：当前激活的路由

## 两个组件

- `<router-link>`：链接，导航，默认会渲染为 `<a>` 超级链接
- `<router-view>`：占位，将满足路径中当前访问路由对应的 `component` 组件进行渲染。

## 路由元信息

在进行路由相关功能开发时，需要与当前路由相关使用到的数据，可以携带在元信息中，使用`meta`字段表示。

## 命名视图

有时候想同时(同级)展示多个视图，而不是嵌套展示，例如创建一个布局， 有sidebar (侧导航)和main (主内容)两个视图,这个时候命名视图就派上用场了。
为`<router-view /`组件添加`name`属性(即命名视图)， 可使用对应名称指定在`<router-view />`视图中
渲染的组件。如果`<router-view >`没有`name`属性,其`name`值默认为`default`

## 命名路由

是在路由配置项中添加 `name` 属性，有时候，通过一个名称来标识一个路由显得更方便一些，特别是在链接一个路由，或者是执行一些跳转的时候

## 编程式的导航

除了使用`<router-link />`创建 a 标签来订导航链接，我们还可以借助 router 的实例方法，通过编写代码来实现。

```js
router.push(location) - 会添加历史记录
router.replace(location) - 不会添加历史记录
router.back()
router.forward()
router.go()
```

参数： 

- 可取字符串 this.$router.push('/home')
- 也可取对象this.$router.push({})
  - `{path, query}`
  - ` {name, params}`
  - 注意： params 必须与 name 配合，不能与 path 共存
  - 通常`query`这个单词与传递查询字符串（？）参数有关，`params`这个单词与传递动态路由参数(/path/to/:params)有关

**路由重定向**

在路由中配置

```js
const routes = [
    ...
    {
        path: '/',
        redirect: '/home'， // 访问根路径时重定向到/home
    }
]
```

## 嵌套路由

通常对应组件的嵌套结构

## 导航守卫

作用：守卫导航

导航守卫主要用来通过跳转或取消的方式守卫导航

### 钩子函数

#### 全局

- **beforeEach(callback) - 全局前置守卫，可以在这个钩子函数中进行用户权限拦截**
  - 回调函数有三个参数：to、from、next
  - to：即将进入的目标路由对象
  - from：正要离开的路由
  - next：下一步，是在导航解析流程中的“下一步”，是一个函数结构。
    - next()：正常走下一步
    - next(false)：中断导航
    - next(path)：重新跳转到新地址
    - **确保 `next` 函数在任何给定的导航守卫中都被严格调用一次。它可以出现多于一次，但是只能在所有的逻辑路径都不重叠的情况下，否则钩子永远都不会被解析或报错**。
- beforeResolve()
- afterEach()

#### 路由独享

- beforeEnter()

#### 组件内

- beforeRouteEnter() - **不能独 this 获取到组件实例**，如果需要使用组件实例，则在 next(callback) 的回调函数中会传递组件实例作为参数

- beforeRouteUpdate() - 在重用的组件中被调用到

- beforeRouteLeave()

# UI 组件库

[常见UI组件库](https://segmentfault.com/a/1190000021876315)

PC端

- [Element UI](https://element.eleme.cn/#/zh-CN)
- [iView](https://www.iviewui.com/)
- [ant design of vue](https://www.antdv.com/docs/vue/introduce-cn/)

移动端

- [mint-ui]( http://mint-ui.github.io)
- [vant](https://vant-contrib.gitee.io/vant/#/zh-CN/)

## 使用

以 Element-UI 组件库为例：

### 安装

```bash
$ npm i element-ui
```

### 引入

#### 全部引入

将组件库中的所有组件一次性引入项目中，在使用组件时，不需要再考虑引入哪些就可以直接使用。

缺点：在打包构建时，项目中未使用到的组件也会打包进最后的 bundle 中，会增大代码包的体积。

```js
// 在 main.js 中引入：
// ......
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI)
```

#### 按需引入

是组件库中使用到哪个组件时，才引入使用，未使用到的不需要引入。

优点：可以有效的保证打包后代码包的体积最优

缺点：比较繁琐

安装 babel 插件包：

```bash
$ npm install babel-plugin-component -D
```

配置 babel 相关（修改 `babel.config.js` 配置文件）：

```js
module.exports = {
  presets: [
    '@vue/cli-plugin-babel/preset'
  ],
  plugins: [
    [
      'component',
      {
        libraryName: 'element-ui',
        styleLibraryName: 'theme-chalk'
      }
    ]
  ]
}
```

在自定义的组件中引入 ElementUI 组件：

```js
// main.js
// 按需引入
import {
  Button,
  DatePicker,
  Badge
} from 'element-ui'

// 全局注册组件
Vue.component(Button.name, Button)

// 也可以写作：
Vue.use(DatePicker)
Vue.use(Badge)

// 在组件中仍然使用 <el-xxx> 来使用到 ElementUI 组件
```



注意：全部引入与按需引入通常不能共存

## vue-element-admin

[文档](https://panjiachen.github.io/vue-element-admin-site/zh/)

[演示地址](https://panjiachen.github.io/vue-element-admin)

# 网络请求

- ajax
- [fetch API](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API)
- [axios](http://www.axios-js.com/)
- [vue-resource](https://www.npmjs.com/package/vue-resource)

## axios

- 浏览器中对 XMLHttpRequest 进行封装
- 支持 Promise API
- 支持请求/响应拦截处理
- 支持取消请求

