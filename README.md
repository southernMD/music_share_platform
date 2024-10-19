# 音乐分享平台
音乐分享平台是一个非常简单的由jsp构建的项目，它十分的简单，简单到没有任何服务器校验，并发控制，事务回滚等。仅仅只有简单jdbc操作与servlet，没有用到中高级的前端技术，甚至没有ajax，没有任何的前端框架。

## 项目结构
<!-- md层级结构图 -->
```
music_share_platform
├── music_share_platform.sql --- 数据库文件
├── README.md
├── src
|   └── comY
|   |   ├── dao ---数据库操作
|   |   ├── entity ---数据库实体
|   |   ├── filter ---过滤器
|   |   ├── model ---模型
|   |   ├── myInterface ---接口
|   |   ├── servlet ---servlet接口
|   |   ├── util    ---工具函数
|   |   └── Config.java ---配置文件
├── web 
|   ├── WEB-INF ---web-xml文件
|   ├── css ---css文件
|   ├── js  ---js文件
|   ├── public  ---静态文件
|   ├── template ---jsp模板文件
|   └── 其他jsp文件
```

## 如何使用
先在 Config.java修改数据库信息，正常打包成war，然后部署到tomcat即可。


