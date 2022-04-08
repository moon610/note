# Review

http

ajax

跨域

本地存储

Promise

# 设计模式

[文档](https://www.runoob.com/design-pattern/design-pattern-tutorial.html)

设计模式是软件开发人员在软件开发过程中面临的一般问题的解决方案。这些解决方案是众多软件开发人员经过相当长的一段时间的试验和错误总结出来的。

## 单例模式（Singleton Pattern）

提供了一种创建对象的最佳方式。

保证一个类仅有一个实例，并提供一个访问它的全局访问点。

JS 中的实现：

```js
// 最简单的单例：对象直接量
const obj = {
  method: function() {
    console.log('方法')
  }
}
```

```js
// IIFE
// 饿汉式单例
const Player = function() {
  function Player(list = []) {
    this.list = list
  }
  Player.prototype.setList = function(list) {
    console.log('设置播放列表')
    this.list = list
  }
  Player.prototype.play = function() {
    console.log('播放：', this.list)
  }
  Player.prototype.start = function() {
    console.log('开始...')
    this.play()
  }

  return new Player()
}()
```

```js
// 懒汉式单例
const Player = (function() {
  class Player {
    constructor(list) {
      this.list = list
    }

    setList(list) {
      this.list = list
    }

    play() {
      console.log('播放...')
    }

    start() {
      console.log('开始')
      this.play()
    }
  }

  let _instance = null

  return {
    getInstance() {
      if (_instance === null) {
        _instance = new Player()
      }
      return _instance
    }
  }
})()
```

## 工厂模式（Factory Pattern）

主要用于创建对象，在工厂模式中，我们在创建对象时不会对客户端暴露创建逻辑，并且是通过使用一个共同的接口来指向新创建的对象。

## MVC

- **M**odel
- **V**iew
- **C**onstroller

# 创建对象

- 直接量 / new Object()
- 工厂方式：利用函数的封装实现创建对象代码的复用
- 构造函数
- 构造函数 + 原型
- class

# 原型（prototype）

prototype：原型对象，每个函数都有 prototype 属性

`__proto__`：原型属性，每个对象都有 `__proto__` 属性，该属性指向创建对象的构造函数下的 `prototype`

由 `__proto__` 与其对应的 `prototype` 所串联的结构被称为“原型链”

对象属性查找时，会通过原型链进行查找。

# call、apply、bind

call()、apply() 作用：立即调用函数执行，在函数执行过程中，将 this 指向修改为第一个参数表示的对象，没有第一个参数，或传递的是 null、undefined时，表示的是修改为 `window` 对象。

bind() 作用：返回新函数，当新函数被调用执行时，函数体内部的 this 被修改为 第一个参数 表示的对象

# 继承

实现代码复用，方便维护

## 构造函数

```js
function Person(name, age, sex) {
  this.name = name
  this.age = age
  this.sex = sex
}

function Student(name, age, sex, courses) {
  Person.call(this, name, age, sex)
  this.courses = courses
}
```

## 原型链继承

```js
Student.prototype = new Person()
// 更推荐下边的写法
Student.prototype = Object.create(Person.prototype)
```

## 组合继承

构造函数继承 + 原型链继承

## class 继承

```js
class Student extends Person {
  constructor(name, age, sex, courses) {
    // 调用父类的构造函数
    super(name, age, sex)
    // 子类特征
    this.courses = courses
  }

  study() {
    console.log('学习')
  }

  sleep() {
    this.study()
    super.sleep()
  }
}
```

