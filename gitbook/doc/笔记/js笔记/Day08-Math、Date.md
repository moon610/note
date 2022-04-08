# Math

**`Math`** 是一个内置对象，它拥有一些数学常数属性和数学函数方法。

在 Math 对象中的属性与方法都是通过 `Math` 来进行调用的。

## API

### 方法

- Math.random() - 随机数，[0, 1)
- Math.floor() - 向下取整
- Math.ceil() - 向上取整
- Math.round() - 四舍五入取整数
- Math.pow(x, y) - x的y次方
- Math.abs() - 取绝对值
- Math.max() - 取参数中的最大值
- Math.min() - 取参数中的最小值
- Math.sqrt() - 开平方根

### 属性

- Math.PI - 圆周率

# JSON（ES5）

`JavaScript Object Notation` - JavaScript 对象表示法。

JSON 是用于数据传递的一种语法格式，其本质是一个字符串，在这个字符串中，可以表示出 JavaScript 中的各类型数据。

通常我们在不同系统之间要传递数据时，使用 `JSON` 格式的文本来实现数据传递。

现在公司前后端分离的情况下，后端向前端传递数据，基本也使用的是 JSON 格式传递数据。

在 JSON 字符串中，可表示的数据有：

- 对象
- 数组
- 数值
- 字符串
- 布尔值
-  null

**注意：**

- JSON 格式中表示字符串数据时，必须使用 `""` (双引号) 包含
- JSON 格式中表示对象时，对象属性名称必须使用 `""` （双引号）包含
- JSON 格式中表示数组或对象时，不能在最后一个元素后加多余的尾逗号

## API

- JSON.stringify() - 序列化，将 JS 的值转换为 JSON 格式的字符串
- JSON.parse() - 反序列化，将 JSON 格式的字符串内容还原为 JS 的值

# eval()

eval() 函数会将传入的字符串当做 JavaScript 代码进行执行

eval() 存在严重的安全问题，**永远不要使用 eval()!!!**

# Number

## API

- toFixed() - 将数字转换为字符串，保存小数点后指定位数的小数
- toString(radix) - 将数字转换为对应的字符串，radix 是可选参数，表示在转换为字符串时所使用的进制

- Number.parseInt(str, radix) - 与全局的 parseInt() 等价

# Date

作用：用于处理与日期时间相关的数据

## 创建 Date 对象

```js
new Date() // 以系统当前时间创建 Date 对象
new Date(value) // value 是一个整数，表示距 1970-1-1 0:0:0 以来的毫秒值
new Date(dateString) // dateString 是一个表示日期时间的字符串，通常使用 - 或 / 号分隔日期, :分隔时间
new Date(year, monthIndex [, day [, hours [, minutes [, seconds [, milliseconds]]]]]) // 传递年、月、日、时、分、秒、毫秒 作为参数创建日期时间对象
```

## API

获取

- getFullYear() - 年      (注：getYear表示的是距离1900年的年份，属于历史遗留问题)
- getMonth() - 月，返回值范围为 0 - 11
- getDate() - 日
- getHours() - 时
- getMinutes() - 分
- getSeconds() - 秒
- getMillseconds() - 毫秒
- getDay() - 星期几
- getTime() - 获取距 1970-1-1 0:0 的毫秒

设置

- setFullYear() - 年
- setMonth() - 月，返回值范围为 0 - 11
- setDate() - 日
- setHours() - 时
- setMinutes() - 分
- setSeconds() - 秒
- setMillseconds() - 毫秒
- setTime() - 获取距 1970-1-1 0:0 的毫秒



练习：

定义函数，格式化日期时间字符串，`YYYY-MM-dd HH:mm:ss`