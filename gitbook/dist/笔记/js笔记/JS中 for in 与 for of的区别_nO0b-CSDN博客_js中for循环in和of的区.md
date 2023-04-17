最直接的区别就是:

### <a id="t0"></a>for in遍历的是数组的索引（即键名），

### <a id="t1"></a>而for of遍历的是数组元素值。

```
1.  Array.prototype.method=function(){}
    
2.  var myArray=[1,2,4];
    
3.  myArray.name="数组";
    

5.  for (var index in myArray)
    
6.  console.log(myArray[index]);    
    

8.  for (var value of myArray) 
    
9.  console.log(value); 
```

除此之外还有一些细节:

for in的一些**缺陷**:

1.  索引是字符串型的数字，因而不能直接进行几何运算
2.  遍历顺序可能不是实际的内部顺序
3.  for in会遍历数组所有的可枚举属性，包括原型。例如的原型方法method和name属性

故而一般用**for in遍历对象而不用来遍历数组**

 这也就是for of存在的意义了,**for of 不遍历method和name,适合用来遍历数组**

 那for of有缺点吗? 当然有了:

**for of不支持普通对象**，想遍历对象的属性，可以用for in循环, 或内建的Object.keys()方法：

**Object.keys(myObject)获取对象的实例属性组成的数组，不包括原型方法和属性**

```


1.  for (var key of Object.keys(Object))
    
2.  console.log(key + ": " + Object[key]);
    


```

但是感觉这样有些多此一举,

### <a id="t2"></a>总结来说:

**for of 遍历数组**

**for in 遍历对象**