## 兼容问题

- getElementsByClassName() - 根据类名查找元素，在 IE9 之前无法使用

- querySelector() / querySelectorAll() - 根据选择器查找元素，在 IE9 之前无法使用

- getComputedStyle() - 获取元素的计算后的 css 样式表，在 IE9 之前无法使用

  - IE9 之前使用 `element.currentStyle` 属性获取计算后的样式表

- event - 事件对象，标准中是在事件处理程序（函数）中的第一个参数

  - function(event) { event = event || window.event }

- event.target - 事件源元素

  - event.target || event.srcElement

- event.stopPropagation() - 阻止事件传播

  - function(event) { if (event.stopPropagation) { event.stopPropagation() } else { event.cancelBubble = true } }

- event.preventDefault() - 阻止事件默认行为

  - 默认行为：点右键弹出浏览器快捷菜单、点链接跳转页面、提交表单全页面刷新到action页面、禁止图像资源拖拽......
  - function(event) { if (event.preventDefault) { event.preventDefault() } else { event.returnValue = false } }
  - 或 function(event) { return false }

- addEventListener() - 注册事件监听

  - ```js
      if (element.addEventListener) {
        element.addEventListener(eventType, callback, false)
      } else {
        eventType = 'on' + eventType
        element.attachEvent(eventType, callback)
      }
    ```

- removeEventListener() - 移除事件监听

  - ```js
    function off(element, eventType, callback) {
      if (element.removeEventListener) {
        element.removeEventListener(eventType, callback, false)
      } else {
        eventType = 'on' + eventType
        element.detachEvent(eventType, callback)
      }
    }
    ```

- document.documentElement：获取文档的根元素节点（html）

  - document.documentElement || document.body

- ................

ES5、ES6(ES2015及之后)

### 严格模式

`'use strict'`

### 内置对象新增API

String.prototype.trim() - 去掉字符串前后空白

- ```js
  function trim(str) {
      return str.replace(/^\s+|\s+$/g, '')
  }
  ```

### Map（集合）

Map 对象保存键值对，并且能够记住键的原始插入顺序。

#### 创建

```js
const map = new Map()
```

#### API

- set(key, value) - 保存 key- value 键值对
- get(key) - 根据 key 获取 value
- delete(key) - 根据 key 删除键值对
- clear() - 清空
- forEach() - 遍历迭代每个 key-value 键值对

### Set（集合）

Set 对象允许你存储任何类型的**唯一值**

#### 创建

```js
const set = new Set()
```

#### API

- add() - 向集合中添加保存数据
- forEach() - 遍历集合每个元素
- delete() - 删除集合中的元素
- clear() - 清空

#### 如：数组元素去重

```js
const newArray = Array.from(new Set(array))
```

### let / const

ES6 中新增定义变量的语法

### 模板字符串

```js
`使用反引号包含的字符串为模板字符串，可以使用 ${expression} 在字符串中拼接表达式文本内容`
```

### for ... of

遍历迭代可迭代对象（如数组或类数组对象）

of 之前所定义变量代表的是当前遍历到的元素值

### 箭头函数

是普通函数的简写形式，没有自己的 this、arguments、super、new.target 等

```js
(param1, param2, …, paramN) => { statements }

(param1, param2, …, paramN) => expression
//相当于：(param1, param2, …, paramN) =>{ return expression; }

// 当只有一个参数时，圆括号是可选的：
(singleParam) => { statements }
singleParam => { statements }

// 没有参数的函数应该写成一对圆括号。
() => { statements }
```

如：

```js
const add = function(a, b) {
    return a + b
}

// ==>
const add = (a, b) => {
    return a + b
}

// ==> 
const add = (a, b) => a + b
```

### 解构赋值

将数组或对象的属性保存到单个变量中

```js
const array = [2, 5, 7, 3, 9]
// const a = array[0], b = array[1], c = array.slice(2)
const [a, b, ...c] = array
```

### ... 运算符

- rest - 剩余的
- spread - 展开