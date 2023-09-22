## 问题描述：

------

###### 在页面布局的时候，本来想在子元素上设置margin-top，使得子元素和父元素隔开一定的距离，想象中的效果如下图1；结果却不尽如人意，如图2，margin像是加在了父元素上。

###### 使用的代码如下：

HTML



```jsx
<div class="big">
      <div class="small">
      </div>
</div>
```

CSS



```css
 *{
     padding:0px;
     margin: 0px;
 }
.big{
     width: 200px;
     height: 200px;
     background-color:red;
 }
.small{
     width: 100px;
     height: 100px;
     background-color: blue;
     margin-top: 10px;
 }
```

![img](https://upload-images.jianshu.io/upload_images/6540191-11f27fcb4cb3c978.png?imageMogr2/auto-orient/strip|imageView2/2/w/799/format/webp)

## 分析原因：

------

###### 这是因为父元素和子元素的margin发生了和并，父元素的margin是0px，子元素的margin是10px，所以合并后的margin是10px，且加在了父元素上，于是出现了图2的效果。*在CSS2.1中对盒模型有如下规定：在垂直方向上，所有毗邻的两个或多个盒元素的margin将会合并。毗邻的意思是：同级或嵌套的盒元素，并且它们之间没有非空内容、padding或border。*

###### 合并后的margin的大小取两个发生合并的元素中margin较大的那一个。

[mdn文档 外边距重叠]([外边距重叠 - CSS：层叠样式表 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Box_Model/Mastering_margin_collapsing))

> 块的上外边距 (margin-top)有时合并 (折叠) 为单个边距，其大小为单个边距的最大值 (或如果它们相等，则仅为其中一个)，这种行为称为**边距折叠**。
>
> 以下三种情况会发生外边距重叠
>
> - 同一层相邻元素之间
>
>   相邻的两个元素之间的外边距重叠，除非后一个元素加上[clear-fix 清除浮动](https://developer.mozilla.org/zh-CN/docs/Web/CSS/clear)。
>
> - 没有内容将父元素和后代元素分开
>
>   如果没有边框border，内边距padding，行内内容，也没有创建块级格式上下文或清除浮动来分开一个块级元素的上边界margin-top 与其内一个或多个后代块级元素的上边界margin-top；或没有边框，内边距，行内内容，高度height，最小高度min-height或 最大高度max-height 来分开一个块级元素的下边界margin-bottom与其内的一个或多个后代后代块元素的下边界margin-bottom，则就会出现父块元素和其内后代块元素外边界重叠，重叠部分最终会溢出到父级块元素外面。
>
> - 空的块级元素
>   当一个块元素上边界margin-top 直接贴到元素下边界margin-bottom时也会发生边界折叠。这种情况会发生在一个块元素完全没有设定边框border、内边距padding、高度height、最小高度min-height 、最大高度max-height 、内容设定为 inline 或是加上clear-fix的时候
>
> 一些需要注意的地方：
>
> - 上述情况的组合会产生更复杂的外边距折叠。
> - 即使某一外边距为 0，这些规则仍然适用。因此就算父元素的外边距是 0，第一个或最后一个子元素的外边距仍然会“溢出”到父元素的外面。
> - 如果参与折叠的外边距中包含负值，折叠后的外边距的值为最大的正边距与最小的负边距（即绝对值最大的负边距）的和，；也就是说如果有 -13px 8px 100px 叠在一起，边界范围的技术就是 100px -13px 的 87px。
> - 如果所有参与折叠的外边距都为负，折叠后的外边距的值为最小的负边距的值。这一规则适用于相邻元素和嵌套元素。

###### 更详细的讲，分为几种情况：

1.**两个元素为同级元素**，即当一个元素出现在另一个元素上面时，第一个元素的margin-bottom与第二个元素的margin-top发生合并，合并后的margin值是margin-bottom和margin-top中较大的那一个

2.**当两个元素嵌套**，即一个元素包含在另一个元素中时（假设没有padding或border把两个元素的margin分隔开），它们的margin-bottom和/或margin-top也会发生合并，合并后的margin值同样也是margin-bottom和margin-top中较大的那一个；**该问题就属于这一种情况**。

3.**假设有一个空元素，且不设置它的宽高，**它有margin-bottom和margin-top，但是没有padding或border。在这种情况下，margin-bottom和margin-top就碰到了一起，它们也会发生合并，合并后的margin值同样也是margin-bottom和margin-top中较大的那一个。
如果这个外边距遇到另一个元素的外边距，它还会发生合并。

## 解决方法：

------

###### 1.在父元素上设置overflow：hidden； （触发父元素的BFC）

###### 2.给父元素设置padding或border（隔开两个元素的margin）

###### 3.父元素或子元素使用浮动或者绝对定位（浮动或绝对定位不参与margin的折叠）