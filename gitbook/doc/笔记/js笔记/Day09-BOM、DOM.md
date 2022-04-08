# Review

定义函数，格式化日期时间字符串

ES6 模板字符串

```js
"字符串"
'字符串'
`字符${expression}串`
```

在模板字符串中，可以使用 `${expression}` 结构来将表达式的运算结果拼接在字符串中

**获取距离 1970-1-1 0:0:0 的毫秒值：**

- new Date().getTime()
- +new Date()
- new Date().valueOf()
- Date.now()

# BOM

Browser Object Model（浏览器对象模型）

使得我们能够在 JavaScript 脚本中与浏览器 “对话”

## Window 对象

Window 对象表示浏览器中打开的窗口

Window 对象是在 JavaScript 中的一个全局对象，使用 `window` 来引用 Window 对象。

### API

window 对象下属性与方法的调用可使用 `window.` 进行调用，也可以省略 `window.` 的书写而直接调用

#### 属性

普通属性

- name - 窗口名称
- innerWidth - 内部显示区域的宽度
- innerHeight - 内部显示区域的高度

对象属性

- location - 代表浏览器中当前打开的 URL，使用 window.location 或 location 引用
- history - 历史记录，使用 window.history 或 history 引用
- navigator - Navigator 对象包含有关浏览器的信息，navigator.userAgent
- document
- screen

#### 方法

- alert() - 弹出警告框
- prompt() - 弹出输入框
- confirm() - 弹出确认框

注意：使用 alert()、prompt()、confirm() 弹框，可能会阻塞浏览器渲染，实际开发中通常不再使用这几个方法。

- open() - 打开新窗口
- close()

定时器、计时器

- setTimeout() - 一次性定时
- setInterval() - 周期性定时
- clearTimeout() - 清除由 setTimeout() 启动的定时器
- clearInterval() - 清除由 setInterval() 启动的定时器

### Location

代表浏览器中当前打开的 URL

URL 格式：

```html
协议://域名:端口/资源路径?查询字符串参数#hash

如：
https://www.w3school.com.cn:443/jsref/dom_obj_location.asp

https://www.baidu.com/s?wd=iframe&rsv_spt=1&rsv_iqid=0x88d6ee170002acf2&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&rqlang=&tn=baiduhome_pg&ch=&rsv_enter=0&rsv_dl=ib&rsv_btype=i
```

http 默认端口为 80

https 默认端口为 443

#### API

##### 属性

- protocol - 协议
- hostname - 域名
- port - 端口
- host - 域名+端口
- pathname - 资源路径
- search - 查询字符串，包括 ?
- hash - 锚点值，包括 #
- href - 完整的 URL
  - 可使用 location.href = 'url' 来跳转页面，可简写为 location = 'url'

##### 方法

- reload() - 重新加载、刷新
- assign(url) - 加载新的文档，可认为内部是封装的对 location.href 的赋值操作
- replace(url) - 以新文档替换当前文档（当前文档的访问记录不会添加到历史记录中）

### History

代表浏览器访问的历史记录，仅能获取到历史记录列表的长度，能够实现前进、后退操作，不能获取具体的历史记录url信息

#### API

##### 属性

- length - 记录条数

##### 方法

- back() - 后退，仅能后退一个历史记录
- forward() - 前进，仅能前进一个历史记录
- go(n) - 前进/后退，可前进/后退多(n)个历史记录，n 大于 0 表示前进，n 小于 0 表示后退

### 定时器

setTimeout()

setInterval()

```js
const id = setTimeout(function() {}, time)
const id = setInterval(function() {}, time)
```

- time 是定时时间，单位毫秒
- 在定时时间 time 到达后，再执行第一个参数（函数）中的任务
- 定时器函数调用后，会返回定时器的 id，该 id 用于停止定时器 clearTimeout() 与 clearInterval() 调用时的参数传递。

可以使用 setTimeout() 来实现周期性定时任务（利用函数的递归）：

```js
function fn() {
    // 定时需要执行的任务:TODO......
    
    // 利用 setTimeout() 启动定时器，在 fn 函数体
    // 内部，当定时时间到后执行 fn 函数本身的调用（递归）
    setTimeout(fn, 1000)
}

fn()
```

## 异步机制

JavaScript 是单线程的应用程序，在 JS 引擎中同时只能处理一条语句的执行，必须前一条语句执行完才能执行后一条语句。

通常使用 setTimeout() 与 setInterval() 在定时的时候定时时间长短不一，如果等定时时间到达并执行完定时任务后，再继续身后执行语句，则存在定时时间内 CPU 资源闲置浪费的情况。

所以对于 setTimeout() 、setInterval() 的设计采用异步机制来完成，即先会处理定时任务后的语句块，再回头执行定时任务。

了解 Event Loop 情况。



练习：

计算当前时间距离 2021-11-26 00:00:00 还有 ?天?小时?分?秒