完整项目地址：[vue-element-admin](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2FPanJiaChen%2Fvue-element-admin "https://github.com/PanJiaChen/vue-element-admin")

系列文章：

- [手摸手，带你用 vue 撸后台 系列一（基础篇）](https://juejin.cn/post/6844903476661583880)
- [手摸手，带你用 vue 撸后台 系列二(登录权限篇)](https://juejin.cn/post/6844903478880370701)
- [手摸手，带你用 vue 撸后台 系列三 (实战篇)](https://juejin.cn/post/6844903481224986638)
- [手摸手，带你用 vue 撸后台 系列四(vueAdmin 一个极简的后台基础模板)](https://juejin.cn/post/6844903486241374221)
- [手摸手，带你用 vue 撸后台 系列五(v4.0 新版本)](https://juejin.cn/post/6844903840626507784)
- [手摸手，带你封装一个 vue component](https://link.juejin.cn/?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000009090836 "https://segmentfault.com/a/1190000009090836")
- [手摸手，带你优雅的使用 icon](https://juejin.cn/post/6844903517564436493)
- [手摸手，带你用合理的姿势使用 webpack4（上）](https://juejin.cn/post/6844903652956569608)
- [手摸手，带你用合理的姿势使用 webpack4（下）](https://juejin.cn/post/6844903652956585992)

## 前言

说好的教程终于来了，第一篇文章主要来说一说在开始写实际业务代码之前的一些准备工作吧，但这里不会教你 webpack 的基础配置，热更新原理是什么，webpack速度优化等等，有需求的请自行 google，相关文章已经很多了。

## 目录结构

```
├── build                      // 构建相关  
├── config                     // 配置相关
├── src                        // 源代码
│   ├── api                    // 所有请求
│   ├── assets                 // 主题 字体等静态资源
│   ├── components             // 全局公用组件
│   ├── directive              // 全局指令
│   ├── filtres                // 全局 filter
│   ├── icons                  // 项目所有 svg icons
│   ├── lang                   // 国际化 language
│   ├── mock                   // 项目mock 模拟数据
│   ├── router                 // 路由
│   ├── store                  // 全局 store管理
│   ├── styles                 // 全局样式
│   ├── utils                  // 全局公用方法
│   ├── vendor                 // 公用vendor
│   ├── views                   // view
│   ├── App.vue                // 入口页面
│   ├── main.js                // 入口 加载组件 初始化等
│   └── permission.js          // 权限管理
├── static                     // 第三方不打包资源
│   └── Tinymce                // 富文本
├── .babelrc                   // babel-loader 配置
├── eslintrc.js                // eslint 配置项
├── .gitignore                 // git 忽略项
├── favicon.ico                // favicon图标
├── index.html                 // html模板
└── package.json               // package.json
复制代码
```

这里来简单讲一下src文件

### api 和 views

简单截取一下公司后台项目，现在后台大概有四五十个 api 模块

![](https://gitee.com/herrry/image-repository/raw/master/img/202203141612848.webp)

如图可见模块有很多，而且随着业务的迭代，模块还会会越来越多。 所以这里建议根据业务模块来划分 views，并且 将views 和 api 两个模块一一对应，从而方便维护。如下图：

<img width="572" height="322" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612849.webp"/>

如 article 模块下放的都是文章相关的 api，这样不管项目怎么累加，api和views的维护还是清晰的，当然也有一些全区公用的api模块，如七牛upload，remoteSearch等等，这些单独放置就行。

### components

这里的 components 放置的都是全局公用的一些组件，如上传组件，富文本等等。一些页面级的组件建议还是放在各自views文件下，方便管理。如图：

![](https://gitee.com/herrry/image-repository/raw/master/img/202203141612850.webp)

### store

这里我个人建议不要为了用 vuex 而用 vuex。就拿我司的后台项目来说，它虽然比较庞大，几十个业务模块，几十种权限，但业务之间的耦合度是很低的，文章模块和评论模块几乎是俩个独立的东西，所以根本没有必要使用 vuex 来存储data，每个页面里存放自己的 data 就行。当然有些数据还是需要用 vuex 来统一管理的，如登录token,用户信息，或者是一些全局个人偏好设置等，还是用vuex管理更加的方便，具体当然还是要结合自己的业务场景的。总之还是那句话，不要为了用vuex而用vuex！

* * *

## webpack

> 这里是用 [vue-cli](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-cli "https://github.com/vuejs/vue-cli") 的 [webpack-template](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs-templates%2Fwebpack "https://github.com/vuejs-templates/webpack") 为基础模板构建的，如果你对这个有什么疑惑请自行google，相关的配置绍其它的文章已经介详细了，这里就不再展开了。简单说一些需要注意到地方。

### jquery (本项目已移除)

管理后台不同于前台项目，会经常用到一些第三方插件，但有些插件是不得不依赖 jquery 的，如市面很多富文本基都是依赖 jquery 的，所以干脆就直接引入到项目中省事(gzip之后只有34kb，而且常年from cache,不要考虑那些吹毛求疵的大小问题，这几kb和提高的开发效率根本不能比)。但是如果第三方库的代码中出现![.xxx或jQuery.xxx或window.jQuery或window.](https://gitee.com/herrry/image-repository/raw/master/img/202203141612851.svg)则会直接报错。要达到类似的效果，则需要使用 webpack 内置的 `ProvidePlugin` 插件，配置很简单，只需要

```
new webpack.ProvidePlugin({
  $: 'jquery' ,
  'jQuery': 'jquery'
})
复制代码
```

这样当 webpack 碰到 require 的第三方库中出现全局的$、jQeury和window.jQuery 时，就会使用 node_module 下 jquery 包 export 出来的东西了。

### alias

当项目逐渐变大之后，文件与文件直接的引用关系会很复杂，这时候就需要使用[alias](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.js.org%2Fconfiguration%2Fresolve%2F "https://webpack.js.org/configuration/resolve/") 了。 有的人喜欢alias 指向src目录下，再使用相对路径找文件

```
resolve: {
  alias: {
    '~': resolve(__dirname, 'src')
  }
}

//使用
import stickTop from '~/components/stickTop'
复制代码
```

或者也可以

```
alias: {
  'src': path.resolve(__dirname, '../src'),
  'components': path.resolve(__dirname, '../src/components'),
  'api': path.resolve(__dirname, '../src/api'),
  'utils': path.resolve(__dirname, '../src/utils'),
  'store': path.resolve(__dirname, '../src/store'),
  'router': path.resolve(__dirname, '../src/router')
}

//使用
import stickTop from 'components/stickTop'
import getArticle from 'api/article'
复制代码
```

没有好与坏对与错，纯看个人喜好和团队规范。

* * *

## ESLint

不管是多人合作还是个人项目，代码规范是很重要的。这样做不仅可以很大程度地避免基本语法错误，也保证了代码的可读性。这所谓工欲善其事，必先利其器，个人推荐 eslint+vscode 来写 vue，绝对有种飞一般的感觉。效果如图：

<img width="572" height="340" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612852.webp"/>

每次保存，vscode就能标红不符合eslint规则的地方，同时还会做一些简单的自我修正。安装步骤如下：

首先安装eslint插件

<img width="572" height="292" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612853.webp"/>

安装并配置完成 ESLint 后，我们继续回到 VSCode 进行扩展设置，依次点击 文件 > 首选项 > 设置 打开 VSCode 配置文件,添加如下配置

```
 "files.autoSave":"off",
    "eslint.validate": [
       "javascript",
       "javascriptreact",
       "html",
       { "language": "vue", "autoFix": true }
     ],
     "eslint.options": {
        "plugins": ["html"]
     }

复制代码
```

这样每次保存的时候就可以根据根目录下.eslintrc.js你配置的eslint规则来检查和做一些简单的fix。这里提供了一份我平时的eslint规则[地址](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2FPanJiaChen%2Fvue-element-admin%2Fblob%2Fmaster%2F.eslintrc.js "https://github.com/PanJiaChen/vue-element-admin/blob/master/.eslintrc.js")，都简单写上了注释。每个人和团队都有自己的代码规范，统一就好了，去打造一份属于自己的eslint 规则上传到npm吧，如饿了么团队的 [config](https://link.juejin.cn/?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Feslint-config-elemefe "https://www.npmjs.com/package/eslint-config-elemefe")，vue的 [config](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Feslint-config-vue "https://github.com/vuejs/eslint-config-vue")。

[vscode 插件和配置推荐](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2FvarHarrie%2FDawn-Blossoms%2Fissues%2F10 "https://github.com/varHarrie/Dawn-Blossoms/issues/10")

* * *

## 封装 axios

我们经常遇到一些线上 的bug，但测试环境很难模拟。其实可以通过简单的配置就可以在本地调试线上环境。 这里结合业务封装了axios ，[线上代码](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2FPanJiaChen%2Fvue-element-admin%2Fblob%2Fmaster%2Fsrc%2Futils%2Frequest.js "https://github.com/PanJiaChen/vue-element-admin/blob/master/src/utils/request.js")

```
import axios from 'axios'
import { Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'

// 创建axios实例
const service = axios.create({
  baseURL: process.env.BASE_API, // api的base_url
  timeout: 5000 // 请求超时时间
})

// request拦截器
service.interceptors.request.use(config => {
  // Do something before request is sent
  if (store.getters.token) {
    config.headers['X-Token'] = getToken() // 让每个请求携带token--['X-Token']为自定义key 请根据实际情况自行修改
  }
  return config
}, error => {
  // Do something with request error
  console.log(error) // for debug
  Promise.reject(error)
})

// respone拦截器
service.interceptors.response.use(
  response => response,
  /**
  * 下面的注释为通过response自定义code来标示请求状态，当code返回如下情况为权限有问题，登出并返回到登录页
  * 如通过xmlhttprequest 状态码标识 逻辑可写在下面error中
  */
  //  const res = response.data;
  //     if (res.code !== 20000) {
  //       Message({
  //         message: res.message,
  //         type: 'error',
  //         duration: 5 * 1000
  //       });
  //       // 50008:非法的token; 50012:其他客户端登录了;  50014:Token 过期了;
  //       if (res.code === 50008 || res.code === 50012 || res.code === 50014) {
  //         MessageBox.confirm('你已被登出，可以取消继续留在该页面，或者重新登录', '确定登出', {
  //           confirmButtonText: '重新登录',
  //           cancelButtonText: '取消',
  //           type: 'warning'
  //         }).then(() => {
  //           store.dispatch('FedLogOut').then(() => {
  //             location.reload();// 为了重新实例化vue-router对象 避免bug
  //           });
  //         })
  //       }
  //       return Promise.reject('error');
  //     } else {
  //       return response.data;
  //     }
  error => {
    console.log('err' + error)// for debug
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  })

export default service

复制代码
```

```
import request from '@/utils/request'

//使用
export function getInfo(params) {
  return request({
    url: '/user/info',
    method: 'get',
    params
  });
}
复制代码
```

比如后台项目，每一个请求都是要带 token 来验证权限的，这样封装以下的话我们就不用每个请求都手动来塞 token，或者来做一些统一的异常处理，一劳永逸。 而且因为我们的 api 是根据 `env` 环境变量动态切换的，如果以后线上出现了bug，我们只需配置一下 `@/config/dev.env.js` 再重启一下服务，就能在本地模拟线上的环境了。

```
module.exports = {
    NODE_ENV: '"development"',
    BASE_API: '"https://api-dev"', //修改为'"https://api-prod"'就行了
    APP_ORIGIN: '"https://wallstreetcn.com"' //为公司打个广告 pc站为vue+ssr
}

复制代码
```

**妈妈再也不用担心我调试线上bug了。** 当然这里只是简单举了个例子，axios还可以执行多个并发请求，拦截器什么的，大家自行去研究吧。

* * *

## 多环境

vue-cli 默认只提供了`dev`和`prod`两种环境。但其实正真的开发流程可能还会多一个`sit`或者`stage`环境，就是所谓的测试环境和预发布环境。所以我们就要简单的修改一下代码。其实很简单就是设置不同的环境变量

```
"build:prod": "NODE_ENV=production node build/build.js",
"build:sit": "NODE_ENV=sit node build/build.js",
复制代码
```

之后在代码里自行判断，想干就干啥

```
var env = process.env.NODE_ENV === 'production' ? config.build.prodEnv : config.build.sitEnv
复制代码
```

新版的 vue-cli 也内置了 `webpack-bundle-analyzer` 一个模块分析的东西，相当的好用。使用方法也很简单，和之前一样封装一个 npm script 就可以。

```
//package.json
 "build:sit-preview": "cross-env NODE_ENV=production env_config=sit npm_config_preview=true  npm_config_report=true node build/build.js"

//之后通过process.env.npm_config_report来判断是否来启用webpack-bundle-analyzer

var BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
webpackConfig.plugins.push(new BundleAnalyzerPlugin())
复制代码
```

效果图

<img width="572" height="275" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612854.webp"/>

webpack-bundle-analyzer这个插件还是很有用的，对后期的代码优化什么的，最重要的是它够**装逼**~

* * *

## 前后端交互

每个公司都有自己一套的开发流程，没有绝对的好与坏。这里我来讲讲我司的前后端交互流程。

### 跨域问题

首先前后端交互不可避免的就会遇到跨域问题，我司现在全是用 `cors`来解决的，如果你司后端嫌麻烦不肯配置的话，dev环境也可以通过 `webpack-dev-server`的`proxy`来解决，开发环境用`nginx`反代理一下就好了，具体配置这里就不展开了。

### 前后端的交互问题

其实大家也知道，平时的开发中交流成本占据了我们很大一部分时间，但前后端如果有一个好的协作方式的话能解决很多时间。我司开发流程都是前后端和产品一起开会讨论项目，之后后端根据需求，首先定义数据格式和api，然后 mock api 生成好文档，我们前端才是对接接口的。这里推荐一个文档生成器 [swagger](https://link.juejin.cn/?target=http%3A%2F%2Fswagger.io%2F "http://swagger.io/")。 **swagger**是一个REST APIs文档生成工具，可以在许多不同的平台上从代码注释中自动生成，开源，支持大部分语言，社区好，总之就是一个强大，如下图的api 文档(swagger自动生成，ui忽略)

<img width="572" height="318" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612855.webp"/>

api 地址，需要传是没参数，需要的传参类型，返回的数据格式什么都一清二楚了。

### 前端自行mock

如果后端不肯来帮你 mock 数据的话，前端自己来 mock 也是很简单的。你可以使用mock server 或者使用 [mockjs](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fbadoo%2FMockJS "https://github.com/badoo/MockJS") \+ [rap](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fthx%2FRAP "https://github.com/thx/RAP") 也是很方便的。 不久前出的 [easy-mock](https://link.juejin.cn/?target=https%3A%2F%2Feasy-mock.com%2F "https://easy-mock.com/")也相当的不错，还能结合 swagger。 我们大前端终于不用再看后端的脸色了~

### iconfont

element-ui 默认的icon不是很多，这里要安利一波阿里的[iconfont](https://link.juejin.cn/?target=http%3A%2F%2Ficonfont.cn%2F "http://iconfont.cn/")简直是神器，不管是公司项目还是个人项目都在使用。它提供了png,ai,svg三种格式，同时使用也支持unicode，font-class，symbol三种方式。由于是管理后台对兼容性要求不高，楼主平时都喜欢用symbol，晒一波我司后台的图标(都是楼主自己发挥的)。

![iconfont.png](https://gitee.com/herrry/image-repository/raw/master/img/202203141612856.webp)

详细具体的使用可以见文章 [手摸手，带你优雅的使用 icon](https://juejin.cn/post/6844903517564436493)

* * *

## router-view

different router the same component vue。真实的业务场景中，这种情况很多。比如

<img width="572" height="47" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612857.webp"/>

我创建和编辑的页面使用的是同一个component,默认情况下当这两个页面切换时并不会触发vue的created或者mounted钩子，官方说你可以通过watch $route的变化来做处理，但其实说真的还是蛮麻烦的。后来发现其实可以简单的在 router-view上加上一个唯一的key，来保证路由切换时都会重新渲染触发钩子了。这样简单的多了。

```
<router-view :key="key"></router-view>

computed: {
    key() {
        return this.$route.name !== undefined? this.$route.name + +new Date(): this.$route + +new Date()
    }
 }
复制代码
```

* * *

## 优化

有些人会觉得现在构建是不是有点慢，我司现在技术栈是容器服务，后台项目会把dist文件夹里的东西都会打包成一个docker镜像，基本步骤为

```
npm install
npm run build:prod
加打包镜像，一共是耗时如下
复制代码
```

<img width="572" height="37" src="https://gitee.com/herrry/image-repository/raw/master/img/202203141612858.webp"/>

还是属于能接受时间的范围。 主站PC站基于nodejs、Vue实现服务端渲染，所以不仅需要依赖nodejs，而且需要利用pm2进行nodejs生命周期的管理。为了加速线上镜像构建的速度，我们利用taobao源 [registry.npm.taobao.org](https://link.juejin.cn/?target=https%3A%2F%2Fregistry.npm.taobao.org "https://registry.npm.taobao.org") 进行加速, 并且将一些常见的npm依赖打入了基础镜像，避免每次都需要重新下载。 这里注意下 建议不要使用cnpm install或者update 它的包都是一个link，反正会有各种诡异的bug，这里建议这样使用

```
npm install --registry=https://registry.npm.taobao.org
复制代码
```

如果你觉得慢还是有可优化的空间如使用`webpack dll` 或者把那些第三方vendor单独打包 external出去，或者我司现在用的是http2 可以使用`AggressiveSplittingPlugin`等等，这里有需求的可以自行优化。

* * *

## 占坑

常规占坑，这里是手摸手，带你用vue撸后台系列。 完整项目地址：[vue-element-admin](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2FPanJiaChen%2Fvue-element-admin "https://github.com/PanJiaChen/vue-element-admin")

- [手摸手，带你用 vue 撸后台 系列一（基础篇）](https://juejin.cn/post/6844903476661583880)
  
- [手摸手，带你用 vue 撸后台 系列二(登录权限篇)](https://juejin.cn/post/6844903478880370701)
  
- [手摸手，带你用 vue 撸后台 系列三 (实战篇)](https://juejin.cn/post/6844903481224986638)
  
- [手摸手，带你用 vue 撸后台 系列四(vueAdmin 一个极简的后台基础模板)](https://juejin.cn/post/6844903486241374221)
  
- [手摸手，带你用 vue 撸后台 系列五(v4.0 新版本)](https://juejin.cn/post/6844903840626507784)
  
- [手摸手，带你封装一个 vue component](https://link.juejin.cn/?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000009090836 "https://segmentfault.com/a/1190000009090836")
  
- [手摸手，带你优雅的使用 icon](https://juejin.cn/post/6844903517564436493)
  
- [手摸手，带你用合理的姿势使用 webpack4（上）](https://juejin.cn/post/6844903652956569608)
  
- [手摸手，带你用合理的姿势使用 webpack4（下）](https://juejin.cn/post/6844903652956585992)