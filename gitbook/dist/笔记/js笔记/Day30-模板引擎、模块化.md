# 模板引擎

为了使用户界面与业务数据（内容）分离而产生的模板，可以方便快速实现页面渲染。

前端模板引擎：

- [art-template](https://aui.github.io/art-template/)
- [handlebars](https://www.handlebarsjs.cn/)
- [ejs](https://ejs.bootcss.com/)
- .......

## art-template

高性能 JavaScript 模板引擎

### 下载

下载：[template-web.js](https://unpkg.com/art-template/lib/template-web.js)（gzip: 6kb）

### 模板语法

**标准语法(简洁语法)：**

使用 `{ { }}` 语法将业务逻辑处理部分包裹起来，html 布局部分原样书写

**原始语法：**

使用 `<%  %>` 语法将业务逻辑处理部分包裹

原始语法支持所有 JS 功能

### 定义模板

```html
<script type="text/html" id="cart-body-template">
  { {each cart prod}}
  <ul class="cart-body-item">
    <li>{ {prod.id}}</li>
    <li>{ {prod.title}}</li>
    <li>{ {prod.price}}</li>
    <li>{ {prod.amount}}</li>
    <li>{ {(prod.price * prod.amount).toFixed(2)}}</li>
    <li><button>删除</button></li>
  </ul>
  { {/each}}
</script>
```

定义模板时，将 `<script>` 的 type 修改为 `text/html`，必须设置 id 属性

### 渲染模板

```html
<script src="template-web.js"></script>
```

```js
const html = template(id, data)
```

