# Review

JavaScript 是单线程的应用，setTimeout、setInterval 是利用异步机制来实现定时的

Event Loop

setTimeout() 与 setInterval() 指定的定时时间到达后，不一定马上执行回调函数，可能会被延迟（受单线程主线程中执行效率的影响）

# DOM

Document Object Model (文档对象模型)

document 对象是 DOM 中最顶层的对象。

## DOM 树

节点：

层级：

- 父节点、子节点
- 兄弟：有共同父节点的节点间互为兄弟节点
- 根节点、叶子节点（终端节点）

类型：

**元素（标签）节点、文本节点**、属性节点、注释节点

## 在文档中获取元素的方法：

```js
document.getElementById(id) // 根据 id 查找元素节点，不能找到则返回 null，找到则返回对应的 DOM 元素对象
document.getElementsByTagName(tagname) // 根据标签名查找元素，返回集合（类数组对象），集合中包含了查找到的元素节点
document.getElementsByClassName(className) // 根据标签使用的 css 类名查找元素，返回集合（类数组对象），集合中包含了查找到的元素节点
document.getElementsByName(name) // 根据标签的 name 属性值查找元素，返回集合（类数组对象），集合中包含了查找到的元素节点

document.querySelector(selector) // 根据CSS选择器查找满足条件的第一个元素
document.querySelectorAll(selector) // 根据CSS选择器查找满足条件的所有元素
```

## 获取或设置元素节点的属性

```js
const value = element.getAttribute(name) // 根据标签的属性名获取对应的属性值
element.setAttribute(name, value) // 设置标签的属性

const value = element.<prop-name>
element.<prop-name> = value
```

## 节点本身的属性

```js
node.nodeType -- 节点的类型，返回数字，1 表示元素节点，3 表示文本节点
node.nodeName -- 节点名称，返回字符串，元素节点名称通常为标签的大写字符串，文本节点名称通常为：#text
node.nodeValue -- 节点值，文本节点返回节点中的文本值，元素节点固定返回 null
element.tagName -- 获取元素标签名
```

## 筛选层级节点

```js
node.parentNode // 获取节点的父节点
element.childNodes // 获取孩子节点，会包含所有的孩子文本节点、元素节点、注释节点等
element.children // 获取孩子元素节点
element.firstChild // 第一个孩子节点
element.firstElementChild // 第一个孩子元素节点
element.lastChild // 最后一个孩子节点
element.lastElementChild // 最后一个孩子元素节点
node.previousSibling // 前一个兄弟节点
node.previousElementSibling // 前一个兄弟元素节点
node.nextSibling // 后一个兄弟节点
node.nextElementSibling // 后一个兄弟元素节点
```

常用：parentNode、children、previousElementSibling、nextElementSibling

## 元素节点内部文本

```js
element.innerHTML -- 内部 html 文本
element.innerText -- 内部纯文本
element.textContent -- 内部纯文本
```

## 创建并添加节点

```js
const element = document.createElement('标签名') // 创建元素节点
const text = document.createTextNode('文本内容') // 创建文本节点

element.appendChild(node) // 在元素节点内部末尾追加孩子节点
element.insertBefore(newNode, oldNode) // 在 element 元素内部 oldNode 节点前插入 newNode 节点
```

## 删除节点

```js
node.parentNode.removeChild(node) // 从父节点中删除孩子节点
node.remove() // IE不支持(不建议)
```

## 克隆节点

```js
const clone = node.cloneNode(bool) // 克隆节点，bool 为 true 时，将后代节点也一并克隆
```

## CSSOM

```js
const _style = element.style // 获取行内（内联）样式，但不能获取到外部样式表文件中的样式
const _style = window.getComputedStyle(element, null) // 获取经过计算的样式（节点上最终起作用的样式），返回 CSSStyleDeclaration 类型的对象

element.style.<属性名> = '属性值' // 设置样式，通常都是设置为行内样式

const classnames = element.className // 获取所有的 class 类名字符串
const list = element.classList // 获取所有类名的列表，返回类数组对象，可使用 add()、remove() 等方法添加、删除类名
```

练习：

1. 输入行数，列数，动态生成一个表格，表格行实现隔行变色功能
2. 类似购物车操作
   1. 添加购物车商品
   2. 修改商品数量
   3. 删除选购商品
   4. 计算小计金额
   5. 计算合计金额
   6. ......