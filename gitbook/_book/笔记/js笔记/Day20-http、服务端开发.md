URL 格式：

```html
协议://域名:端口/资源路径?查询字符串#hash
```

端口，用于标识联网的应用程序

# [HTTP](https://www.runoob.com/http/http-tutorial.html)

http://10.7.189.59:5500/demo1-test.html

https://www.baidu.com/

是因特网上应用最为广泛的一种网络传输协议

HTTP协议工作于客户端-服务端架构上。**浏览器**作为HTTP客户端通过URL向HTTP服务端即**WEB服务器**发送所有请求。

Web 服务器：Apache、IIS、Tomcat、Nginx、...........

**HTTP 默认端口是 80**

**HTTPS 默认端口是 443**

## HTTP 消息结构

## HTTP 请求方法

[GET 与 POST 的区别](https://www.runoob.com/tags/html-httpmethods.html)

## HTTP 状态码

200 - OK，成功

403 - Forbidden，拒绝

404 - Not Found，资源未找到

500 - 服务器内部异常，通常是服务端代码执行出错导致



1xx：消息

2xx：成功

3xx：重定向

4xx：客户端错误

5xx/6xx：服务端错误

# NodeJS

Node.js 就是运行在服务端的 JavaScript。

Node.js 是一个基于Chrome JavaScript 运行时（V8引擎）建立的一个平台。

## npm

node package manager（node 包资源管理工具），主要用于安装、卸载、更新、发布（等操作） Node 平台上的各种包资源。

[https://www.npmjs.com/](https://www.npmjs.com/)：所有发布到 node 平台的包都可以在该网站查询到

### 安装包

```bash
$ npm install <package-name> --save-dev -g
```

- `install` 可以简写为 `i`
- `<package-name>` 是需要安装的包的名称
- `--save` 是保存安装包资源到项目依赖环境中，可省略，当省略时，默认为 `--save`
- `--save-dev` 是保存安装包资源到项目的开发依赖环境中
- `-g` 是全局安装
- 安装包资源时，会在项目目录下建立 `node_modules` 目录来保存所安装的资源数据

## package.json

这是项目的配置文件，与项目相关的配置信息是保存在该文件中

### 创建 package.json

```bash
$ npm init -y
```

### npm scripts

npm 脚本，主要是一些复杂的 node 任务要执行时，输入命令比较繁琐，可以使用 `npm scripts` 来定义脚本，然后利用 `npm run` 执行这些脚本

## 创建 webserver

利用 Express 来实现 webserver 创建：

1. 创建项目目录  server
2. 在项目根目录下创建 package.json 文件

```bash
$ npm init -y
```

3. 安装 express：

```bash
$ npm install express
```

安装后在项目目录下生成 `node_modules` 目录

4. 在项目根目录下创建 app.js 文件：

```js
// 引入 express
const express = require('express')

// 创建 Express 应用实例
const app = express()

// 托管静态资源
app.use(express.static('public'))

// 监听端口，等待客户端浏览器连接
app.listen(9527, () => console.log('Server running at http://localhost:9527'))
```

5. 创建 public 目录，在 public 目录下的资源是浏览器中能够直接访问到的静态资源，如html、css、js、Image、videos.......

6. 运动webserver

```bash
$ node app.js
```

# MySQL

数据库（Database）是按照数据结构来组织、存储和管理数据的仓库。

数据库产品：MySQL、SQL Server、Oracle、DB2、SQLite.......

## 概念：

- **数据库:** 数据库是一些关联表的集合。
- **数据表:** 表是数据的矩阵。在一个数据库中的表看起来像一个简单的电子表格。由行与列组成
- **行：**一行（=元组，或**记录**）是一组相关的数据，例如一条用户订阅的数据。
- **列:** 是每条记录的**特征**信息，一列(数据元素) 包含了相同类型的数据, 例如邮政编码的数据。
- **主键**：主键是唯一的。一个数据表中只能包含一个主键。你可以使用主键来查询数据。**作用：唯一标识记录**

## 使用

### 安装

### 创建数据库

### 在数据库中创建表

### 表中实现CRUD(SQL)

#### 插入数据

```sql
-- INSERT INTO 表名 (列名1, 列名2) VALUES (列值1, 列值2)
INSERT INTO `students` (`name`, `sex`) VALUES ('李四', '男')
```

#### 修改数据

```sql
-- UPDATE 表名 SET 列名1=列值1, 列名2=列值2 WHERE 条件
UPDATE `students` SET `sex`='男', `birthday`='2000-02-02', `phone`='13455667788' WHERE (`id`='1')
```

注意，不添加 WHERE 子句，是会将整张表的数据更新成相同的值，这种修改是不可撤销的

#### 删除数据

```sql
-- DELETE FROM 表名 WHERE 条件
DELETE FROM `students` WHERE (`id`='2')
```

不使用 WHERE 子句时，会删除整张表的数据，这种删除是不可撤销的

#### 查询数据

```sql
-- SELECT 列名1, 列名2, ...
-- FROM 表名
-- WHERE 条件
-- ORDER BY 排序的列名 ASC|DESC
-- LIMIT 起始索引, 限定查询的条数
SELECT * FROM `students` LIMIT 0, 1000
```

## NodeJS 中连接MySQL数据库

1. 安装驱动

```bash
$ npm i mysql
```

2. 连接数据库

```js
// 连接数据库
const mysql      = require('mysql')
const connection = mysql.createConnection({
  host     : 'localhost', // 数据库服务器主机
  user     : 'root', // 连接数据库的用户名
  password : '123456', // 密码
  database : 'h52107' // 数据库名
})
// 连接
connection.connect()

/* 到数据库中验证用户名与密码 */
// 创建 SQL 语句
const sql = 'SELECT COUNT(*) AS total FROM users WHERE username=? AND password=?'
const params = ['abc', 'test']
// 查询
connection.query(sql, params, (err, result) => {
    if (err) {
        response.send('有异常')
        return
    }
    console.log('result:', result)
    // 返回响应
    if (result[0].total === 1) {
        response.send('用户登录成功')
    } else {
        response.send('用户名或密码错误')
    }
})
```

