有时候node_modules包特别大，目录层级太深，windows系统删除有时候还报没有管理员权限的错误。右键点击直接删除是删除不了的。
下面给大家介绍一种方法可以快速删除node_modules，让你彻底告别这个苦恼。。。



```undefined
npm install rimraf -g
rimraf node_modules
```

或者



```undefined
rmdir /s/q node_modules
```

删除文件



```python
del filename
```

清除node_modules缓存



```undefined
npm cache clean
```