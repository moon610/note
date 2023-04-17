# window.requestAnimationFrame（了解）

**`window.requestAnimationFrame()`** 告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。

在 IE10 以前的浏览器中不适用，如果浏览器不支持使用 `window.requestAnimationFrame()` 则仍然需要使用 `window.setTimeout()` 来实现动画效果。

# 报错

`Cannot read property 'style' of undefined`

不能读取未定义的 style 属性，这儿**实际指的是调用 `style` 属性的那个对象是未定义的**

