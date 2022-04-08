# Review

选择结构：

```js
if (条件表达式) {
    // 条件表达式为 true 时执行的语句块
} else {
    // 条件表达式为 false 时执行的语句块
}
```

```js
if (条件表达式1) {
    // 条件表达式1为 true 时执行的语句块
} else if (条件表达式2) {
    // 条件表达式2为 true 时执行的语句块
} else if (条件表达式3) {
    // 条件表达式3为 true 时执行的语句块
} else {
    // 前述所有条件均为 false 时执行的语句块
}
```

```js
switch (表达式) {
	case 常量1:
		// 语句块(当 表达式 === 常量1 时执行到的语句块)
		break
	case 常量2:
		// 语句块(当 表达式 === 常量2 时执行到的语句块)
		break
	case 常量3:
		// 语句块(当 表达式 === 常量3 时执行到的语句块)
		break
	default:
		// 语句块
		break
}
```

判断一个整数是偶数还是奇数，并输出判断结果：

```js
if (num % 2 === 0) {
    // 偶数
} else {
    // 奇数
}
```

开发一款软件，根据公式（身高-108）*2=体重，可以有10斤左右的浮动。来观察测试者体重是否合适：

```js
var height = 178
var weight = 135
var standard = (height - 108) * 2

if (weight >= standard - 10 && weight <= standard + 10) {
    // 合格
} else {
    // 不合格
}
```

输入数字（范围为 0-6，0表示星期天，1-6表示星期一到星期六），显示星期几：

```js
switch(day) {
    case 0:
        // 星期天
        break
    case 1:
        // 星期一
        break
    // ......
}
```

根据一个数字日期，判断这个日期是这一年的第几天：

```js
var year = 2016, month = 4, date = 11, totalDays = 0
/*
var isRn = (year % 4 === 0 && year % 100 !== 0 || year % 400 === 0) ? '闰年' : '平年'
if (year % 4 === 0 && year % 100 !== 0 || year % 400 === 0) {
    isRn = '闰年'
} else {
    isRn = '平年'
}
*/
switch(month) {
    case 1:
        totalDays = date
        break
    case 2:
        totalDays = 31 + date
        break
    case 3:
        totalDays = 31 + 28 + date
        break
    case 4:
        totalDays = 31 + 28 + 31 + date
        break
    // ......
}
if (month > 2) {
    if (year % 4 === 0 && year % 100 !== 0 || year % 400 === 0) {
        totalDays += 1
    }
}

console.log('当年第' + totalDays + '天')
```

```js
var year = 2016, month = 12, date = 11, totalDays = 0

switch(month) {
  case 12:
    totalDays += 30
  case 11:
    totalDays += 31
  case 10:
    totalDays += 30
  case 9:
    totalDays += 31
  case 8:
    totalDays += 31
  case 7:
    totalDays += 30
  case 6:
    totalDays += 31
  case 5:
    totalDays += 30
  case 4:
    totalDays += 31
  case 3:
    totalDays += year % 4 === 0 && year % 100 !== 0 || year % 400 === 0 ? 29 : 28
  case 2:
    totalDays += 31
  case 1:
    totalDays += date
}

console.log('当年第' + totalDays + '天')
```

补充：

**三目运算符**：`条件表达式 ? 条件表达式为 true 时执行的表达式 : 条件表达式为 false 时执行的表达式`

# 循环结构

当有大量重复或有规范动作需要执行时，可使用循环结构

语法：

```js
while (条件表达式) {
	// 当条件表达式为 true 时执行的语句块
}
```

```js
do {
    // 当条件表达式为 true 时执行的语句块
    // 语句块第一次的执行是无条件执行的
} while (条件表达式)
```

```js
for (初始化; 条件表达式; 变量更新) {
    // 当条件表达式为 true 时执行的语句块
}
```

流程图：

使用循环的步骤：

1. 找出循环条件和循环操作

2. 代入循环的语法结构
3. 判断能否退出循环，如果不能退出循环结构(死循环)，需要构建退出的条件

关于循环结构的选择：

- 通常 while 与 do-while 循环用于循环次数不确定的情况，而 for 用于循环次数确定的情况。大部分情况下循环次数都是确定的，所以 for 循环使用会更多。
- 在选择使用 while 与 do-while 时，通常先判断后执行时选择使用 while，先执行后判断使用 do-while。

跳转语句：

- break;
- continue;

当在循环主体中遇到  `break; ` 语句，表示退出（结束）整个循环结构操作；

遇到 `continue;` 语句，表示结束当前次循环，还会判断条件执行下一次循环。