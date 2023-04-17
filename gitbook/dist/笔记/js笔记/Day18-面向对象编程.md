# 面向对象编程

OOP - 面向对象编程

万物皆对象

## 三大特性

- 封装（抽象）
- 继承：复用
- 多态：多种状态，复用

## 对象

属性：静态特征

方法：动作行为

对象就是一系列属性的无序集合

**对象属性调用：**

- 对象名.属性名
- 对象名[属性名索引字符串]

## 创建对象

### 对象直接量

```js
const stu = {
    name: '张三',
    age: 18,
    address: '四川成都',
    study: function() {
        console.log('学习')
    }
}
```

相当于：

```js
const stu = new Object()
stu.name = '张三'
stu.study = function() {
    console.log('学习')
}
// ......
```

### 工厂方式创建对象

```js
// 定义函数，创建学生对象
function createStudent(name, age, address) {
  const stu = new Object()
  stu.name = name
  stu.age = age
  stu.address = address
  stu.study = function() {
    console.log('学习')
  }
  return stu
}
```

通常工厂方式来创建对象，能够实现在函数主体中代码的复用，但对于创建后的各种对象类型的判断不方便

### 构造函数

```js
function Student(name, age, address) {
  this.name = name
  this.age = age
  this.address = address
  this.study = function() {
    console.log('学习')
  }
}
```

构造函数本质上就是一个函数，将使用 new 调用的函数称为构造函数，其主要**用作于创建对象，在创建对象时初始化对象的属性**

构造函数中使用 `this` 来表示当前所创建的对象本身

在命名规范上，构造函数的函数名采用大驼峰（帕斯卡命名规范）来命名：每个单词首字母都大写

### 构造函数 + 原型

```js
function Student(name) {
  this.name = name
}
// const Student = new Function('name', 'this.name = name')

Student.prototype.study = function() {
  console.log(this.name + ' 学习')
}

const stu1 = new Student('小明')
```

利用原型来复用方法。

### class (ES6)

语法糖，是构造函数 + 原型 的语法糖，JS 中没有真正的类

```js
class Student {
  // 构造函数
  constructor(name, age, sex) {
    this.name = name
    this.age = age
    this.sex = sex
  }

  // 成员方法
  study() {
    console.log('学习')
  }

  eat() {
    console.log('吃饭')
  }
}
```

## prototype 原型

可利用 prototype 原型来实现在对象中的属性复用：

```js
Student.prototype.study = function() {
  console.log(this.name + ' 学习')
}
```

每个函数都是一个特殊的对象，都拥有 `prototype` 属性，该属性是一个对象的结构，我们可以在 prototype 对象中添加自定义的属性，以复用自定义的数据。

### `__proto__`

每个对象都有一个特殊的属性：`__proto__`，其指向创建对象的构造函数中的 `prototype`，建立起对象与其原型之间的关联关系

Object.prototype 中的 `__proto__` 属性固定为 null

**原型链：**将对象的 `__proto__` 与其 `prototype` 所串联的结构称作原型链。原型链的终点是 `Object.prototype `

**总结：**

- prototype 通常被称为**原型对象**，`__proto__` 通常也被称为**原型属性**
- 每个函数都有 prototype 属性
- 每个对象（普通对象、函数）都有 `__proto__` 属性

- 通常将 prototype 理解为显式属性，`__proto__` 理解为隐式属性，如果是需要在代码中操作原型链的内容，通常修改的是 `prototype` 属性

### 对象属性查找

在调用对象属性进行使用时，会进行对象属性查找。

首先在对象自身的内存空间中查找属性，如果在自身内存空间中能够找到，则直接使用后结束查找；如果在自身内存空间中不能找到调用的属性，则到原型中进行查找，如果原型中能找到，则使用后结束查找，如果原型中也找不到，则继续到原型的原型中查找；以此类推。如果查找到最后，都不能找到要调用的属性，则返回 undefined。

## this

函数中 this 指向问题（面试）：

- 通常情况下，**谁调用指向谁**
- 如果函数是直接调用（函数名()），非严格模式下指向 window，严格模式下为 undefined
- 构造函数中的 this 通常指向的是 new 调用函数创建出来的对象本身
- 事件处理程序中的 this 通常指向的是绑定事件的事件源元素
- 箭头函数中没有 this（箭头函数不能作为构造函数使用）

### 改变 this 指向

可以调用相关方法在函数体内部修改 this 指向问题

```js
Function.prototype.call()
Function.prototype.apply()
Function.prototype.bind()
```

#### call、apply

作用：用于立即调用函数执行，在执行过程中，将 this 指向修改为第一个参数所表示的对象。如果调用 call、apply 时未传递第一个参数，或传递的是 null 、 undefined时，默认函数中的 this 指向全局(window)对象（在严格模式下为 undefined）

区别：apply 的第二个参数需要是数组或类数组对象，而 call 的第二个参数是一个可变参数

[3, 8, 2, 1, 7, 9, 4, 5]

#### bind

调用 bind() 后会返回一个新的函数，该返回的新函数主体与原函数一致，但函数体中的 this 指向被改为 bind() 方法第一个参数指向的对象