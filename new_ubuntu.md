# Linux系统 之 Ubuntu部署手册

> 本文档是基于有 Linux 基础的伙伴们提供的部署向导文档，没有基础的也不打紧，我在文章开头会教你们一些文档中需要用到的基础操作  
>
> Linux中讲的：目录，就是windows中常说的：文件夹  

## Linux 常规基础操作

ps：此处只做简要的说明，具体详情或内容还请查阅相关文档

### ls

1、`ls`：列出当前目录中的文件和子目录  
2、`ls -l`：以长格式显示文件和目录的详细信息，包括文件类型、权限、所有者、大小、修改时间等  
3、`ls -a`：显示所有文件和目录，包括隐藏文件和目录（以.开头的文件和目录）  
4、`ls -h`：以易读的方式，即带有单位（B、KB、MB等），显示文件和目录的大小  
5、`ls -t`：按最后修改时间排序，最近修改的文件或目录在前面  

### cd

ps："." 代表当前目录，".." 代表上级目录

1、`cd ~`：切换到当前用户的主目录  
2、`cd /`：切换到根目录  
3、`cd ..`：切换到上级目录（父目录）  
4、`cd /xxx/xxx`：切换到指定路径的任意目录  

ps：如果不记得完整目录，可以用 `cd ~/xxx/xxx` 来切换到指定路径的任意目录

### pwd

1、`pwd`：显示当前工作目录的路径

### mkdir

1、`mkdir 目录名`：在当前目录下创建目录  
2、`mkdir -p 父目录/子目录/二级子目录`：在当前目录下创建一个多级嵌套的目录  
3、`mkdir -m 777 目录名`：在当前目录下创建目录，并指定新目录的权限模式  

### rm

ps：注意，要确保指令和文件名输入正确后再执行，否则删除重要文件就很难找回

1、`rm 文件名`：删除当前目录下的文件  
2、`rm -r 目录名`：删除指定目录  
3、`rm -f 文件名/目录名`：避免确认提示，强制删除文件/目录  
4、`rm -i 文件名`：删除当前目录下的文件，并且删除前进行确认提示  

### vi

1、`vi 文件名`：打开文件（如果文件不存在，则会创建一个新文件）  
2、命令模式，文件打开后，你就进入了命令模式  

- `i`：进入插入模式，可以开始编辑文件内容（按下Esc可回到命令模式）
- `x`：删除当前光标所在位置的字符
- `dd`：删除当前行
- `:w`：保存文件
- `:q`：退出vi编辑器
- `:wq`：保存文件并退出编辑器
- `:q!`：放弃对文件的更改并强制退出编辑器

### sudo

1、`sudo 命令`：使用临时的超级用户权限执行命令（需要正确输入用户密码，也可配置用户使用sudo时不用输入密码）

## 更新安装源

```shell
apt-get update
```

## tmux - 终端复用程序

1、安装

```shell
apt-get install tmux -y
```

2、使用

- `tmux`：启动会话
- `tmux a`：恢复到上次启动的会话
- `tmux ls`：查看所有会话列表
- `tmux a -t 会话名/ID`：进入指定会话
- `tmux kill-session -t 会话名/ID`：删除指定会话

3、进入会话后的操作

- `Ctrl+b %`：在当前窗口中垂直划分出一个新窗格
- `Ctrl+b "`：在当前窗口中水平划分出一个新窗格
- `Ctrl+b 方向键`：在窗格之间进行导航
- `Ctrl+b c`：创建一个新窗口
- `Ctrl+b n`：切换到下一个窗口
- `Ctrl+b p`：切换到上一个窗口
- `Ctrl+b d`：从tmux会话中断开，保留会话状态并返回到普通终端
- `Ctrl+b o`：在窗格之间切换焦点
- `Ctrl+b x`：关闭当前窗格

## unzip - 解压缩 zip 压缩包

1、安装

```shell
apt-get install unzip -y
```

2、使用

- `unzip 压缩包文件名`：解压zip压缩包到当前目录
- `unzip -d /xxx/xxx/ 压缩包文件名`：解压zip压缩包到指定目录
- `unzip -c 压缩包文件名`：解压zip压缩包到当前目录，将解压缩的数据输出到标准输出，而不是将其解压缩到文件中
- `unzip -f 压缩包文件名`：解压zip压缩包到当前目录，覆盖已存在的文件而不进行任何提示
- `unzip -j 压缩包文件名`：解压zip压缩包到当前目录，不创建与压缩文件中的目录对应的目录结构，将所有文件都解压缩到同一目录下
- `unzip -l 压缩包文件名`：解压zip压缩包到当前目录，显示压缩文件的列表，但不进行解压缩操作
- `unzip -o 压缩包文件名`：解压zip压缩包到当前目录，不进行任何提示，覆盖已存在的文件
- `unzip -t 压缩包文件名`：解压zip压缩包到当前目录，测试压缩文件是否正确，但并不进行解压缩操作
- `unzip -u 压缩包文件名`：解压zip压缩包到当前目录，只解压缩出现在压缩文件中并新于指定日期的文件
- `unzip -v 压缩包文件名`：解压zip压缩包到当前目录，显示详细的解压缩过程

## 用户相关

- `adduser 用户名`：添加用户
- `ls -l /home/`：查看用户列表
- `su - 用户名`：切换用户
- `su -`：切换到root用户
- `exit`：退出用户
- `userdel -rf 用户名`：删除用户

## 配置密钥登录用户

1、使用 PuTTYgen，生成公钥、私钥并保存到本地

ps：私钥丢失就再也登不上服务器了，一定要保存好

2、编辑密钥文件

```shell
# 创建目录
mkdir ~/.ssh
# 设置权限
chmod 700 ~/.ssh
# 编辑密钥文件，用于存放公钥
vi ~/.ssh/authorized_keys
# 将生成的公钥文件中的内容粘贴至此
# 保存并退出
# 设置密钥文件权限
chmod 600 ~/.ssh/authorized_keys
```

ps：如果报错不支持ssh-rsa，则需要手动添加支持ssh-rsa类型的公钥

```shell
# 编辑sshd配置文件
vi /etc/ssh/sshd_config
# 在合适的位置添加一行内容
PubkeyAcceptedAlgorithms +ssh-rsa
# 保存并退出
# 重启sshd服务以生效
systemctl restart sshd.service
```

3、重新打开ssh客户端，测试使用密钥登录

ps：登录失败，表示之前步骤错误，重复上述步骤即可

4、关闭密码登录

```shell
# 编辑sshd配置文件
vi /etc/ssh/sshd_config
# 找到对应配置项，输入后回车，类似 Ctrl + F 功能
/PasswordAuthentication
# 将其值修改为：no
PasswordAuthentication no
# 保存并退出
# 重启sshd服务以生效
systemctl restart sshd.service
# 如果不生效，请把 PasswordAuthentication no 放到配置文件最上面一行
```

ps：拒绝使用密码一旦开启，密钥文件若丢失，就再也无法登录服务器了

## 防火墙

1、安装与启动

```shell
# 下载
apt install ufw -y
# 查看防火墙状态，inactive：关闭中、active：运行中
ufw status
# 如果处于关闭中，就启动防火墙
ufw enable
```

2、添加端口/协议

- `ufw allow 端口号（或协议名称）/tcp`：添加防火墙端口/协议

常用的例子：

- `ufw allow 80/tcp` 或 `ufw allow http`：添加 http 端口
- `ufw allow 443/tcp` 或 `ufw allow https`：添加 https 端口
- `ufw allow 22/tcp` 或 `ufw allow ssh`：添加 ssh 端口
- `ufw allow 3306/tcp`：添加 mysql 端口
- `ufw allow 6379/tcp`：添加 redis 端口
- `ufw allow 8080/tcp`：添加 tomcat 端口
- `ufw allow 8848/tcp`：添加 nacos 端口

3、查看防火墙规则编号

```shell
# 列出已添加的防火墙规则
ufw status numbered
```

其他操作：

- `ufw disable`：禁用防火墙
- `ufw delete 编号`：删除对应编号的规则
- `ufw delete allow 规则名称`：删除对应名称的规则

## nginx - 高性能的 Web 服务器和反向代理服务器

1、安装

```shell
apt install nginx -y
```

2、查看版本号

```shell
nginx -v
```

3、服务关闭与停止

ps：若采用的是指定配置文件启动的方式，则需执行此步骤

```shell
# 关闭nginx服务开机启动
systemctl disable nginx
# 停止nginx服务
systemctl stop nginx
```

其他操作：

- `systemctl enable nginx`：配置nginx服务开机启动
- `systemctl start nginx`：启动服务
- `/etc/nginx/nginx.conf` 和 `/etc/nginx/conf.d/*.conf`：为配置文件默认位置

## git - 分布式版本控制系统

1、安装

```shell
# 安装
apt install git -y
# 查看版本号
git --version
```

2、配置私钥

```shell
# 编辑私钥文件
vi ~/.ssh/id_rsa
# 将私钥 (id_rsa文件中的内容) 粘贴进去
# 保存并退出
# 配置私钥文件权限
chmod 600 ~/.ssh/id_rsa
```

ps：如果报错不支持ssh-rsa，则需要手动添加支持ssh-rsa类型的公钥

```shell
# 编辑sshd配置文件
vi /etc/ssh/sshd_config
# 在合适的位置添加一行内容
PubkeyAcceptedKeyTypes=+ssh-rsa
# 保存并退出
# 重启sshd服务以生效
systemctl restart sshd.service
```

3、项目管理与自动拉取

```shell
# 创建存放git项目的文件夹
mkdir git
# 进入git目录下
cd git
# 克隆项目到当前目录下
git clone 项目git ssh地址
# 使用tmux分割一个窗口来自动拉取项目
# 作用：本地提交后，服务器自动更新网站
# 建议：10分钟~30分钟
watch -n 执行间隔时间(单位：秒/s) git pull
```

其他操作：

基本指令

- `git clone 远程资源库地址`：下载远程资源库到本地
- `git add 文件名（支持通配符）`：添加跟踪文件
- `git commit -m "提交的说明信息"`：提交更改
- `git push`：推送到远程资源库
- `git pull`：拉取远程资源库更新文件
- `git status`：查看资源库状态

分支管理

- `git branch -a`：查看分支
- `git branch 分支名称`：创建并切换分支
- `git checkout 分支名称`：切换分支
- `git push origin 远程分支名:本地分支名`：提交到远程分支
- `git branch -D 分支名称`：删除分支
- `git push origin --delete 分支名称`：删除远程分支
- `git merge 分支名称`：合并分支（不能合并当前分支）
- `git push --set-upstream origin 分支名称`：切换当前远程推送资源库

冲突和更改撤销

- `git log`：查看提交日志信息
- `git reset --hard 通过 git log 查看的历史版本号`：回退版本
- `git push -f`：推送版本回退到远程分支

同步多个远程资源库

- `git remote add 远程资源库自定义名称 远程资源库地址`：添加新的远程资源库
- `git push`：提交主资源库
- `git push 远程资源库自定义名称`：提交远程资源库
- `git remote rm 远程资源库自定义名称`：删除远程资源库

配置信息

- `git config --list`：查看配置信息
- `git config --global user.name "用户名"`：设置用户名
- `git config --global user.email "用户邮箱"`：设置用户邮箱

## mysql - 关系型数据库管理系统

1、安装

```shell
# 安装
apt-get install mysql-server -y
# 检查MySQL服务是否成功启动
netstat -tap | grep mysql
# 或者
service mysql status
# 如果未启动，执行启动
service mysql start
```

2、本地连接MySQL

```shell
# 登录MySQL(无需密码)
mysql -uroot -p
# 如果提升没有安装客户端，执行安装
apt install mysql-client -y
```

ps：如果登录失败，安装时没有设置密码，按以下步骤操作

```shell
# 查看默认的用户名和密码
cat /etc/mysql/debian.cnf
# 使用查看到的账户登录
mysql -u 用户名 -p 密码
# 设置root用户的密码
use mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';
FLUSH PRIVILEGES;
```

3、远程连接MySQL

```shell
# 切换到mysql数据库
use mysql;
# 查看数据库用户列表
select user,host from user;
# 创建用户，用于远程连接MySQL
CREATE USER '用户名'@'%' IDENTIFIED BY '密码';
# 设置用户权限
GRANT ALL ON *.* TO '用户名'@'%' with grant option;
# 权限功能立即生效
FLUSH PRIVILEGES;
```

ps：如果远程连接失败，非密码错误原因，按以下步骤操作

```shell
# 可能是用户权限问题，修改用户权限
update user set host='%' where user='用户名';
# 如果上述操作不行，需要修改配置文件
# 打开配置文件
nano /etc/mysql/mysql.conf.d/mysqld.cnf
# 找到 bind - address 配置项
# 默认值：127.0.0.1
# 修改成：*（也可以是0.0.0.0，表示允许所有机器访问） 或者 远程连接的ip (推荐，更安全)
# 保存并退出
# 重启MySQL服务以生效
service mysql restart
```

其他操作：

```shell
# 彻底卸载MySQL
apt purge mysql-*
rm -rf /etc/mysql/ /var/lib/mysql
apt autoremove
apt autoclean
```

## JDK - Java开发工具包

1、查找可安装的JDK信息

```shell
# 查找可用的 openjdk 信息
apt-cache search openjdk
```

2、安装

```shell
# 安装 openjdk-8
apt install openjdk-8-jdk -y
# 查看JDK版本
java -version
```

其他操作：

- `apt-get remove openjdk*`：卸载JDK

## Tomcat - Java Servlet容器

1、安装

```shell
# 安装
curl -OL Tomcat的下载地址
# 解压
tar -zxvf Tomcat的压缩文件名
# 设置权限
chmod -R 777 Tomcat的目录名
```

2、配置后端服务热部署

```shell
# 修改Tomcat配置文件
cd Tomcat的目录名/conf/
vi server.xml
# 找到 appBase 配置项
# 默认值：webapps
# 改成：后端项目存放的目录（也就是war包存放的目录）
# 启动Tomcat
cd  Tomcat的目录名/bin/
./startup.sh
```

## Redis - 内存数据结构存储系统

1、安装

```shell
# 安装
apt install redis-server -y
```

2、修改配置

```shell
# 编辑配置文件
vi /etc/redis/redis.conf
# 修改查找关键词，将其值修改成你需要的
# 修改密码查找：requirepass
# 修改ip绑定查找：bind
# 修改端口查找：port
# 保存并退出
# 重启Redis服务以生效
service redis restart
```

## Node.js - JavaScript运行环境

1、安装

```shell
# 安装 nodejs 和 npm
apt-get install -y nodejs npm
# 查看nodejs版本
node -v
# 查看npm版本
npm -v
```

其他操作：

```shell
# 下载node版本管理工具
sudo npm install n -g
# 下载最新稳定版
sudo n stable
# 下载最新版
sudo n lastest
# 查看已下载的版本
sudo n ls
# 切换 Node 版本
sudo n 版本号
```

## Nacos - 动态服务发现、配置管理和服务管理平台

1、安装

```shell
# 安装
curl -OL Nacos的下载地址
# 解压
tar -zxvf Nacos的压缩文件名
```

2、配置

```shell
# 创建一个Nacos的数据库，命名为：nacos_config
# 运行 nacos-mysql.sql 脚本来初始化数据库
# 编辑Nacos配置文件
cd Nacos的目录名/conf/
vi application.properties
# 修改内容
# 保存并退出
# 防火墙添加Nacos的端口协议
```

3、启动

```shell
# 进入 bin 目录
cd Nacos的目录名/bin/
# 启动
# cluster：集群模式（默认）
# standalone：单机模式
bash startup.sh -m standalone
```
