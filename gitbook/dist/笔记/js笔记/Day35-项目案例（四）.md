# 项目案例

技术栈及工具：HTML + CSS + JavaScript + jQuery + art-template + require.js + git + sass + gulp + ......

电商类项目

实现的页面：

- 首页
- 分类（列表）页
- 详情
- 购物车
- 确认订单
- 用户注册
- 用户登录
- ......

## 步骤：

- 创建空白的 git 远程中央仓库（gitee.com）

- 将远程中央仓库克隆到本地

```bash
$ git clone <repo.url>
```

- 在工作空间中创建项目的结构

```html
project
|--src # 放置项目源代码
|--|--scss
|--|--js
|--|--images
|--|--libs
|--|--html
|--|--index.html
|--gulpfile.js # gulp 任务配置文件
|--package.json # 项目配置文件
|--.gitignore # git 忽略资源
|--README.md # 项目描述文件
```

利用 `npm init -y` 生成 package.json 文件，在文件中添加 `devDependencies` 字段：

```json
{
  "devDependencies": {
    "babel-core": "^6.26.3",
    "babel-preset-env": "^1.7.0",
    "del": "^6.0.0",
    "gulp": "^4.0.2",
    "gulp-babel": "^7.0.1",
    "gulp-clean-css": "^4.3.0",
    "gulp-connect": "^5.7.0",
    "gulp-htmlmin": "^5.0.1",
    "gulp-sass": "^5.0.0",
    "gulp-uglify": "^3.0.2",
    "sass": "^1.39.2"
  }
}
```

使用 `npm i` 安装在 `package.json` 中配置的开发依赖包：

```bash
$ npm i
# 在安装前，可修改 npm 安装的镜像源（只改一次，以后可不用再修改）： 
# npm config set registry https://registry.npm.taobao.org
```

复制 gulpfile.js 文件到项目根目录中：

```js
// 引入包资源
const gulp = require('gulp')
const uglify = require('gulp-uglify')
const babel = require('gulp-babel')
const cleanCSS = require('gulp-clean-css')
const sass = require('gulp-sass')(require('sass'))
const htmlmin = require('gulp-htmlmin')
const connect = require('gulp-connect')
const del = require('del')

// 定义变量，保存各种资源的路径
const paths = {
  js: {
    src: 'src/js/**/*.js', // js 文件的源路径
    dest: 'dist/js' // js 处理后的目标路径
  },
  css: {
    src: 'src/css/**/*.css',
    dest: 'dist/css'
  },
  scss: {
    src: 'src/scss/**/*.scss',
    dest: 'dist/css'
  },
  html: {
    src: 'src/**/*.html',
    dest: 'dist'
  },
  libs: {
    src: 'src/libs/**/*.*',
    dest: 'dist/libs'
  }
}

// 定义任务函数：处理 JS 资源
function scripts() {
  return gulp.src(paths.js.src)
    .pipe(babel({
			presets: ['env']
		}))
    .pipe(uglify())
    .pipe(gulp.dest(paths.js.dest))
    .pipe(connect.reload())
}

// 处理 CSS
function styles() {
  return gulp.src(paths.css.src)
    .pipe(cleanCSS())
    .pipe(gulp.dest(paths.css.dest))
    .pipe(connect.reload())
}

// 编译 sass 文件
function buildScss() {
  return gulp.src(paths.scss.src)
    .pipe(sass())
    // .pipe(sass({outputStyle: 'compressed'}))
    .pipe(gulp.dest(paths.scss.dest))
    .pipe(connect.reload())
}

// html文件处理
function html() {
  return gulp.src(paths.html.src)
    .pipe(htmlmin({ collapseWhitespace: true, minifyCSS: true, minifyJS: true }))
    .pipe(gulp.dest(paths.html.dest))
    .pipe(connect.reload())
}

// 定义监视任务
function watch() {
  gulp.watch(paths.scss.src, buildScss)
  gulp.watch(paths.js.src, scripts)
  gulp.watch(paths.css.src, styles)
  gulp.watch(paths.html.src, html)
}

// 清理 dist 目录
function clean() {
  return del([ 'dist' ])
}

// 复制无需特殊处理的资源
function copyLibs() {
  return gulp.src(paths.libs.src)
    .pipe(gulp.dest(paths.libs.dest))
}

// 启动 webserver 服务器
function server() {
  connect.server({
    root: 'dist',
    port: 9527,
    livereload: true
  })
}

// 形成处理流程
const build = gulp.series(clean, gulp.parallel(styles, scripts, buildScss, html, copyLibs, watch, server))

// 导出任务
exports.scripts = scripts
exports.styles = styles
exports.buildScss = buildScss
exports.watch = watch
exports.html = html
exports.clean = clean
exports.build = build
exports.copyLibs = copyLibs
exports.server = server

// 默认任务
exports.default = build
```

- 提交本地版本库

```bash
$ git status
$ git add -A
$ git status
$ git commit -m 'flag: message'
```

- 推送到远程中央仓库

```bash
$ git push origin master
```

- 编码实现页面功能