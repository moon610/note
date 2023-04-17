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
- ......

事件监听器

事件处理程序：函数

事件源

## 事件流

处理事件的流程

### 事件捕获

从祖先节点到事件源元素节点之间进行事件传播的行为。

### 事件冒泡

集中式进行事件处理。事件源元素上的事件处理完毕后，会向父级及祖先节点进行事件传播的行为。

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

## 事件对象

event 对象，是事件处理程序(函数)的第一个参数

### API

#### 属性：

- type - 事件类型
- target - 最初触发事件的事件源

#### 方法：

- stopPropagation() - 阻止事件的传播
- preventDefault() - 阻止默认行为

## 事件委派（事件代理、事件委托）