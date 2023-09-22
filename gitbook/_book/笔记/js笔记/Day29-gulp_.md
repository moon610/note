# Gulp

[中文网](https://www.gulpjs.com.cn/)

自动化构建工具：压缩js、压缩css、处理图像、编译sass/less资源，形成完整的构建流程等

gulp 将开发流程中让人痛苦或耗时的任务自动化，从而减少你所浪费的时间、创造更大价值。

## 全局安装 gulp-cli

全局安装 `gulp-cli` 命令行工具：

```bash
$ npm i gulp-cli -g
```

安装完成后，使用 `gulp --verion` 测试：

```bash
$ gulp --version
```

如果能够看到类似如下提示，则说明安装成功：

```bash
CLI version: 2.3.0
Local version: Unknown
```

**注意：全局安装 gulp-cli 只需要执行一次即可**

## 创建项目与 package.json 文件

```bash
$ mkdir gulp-demo
$ cd gulp-demo
$ npm init -y
```

## 本地安装 gulp

本地安装 gulp 包资源：

```bash
$ npm i gulp --save-dev
# 或
$ npm i gulp -D
```

本地安装gulp完毕后，可执行 `gulp --version` 查看版本：

```bash
$ gulp --verion

CLI version: 2.3.0
Local version: 4.0.2
```

## 创建 gulpfile.js 文件

在项目根目录（与 package.json 文件同目录）中创建 gulpfile.js 文件，该文件是 gulp 工具的配置文件，用于定义各种自动化构建任务：

```js
function defaultTask(cb) {
  // place code for your default task here
  console.log('执行默认任务...')
  cb();
}

exports.default = defaultTask
```

exports.default 是导出默认任务

## 测试默认任务

在命令行中，项目根目录下，执行 `gulp` 命令：

```bash
$ gulp
```

类似看到如下执行结果：

```bash
[11:16:22] Using gulpfile D:\courses\cd-2107\JavaScript\week-06\day05-gulp\gulp-demo\gulpfile.js
[11:16:22] Starting 'default'...
执行默认任务...
[11:16:22] Finished 'default' after 8.23 ms
```

可以使用 `gulp <task-name>` 来执行其它任务，如：

```bash
$ gulp uglifyjs
```

任务名称是在 `gulpfile.js` 文件中 `exports.xxx`  时定义的名称

## 定义 gulp 任务

gulp 任务的执行通常是结合相关插件来完成

### 压缩 js 任务

安装 `gulp-uglify` 插件：

```bash
$ npm install --save-dev gulp-uglify
# 或
$ npm i gulp-uglify -D
```

定义 gulpfile.js 文件中的任务：

```js
// 引入包资源
const gulp = require('gulp')
const uglify = require('gulp-uglify')

// 定义变量，保存各种资源的路径
const paths = {
  js: {
    src: 'src/js/**/*.js', // js 文件的源路径
    dest: 'dist/js' // js 处理后的目标路径
  }
}

// 定义任务函数
function scripts() {
  return gulp.src(paths.js.src)
    .pipe(uglify())
    .pipe(gulp.dest(paths.js.dest))
}

// 导出任务
exports.scripts = scripts
```

执行任务：

```bash
$ gulp scripts
```

### 压缩 css 任务

插件：gulp-clean-css

```bash
$ npm install gulp-clean-css --save-dev
```

### 压缩 html 任务

插件：gulp-htmlmin

```bash
$ npm install --save-dev gulp-htmlmin
```



### 转译 js

插件：gulp-babel

```bash
$ npm install --save-dev gulp-babel@7 babel-core babel-preset-env
```

### sass 编译

插件：gulp-sass

```bash
$ npm install sass gulp-sass --save-dev
```

## 流程化

```js
const build = gulp.series(clean, gulp.parallel(styles, scripts, buildScss, html, copyLibs, watch))
```



## 示例代码

```js

//引入资源
const gulp = require('gulp')
const htmlmin = require('gulp-htmlmin')
const cleanCSS = require('gulp-clean-css')
const babel = require('gulp-babel')
const uglify = require('gulp-uglify')
const sass = require('gulp-sass')(require('sass'))
const del = require('del')
const connect = require('gulp-connect')
const path = require('path')
// const { resolve } = require('path')
// const { rejects } = require('assert')
//设置资源路径
const paths = {
    html: {
        src: 'src/**/*.html',
        dest: 'dist'
    },
    css: {
        src: 'src/css/**/*.css',
        dest: 'dist/css'
    },
    js: {
        src: 'src/js/**/*.js',
        dest: 'dist/js'
    },
    scss: {
        src: 'src/scss/**/*.scss',
        dest: 'dist/css'
    },
    libs: {
        src: 'src/libs/**/*.*',
        dest: 'dist/libs'
    },
    imgs: {
        src: 'src/images/**/*.*',
        dest: 'dist/images'
    }
}
//定义处理html文件的函数
function html() {
    return gulp.src(paths.html.src)
    //collapseWhitespace是否处理空白html字符，minifyCSS,minifyJS:是否处理HTML中的CSS、JS代码
    .pipe(htmlmin({ collapseWhitespace: true, minifyCSS: true, minifyJS: true }))
    
    .pipe(gulp.dest(paths.html.dest))
    .pipe(connect.reload())
}
function cleanHtml() {
    return del([paths.html.dest+'/**/*.html'])//'**'指文件夹，'*.*'指文件
}
// 处理css文件
function styles(){
    return gulp.src(paths.css.src)
    .pipe(cleanCSS())
    .pipe(gulp.dest(paths.css.dest))
    .pipe(connect.reload())
}
//预编译scss文件
function buildScss() {
    return gulp.src(paths.scss.src)
    .pipe(sass({outputStyle: 'compressed'}))//选择编译风格：nested、expanded、compact、compressed
    .pipe(gulp.dest(paths.scss.dest))
    .pipe(connect.reload())
}
function cleanCss() {
    return del([paths.css.dest+'/*'])
}
//转译压缩js
function scripts(){
    return gulp.src(paths.js.src)
    .pipe(babel({
        presets: ['env']
    }))
    .pipe(uglify())
    .pipe(gulp.dest(paths.js.dest))
    .pipe(connect.reload())
}
function cleanScripts() {
    return del([paths.js.dest+'/*.js'])
}
//复制无需特殊处理的资源
function copyLibs() {
    return gulp.src(paths.libs.src)
    .pipe(gulp.dest(paths.libs.dest))
    .pipe(connect.reload())
}
function cleanLibs() {
    return del([paths.libs.dest+'/**/*.*'])
}
function copyImgs() {
    return gulp.src(paths.imgs.src)
    .pipe(gulp.dest(paths.imgs.dest))
    .pipe(connect.reload())
}
function cleanImgs() {
    return del([paths.imgs.dest+'/**/*.*'])
}
//清理dist目录
function clean (){
    return del(['dist'])
}
//定义监视任务,当检测到第一个参数的文件发生变化就执行第二个参数的方法
async function watch() {
    gulp.watch(paths.html.src, gulp.series(cleanHtml, html)).on('error', function (error) {
        console.log(error);
        this.emit('end');//错误处理，emit表示任务结束避免任务卡死
    })
    gulp.watch([paths.css.src, paths.scss.src], gulp.series(cleanCss, styles, buildScss)).on('error', function (error) {
        console.log(error);
        this.emit('end');
    })
    gulp.watch(paths.js.src, gulp.series(cleanScripts, scripts)).on('error', function (error) {
        console.log(error);
        this.emit('end');
    })
    gulp.watch(paths.libs.src, gulp.series(cleanLibs, copyLibs)).on('error', function (error) {
        console.log(error);
        this.emit('end');
    })
    gulp.watch(paths.imgs.src, gulp.series(cleanImgs, copyImgs)).on('error', function (error) {
        console.log(error);
        this.emit('end');
    })
}
//启动webserver服务器,如果不加async会提示任务未完成
async function server() {
     connect.server({
        root: 'dist',//设置服务器根目录
        port: 8888, //设置端口
        livereload: true //server启动时运行livereload
    })
}
//在任务后面添加.pipe(connect.reload()),当任务执行时就会触发浏览器刷新
//形成处理流程
//gulp.series函数中的任务将按顺序依次执行
//gulp.parallel函数中的任务将同时执行
const build = gulp.series(clean, gulp.parallel(html, styles, scripts, buildScss, copyLibs, copyImgs, watch, server))

//导出任务
// exports.html = html
// exports.cleanCss = styles
// exports.scripts = scripts
// exports.buildScss = buildScss
// exports.clean = clean
// exports.copyLibs = copyLibs
// exports.copyImgs = copyImgs
// exports.build = build
// exports.watch = watch
// exports.copyimg = copyimg
//默认任务
exports.default = build

```

