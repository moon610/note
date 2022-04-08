### Day2. ES5/String

#### 第一节：精讲

1. 严格模式

   * "use strict"

     * 消除代码运行的一些不安全之处，保证代码运行的安全；
     * 提高编译器效率，增加运行速度；

   * 全局变量声明时 必须加var

     ```
     "use strict";
     x = 3.14;
     ```

   * this 无法指向全局对象

     ```
     function f(){ 
         "use strict";
         return !this;
     } 
     // 返回true，因为严格模式下，this的值为undefined，所以"!this"为true。
     ```

   * 不允许变量重名:

     ```
     "use strict";
     function x(p1, p1) {};   // 报错
     ```

2. ES5新增数组常见方法（indexof/forEach/map/reduce/filter）

   * indexOf(data,start) O要大写

     * indexOf()：接收两个参数：要查找的项和（可选的）表示查找起点位置的索引

     ```
     var arr = [1,3,5,7,7,5,3,1];
     console.log(arr.indexOf(5)); //2
     console.log(arr.lastIndexOf(5)); //5
     console.log(arr.indexOf(5,2)); //2
     console.log(arr.lastIndexOf(5,4)); //2
     console.log(arr.indexOf("5")); //-1
     ```

   * forEach() 循环

     * 对数组进行遍历循环，对数组中的每一项运行给定函数。这个方法没有返回值

       ```
       var arr = [1, 2, 3, 4, 5];
       arr.forEach(function(x, index, a){
       console.log(x + '|' + index + '|' + (a === arr));
       });
       // 输出为：
       // 1|0|true
       // 2|1|true
       // 3|2|true
       // 4|3|true
       // 5|4|true
       ```

   * map(callback) ； 会遍历当前数组，然后调用参数中的方法，返回当前方法的返回值;

     ```
     var arr = [1, 2, 3, 4, 5];
     var arr2 = arr.map(function(item){
     return item*item;
     });
     console.log(arr2); //[1, 4, 9, 16, 25]
     ```

   * filter() 过滤

     ```
     var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
     var arr2 = arr.filter(function(x, index) {
     	return index % 3 === 0 || x >= 8;
     }); 
     console.log(arr2); //[1, 4, 7, 8, 9, 10]
     ```

3. 字符串的两种创建方式（常量和构造函数）

   * var str="亲"
   * var str = new String(“hello”)

#### 第二节：强化练习

1.  敏感词过滤
2.  密码格式要求
3.  留言过滤

#### 第三节：精讲

1.  ASCII码和字符集

    * ASCII（American Standard Code for Information Interchange:美国信息交换标准代码）是基于拉丁字母的一套电脑编码系统，主要用于显示现代英语和其他西欧语言。它是现今最通用的系统，并等同于国际标准ISO/IEC 646

 	```
	var str = "A";
	str.charCodeAt();  // 65
	

	var str1 = 'a';
	str1.charCodeAt();  // 97
	```

2. 字符串常见API

   * str.length (计算空格)

   * charAt(3) //获取下标为3的字符 默认是第0个 找不到的情况

   * charCodeAt(3) //获取下标为3的字符的Unicode码

   * String.fromCharCode()

     ```
     	0-9 48-57
     ```

     > 检测字符串中有没有数字

     ```
     var stringValue = "hello world";
     console.log(stringValue.charAt(1));//e
     console.log(stringValue.charCodeAt(1));//101
     console.log(stringValue[1]);//e
     ```

   * indexOf("abc")  查找字符串第一次出现的位置 第二个参数 从第几个开始找

   * lastIndexOf("abc")  查找字符串最后一次出现的位置  如果没找到  返回-1

     * 可以同时找几个
     * 只查一次

     > 找到字符串中 'www.1000phone.com' 1是第几个

     > 找到字符串中 '' 某个字出现过几次 第几位

     ```
     	while(str.indexOf(s,i) != -1){
     	alert(str.indexOf(s,i))
     		i = str.indexOf(s,i)+s.length
     	}
     ```

   * 字符串的比较

     > '1000' > '2'

     > '1000' > 2

     > '张三' > '李四'

   * substring(start,end)//截取字符串，从第start位开始，到end位停止

     * substring(0,2)
     * substring(2,0)
     * substring()  // 默认从0-最后

   * split(separator, howmany) //根据分隔符、拆分成数组

     > 'hello' 分割

     > 'www.1000phone.com' 分割

     > '2019-04-04' 分割

     * 限制截取长度

   * toLowerCase() toUpperCase()

#### 第四节：强化练习

1. 统计字符串中每个字符的个数？

   ```
     var testStr = 'aoifhoiwehfoiweiwadakl';
     var i;
     var tempObj = {};
     for (i = 0; i < testStr.length; i++) {
       var charAt = testStr.charAt(i);//相当于挨个遍历字符串字符，将字符作为key,出现的次数作为value
       if (tempObj[charAt]) {
         tempObj[charAt]++;
       } else {
         tempObj[charAt] = 1;
       }
     }
     console.log(tempObj);
   ```

#### 第五节：强化练习

1.  数字字母混合验证码

2.  aabccd统计每个字符出现的次数，结果显示 a 2、b 1、c 2、d1，去掉重复的字符，使结果显示 abcd

3.  JSON表示对象的方法
    * JSON（JavaScript Object Notation）一种简单的数据格式
    * {名称1:值,名称2:值2}
    * 元素值可具有的类型：string, number, object, array, true, false, null
    * for in