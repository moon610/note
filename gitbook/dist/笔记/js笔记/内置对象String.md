 

JavaScript中字符串是只读的，不能修改，只能覆盖，例如：

str[0] = 'A'是无效的，但是也不会产生错误

str = 'A'会将整个字符串覆盖

使用属性可以访问到字符串，例如：str[0]

如果想按照数组的方式处理数组，可以使用split()方法把它转换为数组

创建：

```js
var str = 'str'     var str = "str"     var str = new String('str')     var str = String('str')
```

 

## API

### 属性

- length：字符串的长度

### 方法

- concat()：字符串连接，与使用‘+’号效果相同

- indexOf(sub)：在原字符串中查找子字符串sub第一次出现的索引，未找到返回-1

- lastIndexOf()：最后一次出现的索引，未找到返回-1，两个方法均可以使用第二个参数作为起始位置

- search(s):搜索特定值的字符串，并返回匹配的位置，与indexOf()的区别是search()无法设置第二个参数，indexOf()无法使用正则表达式

- slice(start, end)：截取子字符串，包含start索引处的字符，不包含end索引处的字符。返回截取后的字符串

- substring(start, end)：截取子字符串，与 slice 的区别是参数不取负值

- substr(start,length):截取字符串，与silce的区别是第二个参数规定被提取部分的长度

- includes()

- charAt(index)：查找index索引处的字符，返回值为该字符

- charCodeAt(index)：查找index索引处的字符的 unicode 编码，'a'.charCodeAt()=97

- String.fromCharCode(code)：将 code 编码值还原为字符串文本

- endsWith(str)：判断字符串是否以 str 作为后缀结尾

- startsWith(str)：是否以 str 开头

- padStart(targetLength, pad)：将字符串前边补 pad 参数的子字符串内容，以达到 targetLength 的长度

- padEnd()

- replace(sub, newTarget)：替换，将满足 sub 条件的子字符串内容替换为 newTarget 字符串的内容，只替换匹配到的第一个。

  如需执行大小写不敏感的替换，请使用正则表达式 /i（大小写不敏感）：

  如需替换所有匹配到的字符，请使用正则表达式 /g：

  str.replace(/Microsoft/g, "W3School");

- replaceAll();替换全部

- split(sep)：将字符串以指定的sep符号分割成数组，

  如果省略分隔符，返回的数组index[0]中将包含整个字符串

  如果分隔符是""，返回的数组将是间隔单个字符的数组，逗号也会被放入数组中

- toUpperCase()：转换为大写

- toLowerCase()：转换为小写

- trim()：去掉字符串前后空白