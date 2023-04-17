常见 JS 库：

- jQuery
- prototype.js
- yui
- dojo
- .........

# jQuery

[官网](https://jquery.com/)

[在线中文文档](https://jquery.cuishifeng.cn/)

## 特点

- 小巧、快速、富应用
- API 丰富易用、文档详细
- 对常用的 DOM 操作、事件处理、ajax、运动等进行了封装
- 解决了浏览器兼容问题
- 支持 CSS 选择器及jQuery自身的选择器的使用
- 有丰富的插件
- 支持链式调用
- ......

## 版本

1.x

2.x

3.x

## 使用

下载

引入

## API

### 核心

- jQuery(selector) / $(selector)：在全局范围内，$ 与 jQuery 是等价的，根据选择器查询元素，返回 jQuery 对象实例（是一个类数组对象），在 jQuery 对象实例中包装了查找到的 DOM 元素
- $(dom)：将 DOM 对象包装成 jQuery 对象实例
- $(htmlString)：创建 DOM 对象后包装成 jQuery 对象实例
- $(callback)：是 `$(document).ready(callback)` 的简写

### 选择器

主要用于使用 jQuery 查找元素

### DOM 操作

#### 文档处理

DOM 节点的添加、修改、删除、克隆

#### 筛选

DOM 节点的查找与过滤

#### 属性

DOM 元素节点的属性操作

#### CSS

css 样式处理

### 事件处理

#### 事件

- on(type, selector, callback)：注册事件监听

- off()：移除事件监听
- hover(onmouseenter, onmouseleave)：事件合成的方法，合成了 mouseenter、mouseleave 两个事件

#### 事件对象

event

### 效果

包括常见的运动效果

- animate()：自定义运动效果
- fadeIn()
- fadeOut()
- show()
- hide()

### ajax

ajax 网络请求

- $.ajax()

```js
$.ajax({
    url: '', // 请求资源的地址
    method: 'GET', // 请求方法，默认为 'GET'，也可以使用 type 属性表示请求方法
    data: {username: 'abc', password: '123'}, // 向服务端传递的数据
    dataType: 'json', // 预期从服务端返回数据的格式
    success: function(resData) { // 请求成功时执行的回调函数
        // resData 为服务端响应返回的数据
    },
    error: function(err) { // 请求失败时执行的回调函数
        
    }
})
```

- $.get()
- $.getJSON()
- $.post()

- load()

#### 延迟对象

类似于 Promise

# 工具

- git
- gulp
- sass
- require.js
- art-template
- .........