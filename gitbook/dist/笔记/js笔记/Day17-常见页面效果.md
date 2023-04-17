mouseover 与 mouseenter 区别：

mouseenter 没有事件冒泡，mouseover 有事件冒泡

即 mouseenter 事件，当在后代元素上移动经过时，不会重复触发执行 mouseenter 事件处理程序，而 mouseover 因为存在事件冒泡，所以当从后代元素上移动经过时，会重复触发 mouseover 事件处理程序。