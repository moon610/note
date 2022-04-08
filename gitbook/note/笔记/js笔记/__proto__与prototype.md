[JS prototype与\_\_proto\_\_的联系与区别\_fivedoumi的专栏-CSDN博客\_prototype与\_\_proto\_\_的关系与区别](https://blog.csdn.net/fivedoumi/article/details/51282593)
[Javascript中的原型链、prototype、\_\_proto\_\_的关系 - 最骚的就是你 - 博客园 (cnblogs.com)](https://www.cnblogs.com/libin-1/p/5955208.html)
[动图解释JS中的原型链 (shuaihuajun.com)](http://www.shuaihuajun.com/article/1475371211000/index.html)

在JavaScript里，没有类的概念，所有东西都是对象，这并没有什么问题,不过，我们必须承认，类的思想会给工程问题带来很多方便，所以，在JavaScript的不断发展中，一些需求也催生了JavaScript想模仿类这个概念。比如说，如果你想构建一个有一定规模的项目，那你必然会涉及到一些继承问题，而这种继承问题，在Java中就是用类来解决的，那在JavaScript中，我们该怎么办？当然有办法，那就是模仿，我们没有类，但我们可以模仿类，而且随着时代的发展，我们有了更好的方法。prototype与`__proto__`都是在这个过程中催生的产物

`__proto__`属性是对象独有的，prototype属性是Function独有的。但是JS中函数也是一种对象，所以函数也有`__proto__`属性。
首先举一个简单的例子：

```js
 function Foo(name) {
        this.name = name
 }
 let f1 = new Foo();
```

上面的代码表示创建一个构造函数Foo()，并用new关键字创建一个构造函数的实例f1，虽然只有两行代码，但他们背后的关系确是错综复杂的，如下图：

![761f27122cb12af4c69a655d9796b1e3.png](https://gitee.com/herrry/image-repository/raw/master/img/202203132206213.png)

第一步，Foo函数被执行。Foo函数在f1的作用域下被执行，所以这里this指代的就是f1，这样name属性才会被当做f1的属性被创建，如果你在函数Foo中写一个console.log()语句，它也会在结果中打印出来.
第二步，将f1.\_\_proto\_\_指向Foo.prototype。这才是javascript构造函数的精髓所在，之后foo就继承了Foo.prototype中（以及其原型链上）的属性与方法。

- \_\_proro\_\_属性：由一个对象指向另一个对象，即指向他们的原型对象（也可以理解为父对象），它的作用就是当访问一个对象的属性时，如果该对象内部不存在这个属性，那么就会去它的\_\_proto\_\_属性所指向的那个对象（父对象）里找，如果父对象也不存在这个属性，则继续往上找，直到原型链的终点null。以上这种通过\_\_proto\_\_属性来连接对象直到终点null的一条链即为原型链。我们平时调用的字符串方法、数组方法、对象方法等都是靠\_\_proto\_\_继承而来的。
  
- prototype：它是函数独有的，从一个函数指向一个对象。它的含义是函数的原型对象，也就是这个函数所创建的实例的原型对象。prototype的作用就是包含可以由特定类型的所有实例共享的属性和方法，也就是让该函数所实例化的对象都可以找到公用的属性和方法。任何函数在创建的时候都会默认创建该函数的prototype对象
  

**`__proto__`是真正用来查找原型链去获取方法的对象。**
**prototype是在用new创建对象时用来构建`__proto__`的对象。**

[参考 帮你彻底搞懂JS中的prototype、`__proto__`与constructor（图解）_码飞_CC的博客-CSDN博客](https://blog.csdn.net/cc18868876837/article/details/81211729)