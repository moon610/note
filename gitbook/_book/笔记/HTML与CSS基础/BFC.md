**块格式化上下文**（Block Formatting Context，BFC）是 Web 页面的可视 CSS 渲染的一部分，是块级盒子的布局过程发生的区域，也是浮动元素与其他元素交互的区域。是一个独立的渲染区域或者说是一个隔离的独立容器。

下列方式会创建块格式化上下文：

- 根元素（`<html>`）
- 浮动元素（`float` 值不为 `none`）
- 绝对定位元素（`position` 值为 `absolute` 或 `fixed`）
- 行内块元素（`display` 值为 `inline-block`）
- 表格单元格（`display` 值为 `table-cell`，HTML 表格单元格默认值）
- 表格标题（`display` 值为 `table-caption`，HTML 表格标题默认值）
- 匿名表格单元格元素（`display` 值为 `table`、`table-row`、 `table-row-group`、`table-header-group`、`table-footer-group`（分别是 HTML table、tr、tbody、thead、tfoot 的默认值）或 `inline-table`）
- `overflow` 值不为 `visible`、`clip` 的块元素
- `display` 值为 `flow-root` 的元素
- `contain` 值为 `layout`、`content` 或 `paint` 的元素
- 弹性元素（`display` 值为 `flex` 或 `inline-flex` 元素的直接子元素），如果它们本身既不是 flex、grid 也不是 table 容器
- 网格元素（`display` 值为 `grid` 或 `inline-grid` 元素的直接子元素），如果它们本身既不是 flex、grid 也不是 table 容器
- 多列容器（`column-count` 或 `column-width`  值不为 `auto`，包括`column-count` 为 `1`）
- `column-span` 值为 `all` 的元素始终会创建一个新的 BFC，即使该元素没有包裹在一个多列容器中

格式化上下文影响布局，通常，我们会为定位和清除浮动创建新的 BFC，而不是更改布局，因为它将：

- 包含内部浮动
- 排除外部浮动
- 阻止 外边距重叠



### BFC的特性

```text
1.内部的元素会在垂直方向，从顶部开始一个接一个地放置。 
2.元素垂直方向的距离由margin决定。属于同一个BFC的两个相邻 元素的margin会发生叠加
3.都是从最左边开始的。每个元素的margin box的左边，与包含块border box的左边(对于从左往右的格式化，否则
相反)。即使存在浮动也是如此
4.BFC的区域不会与float box叠加。 
5.BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素，反之亦然。 
6.计算BFC的高度时，浮动元素也参与计算（当BFC内部有浮动时，为了不影响外部元素的布局，BFC计算高度时会包
括浮动元素的高度）
```



### 示例

#### 包含内部浮动

让浮动内容和周围的内容等高。

为了更好的理解 BFC，我们先看看下面这些内容。

在下面的例子中，我们让 `<div>` 元素浮动，并给它一个 `border` 效果。`<div>` 里的内容现在已经在浮动元素周围浮动起来了。由于浮动的元素比它旁边的元素高，所以 `<div>` 的边框穿出了浮动。正如我们在 [In Flow and Out of Flow](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flow_Layout/In_Flow_and_Out_of_Flow) 中解释的，浮动脱离了文档流，所以 `<div>` 的 `background` 和 `border` 仅仅包含了内容，不包含浮动。

**使用 `overflow: auto`**

在创建包含浮动元素的 BFC 时，通常的做法是设置父元素 `overflow: auto` 或者其他除默认的 `overflow: visible` 以外的值。`<div>` 元素变成布局中的迷你布局，任何子元素都会被包含进去。

使用 `overflow` 创建新的 BFC，是因为 `overflow` 属性会告诉浏览器应该怎样处理溢出的内容。如果使用它仅仅为了创建 BFC，你可能会遇到不希望出现的滚动条或阴影，需要注意。另外，对于后续的开发者，可能不清楚当时为什么使用 `overflow`，所以最好添加一些注释来解释为什么这样做。

**使用 `display: flow-root`**

一个新的 `display` 属性的值，它可以创建无副作用的 BFC。在父级块中使用 `display: flow-root` 可以创建新的 BFC。

给 `<div>` 元素设置 `display: flow-root` 属性后，`<div>` 中的所有内容都会参与 BFC，浮动的内容不会从底部溢出。

你可以从 `flow-root` 这个值的名字上看出来，它创建一个新的用于流式布局的上下文，类似于浏览器的根（`html`）元素。