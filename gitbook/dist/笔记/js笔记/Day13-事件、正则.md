# 事件

事件驱动模型：对于不同的动作行为，应用程序给予不同反馈。

事件

[事件类型](https://www.w3school.com.cn/jsref/dom_obj_event.asp)：

- click - 点击
- mousedown - 鼠标按下
- mouseup - 鼠标弹起
- mousemove - 鼠标移动
- mouseover / mouseenter - 鼠标移入
- mouseout / mouseleave - 鼠标移出
- keydown - 键盘按下
- keyup - 键盘弹起
- keypress - 键盘按压
- focus - 获得焦点
- blur - 失去焦点
- contextmenu - 右键快捷菜单
- scroll - 滚动
- load - 内容加载完毕
- ......

事件监听器

事件处理程序：函数

事件源

## 事件流

处理事件的流程

### 事件捕获

从祖先节点到事件源元素节点之间进行事件传播的行为。

### 事件冒泡

集中式进行事件处理。事件源元素上的事件处理完毕后，会向父级及组先节点进行事件传播的行为。

浏览器默认事件处理的方式是按照事件冒泡的方式进行事件处理。

### 事件流三个阶段：

- 事件捕获
- 处理目标
- 事件冒泡

## **注册事件监听（绑定事件）：**

将事件源、事件类型、事件处理程序关联在一起

在 JS 逻辑中：

```js
// 使用事件句柄来绑定事件
element.onxxx = function() {
    // 语句块，实现事件处理程序任务
}

// 调用 addEventListener() 方法来绑定事件
element.addEventListener('事件类型', 事件处理程序, 是否使用事件捕获)
```

在 HTML 标签中使用事件属性：

```html
<button class="btn" onclick="handleClick()">按钮</button>
```

### 事件处理程序中的 this:

在事件处理程序（函数）中的 this 可以指向绑定事件的事件源元素，但由于 this 在函数中指向是非常灵活的（根据执行上下文环境决定 this 指向哪个对象），所以在事件处理程序中，要获取事件源元素，更推荐使用 `event.target` 来获取。

## 事件对象

event 对象，是事件处理程序(函数)的第一个参数，但是对于 IE9 之前的浏览器，事件处理程序中没有 event 对象的参数，而是需要使用 window.event 获取。

### API

#### 属性：

- type - 事件类型
- target - 最初触发事件的事件源
- pageX / pageY - 获取光标在文档中的定位坐标
- clientX / clientY - 获取光标在当前可视视口中的定位坐标
- offsetX / offsetY - 获取光标在事件源(event.target)元素坐标系中的坐标
- keyCode - 键盘按键的虚拟键盘码
- which - 键盘按键编码 / 鼠标按键编码
- key - 键盘按键的物理值

#### 方法：

- stopPropagation() - 阻止事件的传播
- preventDefault() - 阻止默认行为

## 事件委派（事件代理、事件委托）

利用事件冒泡的特性，将后代元素上事件的处理委托给祖先元素去处理。

在事件委派过程中，可使用 `event.target` 获取最初触发事件的事件源元素。

事件委派带来的好处是，可以减少事件绑定的次数，可以为动态添加的节点也绑定事件

# 补充

元素的计算宽高：

- clientWidth / clientHeight：元素边框以内部分（不包括边框与滚动条）的宽高
- offsetWidth / offsetHeight：包括边框及以内的宽高

元素的计算定位位置：

- offsetLeft / offsetTop：计算元素在其有定位的父级中的位置
- offsetParent：查找其有定位的父级节点

滚动距离：

- scrollTop / scrollLeft：垂直 / 水平滚动距离

# 拖拽

- mousedown：鼠标在待拖拽的元素上按下，获取鼠标光标在拖拽的元素坐标系中的坐标位置
- mousemove：鼠标在文档中移动时，动态计算出拖拽的元素的定位位置：光标在文档中的坐标与光标在拖拽元素中的坐标求差值
- mouseup：鼠标弹起，应该取消鼠标的移动事件

# XSS

跨站脚本攻击。

[百度百科](https://baike.baidu.com/item/XSS%E6%94%BB%E5%87%BB/954065?fr=aladdin)

# 正则表达式

作用：用于对文本的格式进行校验

## 创建对象

```js
const reg = /pattern/attributes
const reg = new RegExp(pattern, attributes)
```

- pattern：正则表达式的模式
  - 方括号：
    - [a-z]：**匹配**方括号内的任意**一个**字符
    - [^abc]：匹配**不在**方括号内的字符
  - 元字符
    - `.` : 代表除换行和行结束符外的任意字符
    - `\w` ：代表单词字符：字母、数字、下划线
    - `\d` ：代表数字字符
    - `\s` ：代表空白字符，如空格、制表、回车、换行 ......
    - `\b` ：代表单词边界
  - 量词（出现的次数）
    - `+` ：表示最少出现一次
    - `?` ：表示最多出现一次
    - `*` ：表示能够出现任意多次（0到多次）
    - `{m}` ：表示固定出现 m 次
    - `{m,}` ：表示最少出现 m 次
    - `{m,n}` ：表示最少m次，最多n次
    - `^` ：表示开头
    - `$` ：表示结尾
- attributes：特性
  - `i` ：ignoreCase，表示忽略大小写
  - `g` ：global，表示全局匹配

## API

- test(str) - 测试参数字符串是否符合正则的规则
- exec() - 查找字符串中满足正则规则的文本，找到了则返回数组，未找到则返回 null。返回的数组中第一个元素是完整的规则匹配结果，如果有第二个或更多元素，则表示各分组的匹配结果