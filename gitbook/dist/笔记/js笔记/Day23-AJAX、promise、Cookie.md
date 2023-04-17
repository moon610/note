# Review

ajax 使用步骤：

```js
// 创建核心对象实例
const xhr = new XMLHttpRequest()
// 处理响应
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4) {
    if (xhr.status === 200) {
      const data = xhr.responseText
    }
  }
}
// 准备建立连接
xhr.open(method, url, async)
// 设置请求头
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
// 发送请求
xhr.send(params)
```

# 跨域

## 同源策略（同域限制）

同源策略是浏览器中的一种安全策略（负责管理浏览器中数据访问的安全问题），默认情况下，在浏览器中，非同源的资源之间不允许相互访问。

URL 格式：

```html
协议://域名:端口/资源路径?查询字符串#hash
```

同源：协议、域名、端口完全一致

只要三者中有任意一个不同，则就是非同源的资源，非同源资源间的访问叫做跨域。

如：

```html
http://localhost:3000/index.html
http://localhost:3000/html/login.html
http://localhost:3000/assets/images/5.png
https://localhost:3000/html/register.html
http://127.0.0.1:3000/style/style.css
http://127.0.0.1:9527/index
```

跨域访问时，会报告类似如下的错误信息：

```js
Access to XMLHttpRequest at 'http://localhost:3000/exist' from origin 'http://127.0.0.1:3000' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## 解决跨域的方案：

### CORS

跨域资源共享。允许浏览器跨域发送 ajax 请求，克服 ajax 只能在同源中访问的限制。

CORS 需要浏览器和服务器同时支持。目前，所有浏览器都支持该功能，所以通常 CORS 现在是在服务端设置即可。浏览器端仍然使用 ajax 请求资源。

CORS 跨域，设置响应头信息：

```html
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: *
```

### JSONP

JavaScript Object Notation Padding

原理：

在浏览器端，利用 `<script>` 引入外部资源时，不受同源策略限制的特点，来实现跨域资源访问。

实现：

- 服务端：在向浏览器端返回数据时，返回数据的格式是一个 JS 中函数调用结构的数据

- 浏览器端：
  - 动态创建 `script` 元素
  - 设置 script 元素的 src 属性，在URL中传递用于处理响应数据的函数名称给服务端
  - 将创建的 script 元素添加到 DOM 树结构中
  - 创建全局的用于处理响应数据的函数
  - 将添加到 DOM 树结构中的 script 元素节点删除

注意：JSONP 处理的是 GET 请求方法的跨域



百度提示：https://www.baidu.com/sugrec?prod=pc&wd=搜索的关键字&cb=回调函数名称

# Promise

在异步调用执行过程中，可能会出现**回调地狱**问题，可利用 Promise 来解决相关回调地狱问题。

利用 Promise，可以将异步嵌套调用的书写方式转换为同步链式调用的书写方式，有利于进行代码阅读与维护。

## 三种状态：

- pending：等待状态
- fulfilled：成功
- rejected：失败

## 使用

### 创建对象

```js
const executor = function(resolve, reject) {
  // 通常在该函数中，定义异步操作任务
  // resolve 函数：将 Promise 状态修改为 fulfilled 成功状态
  // reject 函数：将 Promise 状态修改为 rejected 失败状态
}

const promise = new Promise(executor)

// 在创建 Promise 对象的同时，executor 函数会被同步调用
```

示例：

```js
const promise = new Promise(function(resolve, reject) {
  setTimeout(function() {
    const rand = Math.random()
    console.log('定时任务', rand)
    if (rand >= 0.5) { // 成功
      resolve()
    } else { // 失败
      reject()
    }
  }, 10000)
})
```

### API

#### Promise.prototype.then(onFulfilled[, onRejected])

作用：是Promise对象的前置任务执行结束后，接下来要执行的任务，onFulfilled 是Promise 状态为 fulfilled 时执行的回调函数，onRejected 是 Promise 状态为 rejected 时执行的回调函数

#### Promise.prototype.catch()

作用：捕获错误（rejected状态）

# 本地存储

- Cookie
- WebStorage
  - localStorage
  - sessionStorage
- IndexedDB

## Cookie

特点：

- 存储的是文本数据
- 存储容量大小限制：4KB
- 会占用网络上传带宽（即访问服务端资源时默认会将 cookie 携带在请求头中传递到服务端）
- 受同域限制
- 有时效性

### 使用

保存、修改、删除：

```js
document.cookie = 'key=value; expires=失效时间; path=保存路径; domain=域; secure'
```

- key: cookie 名称
- value: cookie 值
- expires: 过期时间，可选，不设置时默认是**会话失效**。会话指的是从访问某网站开始，到关闭浏览器结束
- path: 保存的路径，可选，默认为访问文件的路径，一般会将 path 设置为 `/`
- domain: 域
- secure: 是否安全链接

查询：

```js
document.cookie
```

- 返回所在域下所有的 cookie 拼接的字符串，所有 cookie 以 key=value 形式使用 `; `(分号+空格) 拼接