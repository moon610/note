结析字符串格式的HTML

使用DOMParser对象DOMParser - Web API 接口参考 | MDN (mozilla.org)
DOMParser 可以将存储在字符串中的 XML 或 HTML 源代码解析为一个 DOM Document

创建一个DOMParser对象
```js
let domparser = new DOMParser()​​;
```
调用parseFormString方法
```js
let doc =domparser.parseFromString(string,mimeType)
```
该方法接收 2 个必要参数：
string表示要解析的HTML或XHTML，mimeType表示返回值的文档类型(text/html,text/xml,application/xml等）
这里的doc就是解析后的document对象，可以调用getElementByID等方法
如：
```js
const xhr = new XMLHttpRequest()
    xhr.open('get', '/9txs/book/145578.html')
    xhr.send()
    xhr.onreadystatechange = () => {
      if (xhr.readyState === 4 && xhr.status === 200) {
        // const $ = HTML.parse(xhr.parse)
        // console.log(xhr.responseText)
        const domparse = new DOMParser()
        const doc = domparse.parseFromString(xhr.responseText, 'text/html')
        console.log(doc.querySelector('.header .layui-main .logo').getAttribute('href'))
      }
    }
```
以上代码可以将ajax请求返回的HTML文档解析，获取其中想要的元素的属性
