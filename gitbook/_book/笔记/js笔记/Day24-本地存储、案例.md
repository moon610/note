# Review

**跨域**

CORS  -- [XMLHttpRequest Level2](https://www.ruanyifeng.com/blog/2012/09/xmlhttprequest_level_2.html)

JSONP 

**Promise**

三种状态：

创建对象

API

**Cookie**

document.cookie = 'key=value; expires=失效时间; path=路径; domain=域; secure'

document.cookie

# 编码、解码

- encodeURIComponent('美女')
- decodeURIComponent('%E7%BE%8E%E5%A5%B3')

# Cookie 封装

# WebStorage

- localStorage
- sessionStorage

特征：

- 是 H5 中新增的存储结构

- 存储的是文本数据
- 是真正的本地存储（不会占用网络上传带宽）
- 存储容量为 5MB
- localStorage 是本地永久存储、sessionStorage 是本地会话存储
- 受同域限制
- 有完善的 API

## API

- setItem(name, value): 保存
- getItem(name): 查询
- removeItem(name): 删除
- clear(): 清空

# Bootstrap

[bootstrap](https://v3.bootcss.com/)