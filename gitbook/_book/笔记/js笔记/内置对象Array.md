 

作用：用于保存一组数据值

 

### 定义

 

语法：

 

 ```js

  var array = [] // 直接量     var array = new Array() // 创建数组对象     var array = [val1, val2, val3, ...] // 创建的同时初始化数组     var array = new Array(val1, val2, ......)     var array = new Array(number) // 创建数组对象，同时初始化空间大小  
 ```


创建指定长度的数组：
```js

new Array(10).fill(0)：创建一个长度为10的数组并用0填充，填充的目的是避免数组产生空洞

const arr = [];

for(let i=0;i<10;i++){

arr.push(0);

}

Array.from({length:10}, () => ({}))//创建一个长度为10的对象数组

Array.from({length: 10}, (x, i) => i)//创建一个长度为10的用0,1,2……填充的数组
```


尽量不要使用new创建数组，new关键字只会使代码复杂化，它还会产生某些不可预期的结果，例如：
```js
var points = new Array(40, 100); // 创建包含两个元素的数组（40 和 100）

var points = new Array(40);    // 创建包含 40 个未定义元素的数组！！！
```






元素：数组中所保存数据的空间

 

下标（索引 - index）：数组中所保存元素的编号，编号从 0 开始

 

长度：数组中所保存元素的个数，使用 .length 属性获取或设置

 

### 数组元素的引用

 

要使用到数组中保存的某个数据值，是通过下标来引用到数组的元素值。例：

  scores[5] 

### 数组的 API(ES3)

 

数组对象的属性与方法。内置对象数组本身提供的一些方法，可供我们直接调用到来实现相应功能。

 

#### *属性：*

 

length：获取或设置数组的长度

 

#### *方法（函数）：*

 

##### 添加元素

 

- push() - 向数组末尾添加元素，返回数组的新的长度，如果有多个元素，可使用 , （逗号）分隔

- unshift() - 向数组头部添加元素，并把其他所有元素右移，返回新数组的长度，如果有多个元素，可使用 , （逗号）分隔


- splice(index, length, val1, val2, ......) - （可用于数组元素的删除），当length 参数为0时，表示删除0个元素，有 val1, val2, 等参数时，将这些值插入指定 index 索引处，其余元素右移，返回被删除的数组，插入和删除可以同时进行，例如：

  ```js
  var fruits = ["Banana", "Orange", "Apple", "Mango"];
  fruits.splice(2, 0, "Lemon", "Kiwi");
  ```
  
  第一个参数（2）定义了应添加新元素的位置（拼接）。
  
  第二个参数（0）定义应删除多少元素。
  
  其余参数（“Lemon”，“Kiwi”）定义要添加的新元素

 

##### 删除元素

 

- pop() - 从末尾删除一个元素，返回被删除的元素值，如果数组为空，返回undefined


- pop 方法有意具有通用性。该方法和 call() 或 apply() 一起使用时，可应用在类似数组的对象上。pop方法根据 length属性来确定最后一个元素的位置。如果不包含length属性或length属性不能被转成一个数值，会将length置为0，并返回undefined。


eg:
```js
var myFish ={0:'angel',1:'clown',2:'mandarin',3:'sturgeon',length:4};

var popped =Array.prototype.pop.call(myFish)
```

- 
  shift() - 从头部删除一个元素，并把所有其他元素“位移”到更低的索引，返回被“位移出”的字符串，为空返回undefined，使用call(),apply()与pop()相同


- splice(index, length) - 从指定 index 索引处删除 length 个元素，返回的是一个数组，包含了被删除的所有元素，也可用于插入元素



##### 连接

 

- concat() - 连接两个或多个数组，返回连接后的新数组，原数组不受影响 val1.concat(val2，val3);该方法不会更改现有数组，它总是返回一个新数组。该方法可以使用任意数量的数组参数。




##### 转为字符串

- join(sep) - 使用指定的符号sep将数组中每个元素连接成一个字符串后返回，如果不传递参数，默认使用 ',' （英文半角的逗号）连接。


- toString() - 将数组转换为字符串，返回值与没有参数的 join() 方法返回的字符串相同，返回单字符串以 ' , ' 隔开。所有JavaScript对象都有toString方法，数组也是对象。




##### 排序

 

- reverse() - 反转数组元素，原数组本身不受影响


- sort() - 数组元素排序，默认（不传参数）按照数组元素字符串unicode编码升序排序。如果需要按照指定的规则排序，则需要传递比值函数作为参数。

  比值函数：

  比较函数应该返回一个负，零或正值，这取决于参数：

  function(a, b){return a-b}如果返回值小于0，a会排到b的前面

  当 sort() 函数比较两个值时，会将值发送到比较函数，并根据所返回的值（负、零或正值）对这些值进行排序。

  Sort()也可用于对象属性排序，例如：

  ```js
  var cars = [
   {type:"Volvo", year:2016},
   {type:"Saab", year:2001},
   {type:"BMW", year:2010}];
  
   
  
  cars.sort(function(a, b){return a.year - b.year});
  ```

  

 

##### 截取

 

- slice(start, end) - 从原数组中截取一个子数组片段，start 为起始索引，end 为结束索引，会包含开始索引处的元素，不包含结束索引处的元素，返回截取后的新数组。end 可以省略，表示截取到最后。start 与 end 可以取负值，表示从后向前计数取索引




##### 遍历、迭代

 ```js
  for (let i = 0; i < array.length; i++) {       // array[i]     }  
// for ... in     
for (const key in object) {       // object[key]     }        // object 是对象的名称     
// key 为对象中遍历到的当前属性名     
// 使用 object[key] 的方式获取遍历到的对应属性值 
//普通对象不支持使用for of，要使用for of，可以使用for in或Object.keys(Obj)    
for(const value of Object.keys(obj)) {        console.log(value)        }
 ```






对象属性的访问：

 

object.<prop-name> - 打点调用

obj['prop-name'] - 字符串索引，通常当属性名字使用变量保存时，使用字符串索引的方式调用属性
```js
// for ... in     
for (const index in array) {       // array[index]     }      // index 是数组中当前遍历到元素的下标（字符串类型）    
// 可以使用 array[index] 方式获取到当前遍历的元素 

for ... of  for (const value of array) {       // value     }  // value 是数组中当前遍历到的元素值 
```


for in的一些**缺陷**:

1. 索引是字符串型的数字，因而不能直接进行几何运算
2. 遍历顺序可能不是实际的内部顺序
3. for     in会遍历数组所有的可枚举属性，包括原型。例如的原型方法method和name属性

 

for of不支持普通对象，想遍历对象的属性，可以用for in循环, 或内建的Object.keys()方法：

Object.keys(myObject)获取对象的实例属性组成的数组，不包括原型方法和属性

 

 

遍历数组使用for…of

遍历对象使用for…in

 

 

## ES5、ES6新增 API

 

### 查找索引

 

- indexOf(searchElement)：查找数组中 searchElement 元素第一次出现的索引（下标），如果不存在返回 -1，该函数可以使用第二个可选参数start，设置搜索的起始位置，负值将从结尾开始的给定位置开始。


- lastIndexOf(search)：查找数组中 search 元素最后一次出现的索引，如果不存在返回 -1，该函数从数组结尾开始搜索，可选参数与indexOf()相同。




### ES6

 

遍历、迭代

 

- forEach(callback) -- 遍历迭代数组的每个元素，在遍历每个元素时，调用 callback 执行函数体语句块


- map(callback) -- 遍历迭代数组的每个元素，**返回一个新数组**，新数组中的元素值是 callback 函数中的返回值


- filter(callback) -- 过滤筛选数组元素，**返回一个新数组**，新数组中的元素值为满足 callback 函数条件的对应元素值，满足条件返回true


- some(callback) -- 判断数组中是否存在满足 callback 条件的元素，返回布尔值


- every(callback) -- 判断数组中是否每一个元素都满足 callback 条件，返回布尔值


- find(callback) -- 查找数组中满足 callback 条件的第一个元素，返回查找到的元素值，找不到返回 undefined


- findIndex(callback) -- 查找数组中满足 callback 条件的第一个元素的下标，返回下标值，找不到返回 -1




以上几个方法的参数 callback 为函数结构：

```js
function(currentValue, currentIndex, array)  {       
// currentValue 表示当前遍历到的元素值       
// currentIndex 表示当前遍历到的元素下标       
// array 表示调用当前方法的数组     
}  
```



- reduce(callback, init)


- reduceRight(callback, init)


 这两个方法主要实现归并（累计），callback 结构：


```js
  function(result, currentValue, index, array)  {      
      // result 中保存累计结果，每次调用后的返回值会自动存入result中       // currentValue 表示当前遍历到的元素值      
      // index 表示当前遍历到的元素下标      
      // array 表示调用当前方法的数组     
  }          
init 参数为 callback 函数中 result 的初始值，如果不传递 init 参数，使用数组的第一个元素作为 result 的初始值,此时callback函数会从第二个元素开始执行。 
该函数会将每次函数返回的值存入result中实现累加  
```






填充

 

- fill(value)：以指定的 value 值填充数组元素返回修改后的数组。可选参数：start 起始索引，默认值为0，end 终止索引，默认值为this.length,填充时不包括终止索引处的元素。




转换

 

- Array.from()：将类似于数组的对象转换为数组的结构


类（似于）数组（的）对象，如 arguments（arguments 在函数体内部使用，表示函数被调用执行时所传递的实际参数列表）

 

判断

 

- includes()：判断在数组中是否存在参数表示的元素，返回 boolean 值


- Array.isArray()：判断参数是否为数组（面试经常提问如何判断一个表达式是否为数组）




扁平化（了解）

 

- flat()


参数：depth(可选) 制定要提取嵌套数组的结构深度，默认值为1

返回值为处理后的新数组，不会改变原数组

flatMap()

JavaScript中箭头函数是匿名函数表达式，它们没有用于递归或者事件绑定的命名引用

箭头函数定义包括一个参数列表（零个或多个参数，如果参数个数不是一个的话要用 ( .. )包围起来），然后是标识 =>，函数体放在最后。

 

已剪辑自: https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/flat#reduce_concat_isarray_recursivity

## 替代方案

### 使用 reduce 与 concat
```js
var arr = [1, 2, [3, 4]];

 // 展开一层数组
 arr.flat();
 // 等效于
 arr.reduce((acc, val) => acc.concat(val), []);
 // [1, 2, 3, 4]

 // 使用扩展运算符 ...
 const flattened = arr => [].concat(...arr);
```
### reduce + concat + isArray + recursivity
```js
// 使用 reduce、concat 和递归展开无限多层嵌套的数组
 var arr1 = [1,2,3,[1,2,3,4, [2,3,4]]];

 function flatDeep(arr, d = 1) {
  return d > 0 ? arr.reduce((acc, val) => acc.concat(Array.isArray(val) ? flatDeep(val, d - 1) : val), [])
         : arr.slice();
 };

 flatDeep(arr1, Infinity);
 // [1, 2, 3, 1, 2, 3, 4, 2, 3, 4]
```
### forEach+isArray+push+recursivity
```js
// forEach 遍历数组会自动跳过空元素
 const eachFlat = (arr = [], depth = 1) => {
  const result = []; // 缓存递归结果
  // 开始递归
  (function flat(arr, depth) {
   // forEach 会自动去除数组空位
   arr.forEach((item) => {
    // 控制递归深度
    if (Array.isArray(item) && depth > 0) {
     // 递归数组
     flat(item, depth - 1)
    } else {
     // 缓存元素
     result.push(item)
    }
   })
  })(arr, depth)
  // 返回递归结果
  return result;
 }

 // for of 循环不能去除数组空位，需要手动去除
 const forFlat = (arr = [], depth = 1) => {
  const result = [];
  (function flat(arr, depth) {
   for (let item of arr) {
    if (Array.isArray(item) && depth > 0) {
     flat(item, depth - 1)
    } else {
     // 去除空元素，添加非undefined元素
     item !== void 0 && result.push(item);
    }
   }
  })(arr, depth)
  return result;
 }

```
