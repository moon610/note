# Review

# AJAX

异步 JavaScript 和 XML 技术

实现无刷新操作（局部更新）

**核心：** XMLHttpRequest

## 使用：

1.  创建核心对象实例（准备手机）
2.  准备建立连接-请求方法、资源地址、是否异步（准备电话号码）
3.  发送请求（拨号）
4.  处理响应（等待对方接听或是挂断电话）

示例：

```js
// 1. 创建核心对象实例
const xhr = new XMLHttpRequest()
// 2. 准备建立连接
// xhr.open(method, url, async)
xhr.open('POST', '/register.do', true)
// 3. 发送请求
xhr.send()
// 4. 处理响应
xhr.onreadystatechange = () => {
  // readyState 表示请求到达哪个阶段，可取 0、1、2、3、4
  if (xhr.readyState === 4) { // 请求处理完毕，响应就绪
    // status 表示 HTTP 状态码
    if (xhr.status === 200) { // OK
      // responseText 获取响应文本数据
      const data = xhr.responseText
      console.log('获取到数据：', data)
    }
  }
}
```

如果需要像表单一样 POST 提交数据，则需要在 send() 方法调用之前，调用 setRequestHeader() 设置请求头信息：

```js
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
```

将需要传递给服务器的数据（拼接成查询字符串参数）以字符串参数形式传递到 send() 方法中.

# 网络API接口

[showapi](https://www.showapi.com/)