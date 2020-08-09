## 修改自用版
https://github.com/gdtool/gd-utils-docker 
小改自用版，使用caddy反代，自动申请LET ssl。
------------------------------------------------------------
## 使用方法:
示例：提前解析abc.com到你的服务器ip，搭建后访问

1）https://abc.com  gd-utils地址

2）https://abc.com/shell   shellinabox地址

账号gd，密码自设 USERPWD=123qwe   ||
su root切换到root 密码自设 USERPWD=123qwe

3）https://abc.com/file   filebrowser 账号密码admin

-------------------------------
1.下载配置文件，按要求修改里面的参数
```
wget https://raw.githubusercontent.com/gdtool/gd-utils-docker/master/config.example.js -O config.js
```
2上传sa文件到sa文件夹

3.运行
```
docker run --restart=always  -it -e USERPWD=123qwe  -p 443:443  -p 80:80   -e Domain=abc.com -v ${PWD}/sa:/gd-utils/sa  -v ${PWD}/config.js:/gd-utils/config.js   --name gd-utils jialezi/gd-utils
```
USERPWD为shellinabox密码   ||  Domain=abc.com 为自己域名，要提前解析，由caddy自动申请ssl

4.对接telegram bot
```
curl -F "url=[YOUR_WEBSITE]/api/gdurl/tgbot" 'https://api.telegram.org/bot[YOUR_BOT_TOKEN]/setWebhook'
```
例如：curl -F "url=https://abc.com/api/gdurl/tgbot" 'https://api.telegram.org/bot1394xxx380:AAGDPL_2-LPIA0iQ6RuGuwMxxxxxxxGE/setWebhook'
返回true ok

------------------------------------------

## 构建docker镜像方法:
下载修改
```
git clone https://github.com/jialezi/gd-utils-docker
cd gd-utils-docker
```

构建docker镜像方法
```
docker build -f Dockerfile . -t gd-utils
```

使用
```
docker run --restart=always  -it -e USERPWD=123qwe  -p 443:443  -p 80:80   -e Domain=abc.com -v ${PWD}/sa:/gd-utils/sa  -v ${PWD}/config.js:/gd-utils/config.js   --name gd-utils gd-utils
```


# [gd-utils](https://github.com/iwestlin/gd-utils)的Docker版,快速搭建google drive 转存工具

**docker内包含:**
- **网页版shell**:方便执行git pull等命令
- **文件管理器**,方便上传sa文件以及编辑配置文件和备份数据库
- **gd-utils机器人**
> 具体gd-utils教程请移步官网: [gd-utils](https://github.com/iwestlin/gd-utils)




~~# 使用方法:
gd-utils的Docker版,使用方法:


**4200端口:** webshell,账号:`gd`,密码:`your_self_passsword`

**23333端口:** gd-utils机器人

**80端口:** 文件管理,**默认不启动**  **默认不启动**   **默认不启动**
> 启动方法:登录webshell;`su root` 然后执行`cd / && filebrowser &`,账号密码:admin

**持久化目录:** /gd-utils/

```
docker run --restart=always  -d \
-e USERPWD="your_self_passsword" \
-p 4200:4200 \
-p 80:80 \
-p 23333:23333 \
--name gd-utils \
-v /gd-utils:/gd-utils \
gdtool/gd-utils-docker
```~~

## 原项目
[gd-utils](https://github.com/iwestlin/gd-utils)

## 相关项目(感谢这些开源项目)

[gd-utils](https://github.com/iwestlin/gd-utils)

[shellinabox](https://github.com/shellinabox/shellinabox)

[filebrowser](https://github.com/filebrowser/filebrowser/)

## 脚本参考

[iouAkira](https://github.com/iouAkira/someDockerfile)

[mics8128](https://github.com/mics8128/gd-utilds-docker)
