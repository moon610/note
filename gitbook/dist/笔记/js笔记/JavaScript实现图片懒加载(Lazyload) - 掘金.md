

## 为什么要使用懒加载

- 对页面加载速度影响最大的就是图片，一张普通的图片可以达到几M的大小，而代码也许就只有几十KB；
- 当页面图片很多时，页面的加载速度缓慢，几S钟内页面没有加载完成，也许会失去很多的用户；
- 所以，对于图片过多的页面，为了加速页面加载速度，所以很多时候我们需要将页面内未出现在可视区域内的图片先不做加载，等到滚动到可视区域后再去加载；
- 这样对于页面加载性能上会有很大的提升，也提高了用户体验；

## 原理

- 将页面中的`img`标签`src`指向一张小图片或者`src`为空；
- 然后自定义一个img的属性名，如`data-src`属性，其值指向真实的图片地址；
- 注：
    - `src`要指向一张默认的图片，否则`src`为空时，也会向服务器发送一次请求，可以指向`loading`的地址；
    - 图片要指定宽高
- 代码如下所示：
  
    ```
    <img src="default.jpg" data-src="http://ww4.sinaimg.cn/large/006y8mN6gw1fa5obmqrmvj305k05k3yh.jpg" />
    复制代码
    ```
    
- 当载入页面时：
    - 先把可视区域内的img标签的`data-src`属性值赋给`src`；
    - 然后监听滚动事件，把用户即将看到的图片加载；
    - 这样便实现了懒加载；

## JavaScript实现

```
var num = document.getElementsByTagName('img').length;
var img = document.getElementsByTagName("img");
var n = 0; //存储图片加载到的位置，避免每次都从第一张图片开始遍历

lazyload(); //页面载入完毕加载可是区域内的图片

window.onscroll = lazyload;

function lazyload() { //监听页面滚动事件
    var seeHeight = document.documentElement.clientHeight; //可见区域高度
    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop; //滚动条距离顶部高度
    for (var i = n; i < num; i++) {
        if (img[i].offsetTop < seeHeight + scrollTop) {
            if (img[i].getAttribute("src") == "default.jpg") {
                img[i].src = img[i].getAttribute("data-src");
            }
            n = i + 1;
        }
    }
}
复制代码
```

## jQuery实现

```
var n = 0,
    imgNum = $("img").length,
    img = $('img');

lazyload();

$(window).scroll(lazyload);

function lazyload(event) {
    for (var i = n; i < imgNum; i++) {
        if (img.eq(i).offset().top < parseInt($(window).height()) + parseInt($(window).scrollTop())) {
            if (img.eq(i).attr("src") == "default.jpg") {
                var src = img.eq(i).attr("data-src");
                img.eq(i).attr("src", src);

                n = i + 1;
            }
        }
    }
}
复制代码
```

## 使用节流函数进行性能优化

- 如果直接将函数绑定在`scroll`事件上，当页面滚动时，函数会被高频触发，这非常影响浏览器的性能；
- 可引用节流函数来限制触发频率，优化性能；
- 节流函数：只允许一个函数在N秒内执行一次，下面是一个简单的节流函数：

```
// 简单的节流函数
// fun 要执行的函数
// delay 延迟
// time 在time时间内必须执行一次
function throttle(fun, delay, time) {
    var timeout,
        startTime = new Date();

    return function() {
        var context = this,
            args = arguments,
            curTime = new Date();

        clearTimeout(timeout);
        if (curTime - startTime >= time) { // 如果达到了规定的触发时间间隔，触发 handler
            fun.apply(context, args);
            startTime = curTime;
        } else { // 没达到触发间隔，重新设定定时器
            timeout = setTimeout(fun, delay);
        }
    };
};

function lazyload(event) { // 实际绑定在 scroll 事件上的 handler
    for (var i = n; i < imgNum; i++) {
        if (img.eq(i).offset().top < parseInt($(window).height()) + parseInt($(window).scrollTop())) {
            if (img.eq(i).attr("src") == "default.jpg") {
                var src = img.eq(i).attr("data-src");
                img.eq(i).attr("src", src);

                n = i + 1;
            }
        }
    }
}
 
// 采用了节流函数
window.addEventListener('scroll',throttle(lazyload,500,1000));
复制代码
```

[查看原文](https://juejin.cn/post/6844903455048335368)

