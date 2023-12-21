# JavaScript Class类详解



> ECMAScript 6 提供了更接近传统语言的写法，新引入的[class](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FClasses)关键字具有正式定义类的能力。类（class）是ECMAScript中新的基础性语法糖结构，虽然ECMAScript 6类表面上看起来可以支持正式的面向对象编程，但实际上它背后使用的仍然是原型和构造函数的概念，让对象原型的写法更加清晰、更像面向对象编程的语法。

## 一、类的定义

定义类也有两种主要方式：类声明和类表达式。这两种方式都使用class关键字加大括号：

```kotlin
kotlin复制代码// 类声明
class Person {}

// 类表达式
const TestPerson = class {}
```

注意：**函数声明**和**类声明**之间的一个重要区别在于，函数声明会[提升](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FGlossary%2FHoisting)，类声明不会。需要先声明类，然后再访问它，否则就会出现[ReferenceError](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FGlobal_Objects%2FReferenceError)，如：

```arduino
arduino复制代码const test = new Person(); // ReferenceError: Person is not defined

class Person {}
```

另一个跟函数声明不同的地方是，函数受函数作用域限制，而类受[块作用域](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FGlossary%2FBlock%2FScripting)限制：

```javascript
javascript复制代码{
    function FunctionDeclaration () {}
    class ClassDeclaration {}
    // 使用var 声明
    var VarClass = class {}
    // 使用let/const 声明
    let LetClass = class {}
}

console.log(FunctionDeclaration) // FunctionDeclaration () {}
console.log(ClassDeclaration) // ReferenceError: ClassDeclaration is not defined
console.log(VarClass) // class {}
console.log(LetClass) // ReferenceError: letClass is not defined
```

class 类完全可以看成构造函数的另一种写法，这种写法可以让对象的原型属性和函数更加清晰。

```javascript
javascript复制代码class Person {}

console.log(typeof Person) // function
console.log(Person === Person.prototype.constructor) // true
```

上面代码表明，类的数据类型就是函数，类本身就指向构造函数。

## 二、类构造函数

constructor 方法是一个特殊的方法，这种方法用于创建和初始化一个由`class`创建的对象。通过 new 关键字生成对象实例时，自动会调用该方法。一个类只能拥有一个名为constructor构造函数，不能出现多个，如果定义了多个constructor构造函数，则将抛出 一个[SyntaxError](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FGlobal_Objects%2FSyntaxError)错误。如果没有定义constructor构造函数，class 会默认添加一个空的constructor构造函数。

```kotlin
kotlin复制代码class Person {}

// 等于

class Person {
    constructor () {}
}
```

使用new操作符实例化Person的操作等于使用new调用其构造函数。唯一可感知的不同之处就是，JavaScript解释器知道使用new和类意味着应该使用constructor函数进行实例化。

类必须使用`new`调用，否则会报错。这是它跟普通构造函数的一个主要区别，后者不用`new`也可以执行。

```scss
scss复制代码class Person {}

Person() // TypeError: Class constructor Test1 cannot be invoked without 'new'
```

使用new调用类的构造函数会执行如下操作。

1. 在内存中创建一个新对象；
2. 这个新对象内部的[[Prototype]]指针被赋值为构造函数的prototype属性；
3. 构造函数内部的this被赋值为这个新对象（即this指向新对象）；
4. 执行构造函数内部的代码（给新对象添加属性）；
5. 如果构造函数返回非空对象，则返回该对象；否则，返回刚创建的新对象；

一起来看看下面例子：

```javascript
javascript复制代码class Person {}

class Test1 {
    constructor () {
        console.log('Test1 初始化')
    }
}

class Test2 {
    constructor () {
        this.test = '通过初始化构造函数设置值'
    }
}

// 构造函数返回指定对象
const dataObj = { n: '自定义实例对象' }
class Test3 {
    constructor () {
        this.test = '通过初始化构造函数设置值'
        return dataObj
    }
}

const a = new Person();
const b = new Test1(); // Test1 初始化
const c = new Test2();
console.log(c.test) // 通过初始化构造函数设置值

const d = new Test3();
d instanceof Test3; // false
console.log(d) // { n: '自定义实例对象' }
```

类实例化时传入的参数会用作构造函数的参数。如果不需要参数，则类名后面的括号也是可选的：

```javascript
javascript复制代码class Person {
    constructor (...args) {
        console.log(args.length)
    }
}

class Test1 {
    constructor (test) {
        console.log(arguments.length)
        this.test = test || '默认值'
    }
}

// 不传值 可以省略()
const a = new Person // 0
const b = new Person('1', '2') // 2

const c = new Test1() // 0
console.log(c.test) // 默认值

const d = new Test1('传入值') // 1
console.log(d.test) // 传入值

const d = new Test1('1', '2', '3') // 3
console.log(d.test) // 1
```

与立即调用函数表达式相似，类也可以立即实例化：

```arduino
arduino复制代码const a = new class Person {
    constructor (text) {
        this.text = text
        console.log(text)
    }
}('立即实例化类');

// 立即实例化类

console.log(a); // Person
```

## 三、类的实例 、原型及类成员

类的语法可以非常方便地定义应该存在于实例上的成员、应该存在于原型上的成员，以及应该存在于类本身的成员。

实例的属性除非显式定义在其本身（即定义在`this`对象上），否则都是定义在原型上。

每个实例都对应一个唯一的成员对象，这意味着所有成员都不会在原型上共享:

```javascript
javascript复制代码class Person {
    constructor (x, y) {
        this.text = new Number(1);
        this.x = x
        this.y = y
        this.getText = () => {console.log(this.text)}
    }

    toString () {
        console.log(`${this.x}, ${this.y}`)
    }
}

const test1 = new Person('x', 'y'), test2 = new Person('x2', 'y2');

console.log(test1.getText()) // Number {1}
console.log(test2.getText()) // Number {1}
console.log(test1.x, test1.y) // x  y
console.log(test2.x, test2.y) // x2  y2

// console.log(test1.text === test2.text)  // false
// console.log(test1.getText === test2.getText)  // false

test1.text = '测试'

console.log(test1.getText()) // 测试
console.log(test2.getText()) // Number {1}

test1.toString() // x, y
test2.toString() // x2, y2

test1.hasOwnProperty('x'); // true
test1.hasOwnProperty('y'); // true
test1.hasOwnProperty('getText'); // true
test1.hasOwnProperty('toString'); // false
test1.__proto__.hasOwnProperty('toString'); // true

// 类的实例共享同一个原型对象
console.log(test1.__proto__ === test2.__proto__) // true

// 也可以使用ES6提供的 Object.getPrototypeOf 来获取prototype 
const test1Prototype = Object.getPrototypeOf(test1)
test1Prototype.myName = '共享字段'

// test2 中也是能获取到
console.log(test2.myName) // 共享字段
```

x、y、text和getText都是实例对象test1自身的属性，所以hasOwnProperty()方法返回true，而toString()是原型对象的属性（因为定义在Person类），所以hasOwnProperty()方法返回false，这些都与 ES5 的行为保持一致。

类的所有实例共享同一个原型对象。这也意味着，可以通过实例的`__proto__`属性或Object.getPrototypeOf方法获取原型为“类”添加方法，这将会出现共享情况，必须相当谨慎，不推荐使用，因为这会改变“类”的原始定义，影响到所有实例。

类方法等同于对象属性，因此可以使用字符串、符号或计算的值作为键：

```scss
scss复制代码const symbolKey = Symbol('test')

class Person {
    stringKey () {
        console.log('stringKey')
    }

    [symbolKey] () {
        console.log('symbolKey')
    }

    ['calculation' + '1'] () {
        console.log('calculation')
    }
}

const a = new Person();

a.stringKey() // stringKey
a[symbolKey]() // symbolKey
a.calculation1() // calculation
```

### getter 与 setter

在 class 内部可以使用 get 与 set 关键字，对某个属性设置存值函数和取值函数，拦截该属性的存取行为。

```kotlin
kotlin复制代码class Person {
    constructor (test) {
        this.test = test || '默认值'
    }

    get prop () {
        return this.test
    }

    set prop (value) {
        console.log(`setter prop value: ${value}`)
        this.test = value
    }
}

const p = new Person('1')

p.prop // 1

p.prop = '2' // setter prop value: 2

p.prop // 2
```

set函数和get函数是设置在属性的 Descriptor 对象上的,可以通过 Object.getOwnPrototyDescriptor 来获取指定属性的指定描述对象。

```javascript
javascript复制代码const descriptor = Object.getOwnPropertyDescriptor(Person.prototype, 'prop')

'get' in descriptor // true
'set' in descriptor // true
```

### Generator 方法

如果某个方法之前加上星号（`*`），就表示该方法是一个 Generator 函数:

```scss
scss复制代码class Person {
  constructor(...args) {
    this.args = args;
  }
  * generatorFun () {
    for (let arg of this.args) {
      yield arg;
    }
  }
}

const a = new Person(1,2,3,4);
const generatorNext = a.generatorFun().next
generatorNext() // {value: 1, done: false}
generatorNext() // {value: 2, done: false}
generatorNext() // {value: 3, done: false}
generatorNext() // {value: 4, done: false}
generatorNext() // {value: undefined, done: true}
```

### this 指向

类的方法内部如果含有`this`，它默认指向类的实例。但是某些情况是指向当前执行环境；

```arduino
arduino复制代码class Person {
    constructor () {
        this.text = '1'
    }

    getText () {
        console.log(this.text)
    }
}

const a = new Person()

a.getText() // 1

const {getText} = a

// this 指向为undefined class 默认严格模式
getText() // TypeError: Cannot read properties of undefined (reading 'text')
```

上面找不到 this 问题，`this`会指向该方法运行时所在的环境，因为 class 内部是严格模式，所以 this 实际指向的是`undefined`。有两个方法解决当前问题：

第一、构造方法中绑定`this`:

```kotlin
kotlin复制代码class Person {
    constructor() {
        this.text = '1'
        this.getText = this.getText.bind(this)
    }

    getText () {
        console.log(this.text)
    }
}
```

第二、使用箭头函数:

```javascript
javascript复制代码class Person {
    constructor() {
        this.text = '1'
    }

    getText = () => {
        console.log(this.text)
    }
}
```

箭头函数内部的 `this`总是指向定义时所在的对象。

第三、使用proxy 在获取方法的时候自动绑定this:

```kotlin
kotlin复制代码function classProxy (target) {
    const map = new Map()
    
    // 读取拦截配置, 只需要配置 get
    const hanlder = {
        get(target, key) {
            const val = Reflect.get(target, key)
            // 要获取的是函数执行, 如果不是函数就直接返回 val
            if (typeof val !== 'function') return val

            if (!map.has(val)) {
                // 使用 bind改变运行函数的 this为拦截的实例对象
                map.set(val, val.bind(target))
            }
            return map.get(val)
        }
    }
    const proxy = new Proxy(target, hanlder)
    return proxy
}

class Person {
    constructor (text) {
        this.text = text
    }

    getText () {
        console.log(this.text)
        return this.text
    }
}

const person = classProxy(new Person('test'))

const { getText } = person

getText() // test
```

## 四、静态方法、静态属性及静态代码块

静态方法、静态属性及静态代码块([proposal-class-static-block](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Ftc39%2Fproposal-class-static-block))都是使用 `static`关键字定义的属性、方法或块只能 class 自己用，不能通过实例继承。

静态方法中的this 指向的是 当前类，而不是指向实例对象。静态属性是当前类自身的属性。

```javascript
javascript复制代码class Person {
    static staticProp = 'Person静态属性'

    constructor () {
        // 通过 类名 获取
        console.log(`output: ${Person.staticProp}`)

        // 也可以通过 构造函数的属性
        this.constructor.staticFun1()
    }

    static staticFun1 () {
        this.staticFun2()
        console.log(`output: 静态方法staticFun1,获取Person静态属性 ==> ${Person.staticProp}`)
    }

    static staticFun2 () {
        console.log(`output: 静态方法staticFun2,获取静态属性 ==> ${this.staticProp}`)
    }
}

Person.staticProp // 静态属性

Person.staticFun1() 
// output: 静态方法staticFun2,获取静态属性 Person静态属性
// output: 静态方法staticFun1,获取Person静态属性 ==> Person静态属性

const a = new Person() // output: Person静态属性
a.staticProp // undefined
a.staticFun1 // undefined
a.staticFun2 // undefined
// 通过其原型构造函数还是能获取到 这些静态属性及方法 不推荐使用
// a.__proto__.constructor.staticProp
// a.__proto__.constructor.staticFun1()
```

### 静态代码块：

是在 Class 内创建了一个块状作用域，这个作用域内拥有访问 Class 内部私有变量的特权，在这个代码块内部，可以通过 `this` 访问 Class 所有成员变量，包括 `#` 私有变量，且这个块状作用域仅在引擎调用时初始化执行一次 ，决解以前初始化静态类属性需要设置一个静态变量初始化逻辑。

注意： `static` 变量或代码块都按顺序执行，父类优先执行，一个类中允许多个静态代码块存在。

```kotlin
kotlin复制代码class Person {
    static staticProp = '静态属性'
    static staticPropArr = []
    static staticPropObj = {}
    
    static getStatic (name) {
        console.log(`获取：${name}`, name && this[name])
        return name && this[name]
    }

    static resetData (name, data) {
        name && (this[name] = data)
        console.log(`重置：${name}`, name && this[name])
    }

    static {
        console.log('静态代码块执行');
        this.getStatic('staticProp');
        this.getStatic('staticPropArr');
        this.getStatic('staticPropObj');

        this.resetData('staticProp', '重置静态属性');
        this.resetData('staticPropArr', ['重置静态数组']);
        this.resetData('staticPropObj', { text: '重置静态对象' });

        this.staticPropObj.staticBlock1 = '代码块中直接设置'
        console.log(this.staticPropObj)
    }
}

/**
* 静态代码块执行
  获取：staticProp 静态属性
  获取：staticPropArr []
  获取：staticPropObj {}
  重置：staticProp 重置静态属性
  重置：staticPropArr ['重置静态数组']
  重置：staticPropObj {text: '重置静态对象'}
  {text: '重置静态对象', staticBlock1: '代码块中直接设置'}
*/
```

上面代码中可以看出，`static` 关键字后面不跟变量，而是直接跟一个代码块，就是 class static block 语法的特征，在这个代码块内部，可以通过 `this` 访问 Class 所有成员变量，包括 `#` 私有变量。

在这里提前使用一下私有变量，理论上 class 私有变量外部是访问不了的，但是有了静态代码块( ****[class-static-block](https://link.juejin.cn/?target=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttps%3A%2F%2Fgithub.com%2Ftc39%2Fproposal-class-static-block)*** *)之后，我们可以将私有属性暴露给外部变量：

```javascript
javascript复制代码let privateValue

export class Person {
  #value
  constructor(x) {
    this.#value = x
  }

  static {
    privateValue = (obj) => obj.#x;
  }
}

export function getPrivateValue (obj) {
  return privateValue(obj)
}

// 在另一个文件中 
import { Person, getPrivateValue } from 'xxx'

const a = new Person('私有变量')

getPrivateValue(a) // 私有变量
```

其实class-static-block本质上并没有增加新功能，我们完全可以用普通静态变量代替，只是写起来很不自然，所以这个特性可以理解为对缺陷的补充，或者是语法完善，个人认为现在越来越像java。

## 五、私有属性和私有方法

私有属性和私有方法，是只能在类的内部访问的方法和属性，外部不能访问，不可以直接通过 Class 实例来引用，其定义方式只需要在方法或属性前面添加`#`。

私有属性：

```arduino
arduino复制代码class Person {
    #privateVar1;
    #privateVar2 = '默认值';
    
    constructor (text) {
        this.#privateVar1 = text || '--'
        console.log(this.#privateVar1)
    }

    getPrivateData1 (key) {
        // 这里是获取不了的
        console.log('传入key来获取私有变量：', this[key])
        console.log('获取私有变量', this.#privateVar2, this.#privateVar1)
    }

    static staticGetPrivateData (person, key) {
        console.log('静态方法获取私有变量：', person.#privateVar2, person.#privateVar1)                     
        // 下面是获取不到
        console.log('静态方法传入key来获取私有变量：', person[key]) 
    }
}

const a = new Person() // 不传 默认 --
// output: --

a.getPrivateData1('#privateVar1')
// output: 传入key来获取私有变量：undefined
// output: 获取私有变量：  默认值  --

// 使用静态方法
Person.staticGetPrivateData(a, '#privateVar1')
// output: 静态方法获取私有变量：  默认值  --
// output: 静态方法传入key来获取私有变量：undefined
```

从上面代码中我们可以看到，私有变量是只能内部读取或写入，不能通过动态key读取（外部调用就会报错）

注意：在class 中 公共属性 test 与 #test 是两个完全不同的值；

私有方法：

```arduino
arduino复制代码class Person {
    #private;
    
    constructor () {
        this.#private = '私有变量'
        this.#methods() // 调用私有方法
    }

    #methods () {
        console.log('私有方法#methods:', this.#private)
    }

    static #staticMethods (person) {
        if (person) {
            console.log('静态私有方法#staticMethods person获取值', person.#private)
            person.#methods()
        }
    }

    init1 () {
        this.#methods()
        console.log('使用this')
        Person.#staticMethods(this)
    }

    init2 (person) {
        if (person) {
            console.log('使用传入实例')
            Person.#staticMethods(person)
        }
       
    }
}

const a = new Person()
// output: 私有方法#methods: 私有变量

// a.#methods()  SyntaxError
// a['#methods']()  TypeError: a.#methods is not a function

a.init1()
// output: 私有方法#methods: 私有变量
// output: 使用this
// output: 静态私有方法#staticMethods person获取值 私有变量
// output: 私有方法#methods: 私有变量

a.init2(a)
// output: 使用传入实例
// output: 静态私有方法#staticMethods person获取值 私有变量
// output: 私有方法#methods: 私有变量
```

从上面代码中我们可以看到，私有方法只能内部调用，在外部调用就会报错。

## 六、继承 extends

使用 extends 关键字，让子类继承父类的属性和方法。

```javascript
javascript复制代码class Person {
    num = 1
    text = 'person'

    getNum = () => console.log(this.num, this)

    addNum () {
        console.log(++this.num, this)
    }
}

// 继承
class Child extends Person {
    constructor () {
        super()
        this.getText()
    }

    getText = () => console.log(this.text, this)
}

const a = new Child() // output: person  Child {}

console.log(a instanceof Child) // output: true
console.log(a instanceof Person) // output: true

a.getText() // output: person Child {}
a.getNum() // output: 1 Child {}
a.addNum() // output: 2 Child {}
a.getNum() // output: 2 Child {}

a.text // person
a.num // 2
```

从上面代码中，我们可以看出Child 类 继承了 Person 的属性及方法，在Child 中也是可以调用Person的方法及属性，注意 this 的值会反映调用相应方法的实例或者类。子类中（Child）如果设置了 constructor 方法 就必须调用 super() ，否则就会出现新建实例时报错，如果没有 constructor 构造函数，在实例化继承类时会调用 super() ，而且会传入所有传给继承类的参数（后面会详细讲解）。

```arduino
arduino复制代码class Person {
    static staticText = 'staticText';
    #private = 'private'

    static staticMethods1 (person) {
        console.log('staticMethods1', this)
        person.#privateMethods()
    }

    #privateMethods () {
        console.log('#privateMethods', this)
    }
}

// 使用表达式格式 也是可以使用 extends 继承
const Child = class extends Person {
    methods () {
        console.log('methods', Child.staticText)
    }
}

const a = new Child()

a.methods() // output: methods staticText

Child.staticMethods1(a)
// output: staticMethods1  class Child {}
// output: #privateMethods Child {}

Person.staticMethods1(a)
// output: staticMethods1  class Person {}
// output: #privateMethods Child {}
```

使用表达式格式 也是可以使用 extends 继承，类 的静态方法与属性是可以继承的，其私有属性及方法是不能继承的，可以从继承的共有方法与静态方法 中获取其私有属性或调用其私有方法。

**super** 关键字可以作函数使用，也可以作对象使用，但是其只能在继承类中使用，且只能在继承类的constructor 构造函数、实例方法和静态方法中使用。作为函数时是在 继承类的constructor 构造函数中使用，根据要求如果继承类中定义了constructor构造函数就必须要调用super方法(调用父类的constructor)，否则就会报错。

```scala
scala复制代码class Person {}

class Child extends Person {
    constructor () {
        // 如果不调用 super() 就会报错
        // ReferenceError: Must call super constructor in derived class before accessing 'this' or returning from derived constructor  
        super() // 调用父级的constructor
        console.log(this) // Child {}  
    }
}
```

注意： constructor() 中必须super() 顶部首段执行代码，否则也是一样报错；

在使用 super() 时应该注意下面几个问题：

1. super只能在继承类构造函数和静态方法中使用。

   ```javascript
   javascript复制代码class Person {
       constructor () { 
           // 在非继承类 的constructor 中使用super 会报错
           super() //  SyntaxError: 'super' keyword unexpected here
       }
   
       methods () {
           console.log(super.text) // undefined
       }
   
       static staticMethods () {
           console.log(super.text) // undefined
       }
   }
   ```

2. 不能单独引用super关键字，要么用它调用构造函数，要么用它引用静态方法。

   ```scala
   scala复制代码class Person {}
   
   class Child extends Person {
       
       constructor () {
           super // SyntaxError: 'super' keyword unexpected here
       }
   
       methods () {
           console.log(super) // SyntaxError: 'super' keyword unexpected here
       }
   
       static staticMethods () {
           console.log(super) // SyntaxError: 'super' keyword unexpected here
       }
   }
   ```

3. 调用super()会调用父类构造函数，并将返回的实例赋值给this

   ```scala
   scala复制代码class Person {}
   class Child extends Person {
       constructor () {
           super()
           console.log(this instanceof Person) // output: true
       }
   }
   
   new Child()
   ```

4. super() 的行为如同调用构造函数，如果需要给父类构造函数传参，则需要手动传入。

   ```scala
   scala复制代码class Person {
       constructor (text) {
           this.text = text
       }
   }
   
   class Child extends Person {
       constructor (text) {
           super(text)
       }
   }
   
   // 这里注意 其text 会设置到Child 中
   const a = new Child('设置 text') // Child { text: '设置 text' }
   
   console.log(a.text) // output: 设置 text
   ```

5. 如果没有定义类构造函数，在实例化继承类时会调用super()，而且会传入所有传给继承类的参数。

   ```scala
   scala复制代码class Person {
       constructor (text) {
           this.text = text
       }
   }
   
   class Child extends Person {}
   
   const a = new Child('设置 text'); // Child { text: '设置 text' }
   
   // 上面提到过 会默认 生成 constructor (...arge) {super(...arge)}
   ```

6. 在类构造函数中，不能在调用super()之前引用this，文章上面已经有案例及说明。

7. 如果在继承类中显式定义了构造函数，则要么必须在其中调用super()，要么必须在其中返回一个对象。

   ```scala
   scala复制代码class Person {
       methods () {}
   }
   
   class Child1 extends Person {}
   
   class Child2 extends Person {
       constructor () {
           super()
       }
   }
   
   class Child3 extends Person {
       constructor () {
           return {}
       }
   }
   
   const a = new Child1() // Child1 {}
   
   const b = new Child2() // Child2 {}
   
   const c = new Child3() // {} 指向 实例函数 返回的对象 
   ```

   关于JS Class 相关就介绍到这里，当然还有 Class的 [mix-ins](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FClasses%23mix-ins_%E6%B7%B7%E5%85%A5) 混入及其他class相关知识，这边就不详细介绍了，有兴趣的同学可以自己去了解一下。

   文章内容参考了 [《JavaScript高级程序设计》(第4版)![ ](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e8cf37d784d74ecead494effd1c5e2cc~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)https://book.douban.com/subject/35175321/](https://link.juejin.cn/?target=https%3A%2F%2Fbook.douban.com%2Fsubject%2F35175321%2F)