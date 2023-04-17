npm 查看安装了哪些包
============

指令1： `npm list --depth=0`
-------------------------

> –depth 表示深度，我们使用的模块会有依赖，深度为零的时候，不会显示依赖模块

这个指令可以用来 显示 出我们的项目中安装了哪些模块，其实就是 [package](https://so.csdn.net/so/search?q=package&spm=1001.2101.3001.7020).json 文件中 的 dependencies 和 devDependencies 的和


PS C:\Users\by\Desktop\jsPang\awesomePos> npm list --depth=0

> 当然我们可以在加参数 `npm list --depth=0 [--dev | --production]`

指令2： `npm list --depth --global`
--------------------------------

这个指令用来查看全局安装了哪些工具

```null
PS C:\Users\by\Desktop\jsPang\awesomePos> npm list --depth=0 --global
C:\Users\by\AppData\Roaming\npm
+-- chrome-remote-interface@0.25.4
+-- create-react-app@1.4.0
+-- eslint@4.17.0
+-- jshint@2.9.4
+-- less@2.7.2
+-- live-server@1.2.0
+-- mysql@2.15.0
+-- sass@1.0.0-beta.1
+-- sequelize-auto@0.4.29
+-- vue-cli@2.8.2
`-- webpack@3.6.0
```

指令3： `npm list <packagename>`
-----------------------------

这个指令用来查看某个模块是否安装了

```null
PS C:\Users\by\Desktop\jsPang\awesomePos> npm list element-ui
awesome_pos@1.0.0 C:\Users\by\Desktop\jsPang\awesomePos
`-- element-ui@2.2.2
```

官网详情
----

> 这篇文章目的在于推荐下几个常用的指令

[传送门](https://docs.npmjs.com/cli/ls)

 