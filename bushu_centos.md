# 服务器部署教程-CentOS篇

---

- [**返回**](https://github.com/karl1901/server/blob/master/README.MD)  

**部署前准备：** 已购买**云服务器**和**域名**，本地电脑安装了**Git**  
注：没有域名也可以用服务器公网ip地址访问(服务器是必须有的)，有域名了的就用自己的域名，并去域名管理控制台**申请SSL证书**  

## 部署目录

> [1、putty](#putty)  
> [2、tmux](#tmux)  
> [3、用户](#用户)  
> [4、putty-配置无密码登录](#putty-配置无密码登录)  
> [5、防火墙](#防火墙)  
> [6、nginx](#nginx)  
> [7、阿里云创建项目](#阿里云创建项目)  
> [8、git](#git)  
> [--- git其他指令](#git其他指令)  
> [9、mysql](#mysql)  
> [10、jdk](#jdk)  
> [11、tomcat](#tomcat)  
> [12、部署Vue项目](#部署vue项目)  

### putty

> [顶部](#部署目录)  

- 1、下载**putty** (本项目提供了putty安装包)
- 2、安装**putty**
- 3、为了方便使用建议把**putty**和**putty**目录下的**PuTTYgen**放到桌面
- 4、打开**putty**  
![img01](img/bs_centos/微信截图_20210412232234.png)
- 5、打开**ip地址连接**  
![img02](img/bs_centos/微信截图_20210412232750.png)
- 6、第一次打开ip连接会弹框，点击**是**，继续  
![img03](img/bs_centos/微信截图_20210412232827.png)
- 7、登录**服务器**，登录默认的root用户  
![img04](img/bs_centos/微信截图_20210412232943.png)
![img05](img/bs_centos/微信截图_20210412233227.png)
![img06](img/bs_centos/微信截图_20210412233415.png)

### tmux

> [顶部](#部署目录)  

- 1、**安装tmux：**`yum install tmux -y`  
![img07](img/bs_centos/微信截图_20210412234746.png)
![img08](img/bs_centos/微信截图_20210412235001.png)
- 2、创建一个**session(会话)**：`tmux`  
![img09](img/bs_centos/微信截图_20210412235132.png)
![img10](img/bs_centos/微信截图_20210412235351.png)

> tmux的其他操作：  
**恢复到上次启动的session：tmux a**  
**查看全部session：tmux ls**  
**删除指定session：tmux kill-session -t session (ID/名)**  
**横向分割窗口：Ctrl+b " 或 tmux split-window -h** (双引号要 用shift+引号键，'或'字后面是指令)  
**竖向分割窗口：Ctrl+b % 或 tmux split-window** (百分号要用shtift+5键，'或'字后面是指令)  
**移动到指定方向的窗口：Ctrl+b 方向键**  
**关闭当前窗口：Ctrl+d 或 exit** ('或'字后面是指令)  

### 用户

> [顶部](#部署目录)  

- 1、**添加**用户：`adduser username`，名字自定义，然后**修改**用户密码：`passwd username`  
![img31](img/bs_centos/微信截图_20210413092537.png)
- 2、**修改sudo权限：`visudo`，添加内容：`username ALL=(ALL) ALL`**  
![img30](img/bs_centos/微信截图_20210413092201.png)

> 用户的其他操作：  
**查看用户列表：ls -l /home/**  
**切换用户：su - username**  
**切换root用户：su -**  
**退出用户：exit**  
**删除用户：userdel -rf username**  

### putty 配置无密码登录

> [顶部](#部署目录)  

- 8、打开**PuTTYgen**，生成**公钥**和**私钥**保存到本地 (建议：**git的密钥**和服务器登录的**公钥**和**私钥**都丢在服务器项目目录下的**key**文件中**以防丢失**，没有文件就创建一个)  
![img11](img/bs_centos/微信截图_20210413080314.png)
![img12](img/bs_centos/微信截图_20210413080608.png)
- 这里的文件名可以自定义，只要自己能分清是公钥还是私钥就行  
![img13](img/bs_centos/微信截图_20210413080820.png)  
![img14](img/bs_centos/微信截图_20210413080942.png)  
![img15](img/bs_centos/微信截图_20210413081029.png)  
![img16](img/bs_centos/微信截图_20210413081243.png)  
![img17](img/bs_centos/微信截图_20210413081443.png)
- 9、打开**putty**，**登录**用户  
  - **创建目录：`mkdir ~/.ssh`**  
  - **设置权限：`chmod 700 ~/.ssh`**  
  - **编辑密钥文件：`vi ~/.ssh/authorized_keys`**  
![img18](img/bs_centos/微信截图_20210413082109.png)
- 10、编辑**密钥文件**，粘贴**公钥**，**保存并退出**  
![img19](img/bs_centos/微信截图_20210413082447.png)
![img20](img/bs_centos/微信截图_20210413082728.png)
- 11、设置**密钥文件权限**  
  - **设置权限：`chmod 600 ~/.ssh/authorized_keys`**  
![img21](img/bs_centos/微信截图_20210413082926.png)
- 12、打开**putty**，**加载**服务器  
![img22](img/bs_centos/微信截图_20210413083151.png)
- 13、用户名建议输入默认的**root**，自定义的用户名是后面自己创建的 (注意：这里的名字必须是服务器上有的用户名)  
![img23](img/bs_centos/微信截图_20210413083329.png)
![img24](img/bs_centos/微信截图_20210413083607.png)
![img25](img/bs_centos/微信截图_20210413083744.png)
![img26](img/bs_centos/微信截图_20210413084035.png)
- 14、点击已保存的**ip**,然后点击**Save**，再点击**Open**  
![img27](img/bs_centos/微信截图_20210413084217.png)
![img28](img/bs_centos/微信截图_20210413084446.png)
- 15、输入指令：  
  - **执行`vi /etc/ssh/sshd_config`配置ssh**
  - **输入`/PasswordAuthentication`回车找到对应配置项**
  - **修改为`PasswordAuthentication no`拒绝使用密码登陆**
  - **执行`systemctl restart sshd.service`重启ssh服务生效**  
![img29](img/bs_centos/微信截图_20210413084724.png)
- **注：新建的用户也有执行相同的操作：9-11的步骤**
- **！！！拒绝使用密码一旦开启，密钥文件若丢失，就再也无法登录服务器了(但是登录后可以改回密码登录权限) ！！！**

### 防火墙

> [顶部](#部署目录)  

- 1、**开启**防火墙、**重启**防火墙、添加**80/443/3306 (http/https/mysql)端口**和**http服务**，**重启**防火墙，**查看**是否添加成功
  - **开启防火墙：`systemctl enable firewalld.service`**
  - **重启防火墙：`systemctl restart firewalld.service`**
  - **查看防火墙信息：`firewall-cmd --list-all`**
  - **添加端口(80)：`firewall-cmd --permanent --zone=public --add-port=80/tcp`**
  - **添加服务(http)：`firewall-cmd --zone=public --add-service=http`**
![img32](img/bs_centos/微信截图_20210413101717.png)
- **注：两边的用户都要做一遍，新建的用户要输入管理员密码**

> 防火墙其他操作：  
**查看防火墙状态：systemctl status firewalld.service**  
**删除端口(80)：firewall-cmd --permanent --zone=public --remove-port=80/tcp**  
**删除服务(http)：firewall-cmd --permanent --zone=public --remove-service=http**  

### nginx

> [顶部](#部署目录)  

- 1、**执行`vi /etc/yum.repos.d/nginx.repo`编辑nginx下载源，内容如下：**  

``` txt
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
```

![img33](img/bs_centos/微信截图_20210413110244.png)

- 2、**执行`yum install nginx -y`安装nginx**  
  - **执行`nginx -v`查看安装是否成功(会显示版本号)**  
![img34](img/bs_centos/微信截图_20210413110438.png)
- 3、**关闭**和**停用**服务
  - **关闭nginx服务开机启动指令：`systemctl disable nginx`**
  - **停止服务指令：`systemctl stop nginx`**  
![img35](img/bs_centos/微信截图_20210413110623.png)

> nginx其他操作：  
**配置nginx服务开机启动指令：systemctl enable nginx**  
**启动服务指令：systemctl start nginx**  
**配置文件默认位置：/etc/nginx/nginx.conf 和 /etc/nginx/conf.d/*.conf**  

### 阿里云创建项目

> [顶部](#部署目录)  

- 1、进入[code.aliyun.com](https://code.aliyun.com/)，**创建**一个private服务器项目  
![img36](img/bs_centos/微信截图_20210413112537.png)
- 2、**克隆**到本地  
![img37](img/bs_centos/微信截图_20210413112651.png)
- 3、**新建**三个文件：  
- (把git密钥和公钥，登录服务器的公钥和私钥放到项目的key文件夹下)  
- (建议：跟服务器有关的都提交到git，本项目提供了nginx文件，还有下载的SSL证书也需要放在nginx文件夹下)  
![img38](img/bs_centos/微信截图_20210413112847.png)
- 4、**编辑**server.nginx.conf配置文件 (另一个mime.types文件是固定的，不动)  
![img39](img/bs_centos/微信截图_20210413113502.png)
  - 有域名的nginx配置文件代码：(需要把**域名**改为自己的域名，git项目名称改为自己的项目名称)  

```txt
#sudo nginx -t -c /home/karl/git/demo-server/nginx/server.nginx.conf
#sudo nginx -c /home/karl/git/git项目文件名称/nginx/server.nginx.conf
#sudo nginx -s stop -c /home/karl/git/git项目文件名称/nginx/server.nginx.conf
#sudo nginx -s reload
user root;
worker_processes 1;
events {
  worker_connections 1024;
}
http {
  include mime.types;
  default_type application/octet-stream;
  sendfile on;
  keepalive_timeout 65;
  gzip on;
  #域名配置
  server {
    listen 80;
    server_name 域名;
    server_name www.域名;
    charset utf-8;
    rewrite ^(.*)$ https://${server_name}$1 permanent;
  }
  #kangxianghui.top的ssl配置
  server {
    listen 443 ssl;
    server_name 域名;
    ssl_certificate 域名.pem;
    ssl_certificate_key 域名.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    charset utf-8;
    # 域名首页
    location / {
      root /home/karl/git/git项目文件名称/webroot;
      index index.html;
      expires -1;
    }
  }

  #域名的8000端口配置
  server {
    listen 8000;
    server_name 域名;
    server_name www.域名;
    charset utf-8;
    location / {
      root /home/karl/git/git项目文件名称/webroot;
      index index.html;
      expires -1;
    }
  }
}
```

- 5、**新建**主页(index.html)，添加一点内容  
![img40](img/bs_centos/微信截图_20210413113724.png)
- 6、**推送并提交**项目  
![img41](img/bs_centos/微信截图_20210413113906.png)

### git

> [顶部](#部署目录)  

- 1、**下载**git，**查看版本**检查是否安装成功  
  - **执行`yum install git -y`安装git**  
  - **执行`git --version`查看git版本，测试git是否安装成功**  
![img42](img/bs_centos/微信截图_20210413115657.png)
- 2、配置**私有key**： (两个用户都要配置--root和新建的) 
  - **执行`vi ~/.ssh/id_rsa`编辑私钥文件，将私钥复制进去**  
  - **执行`chmod 600 ~/.ssh/id_rsa`配置权限**  
![img49](img/bs_centos/微信截图_20210413124228.png)  
![img43](img/bs_centos/微信截图_20210413115901.png)  
![img44](img/bs_centos/微信截图_20210413120033.png)
- 3、在新创建的用户目录下**创建git文件**，**进入git文件**，**克隆项test项目到git文件下**，**查看**是否有**test文件**了  
  - **创建git文件：`mkdir git`**  
  - **进入git文件：`cd git`**  
![img45](img/bs_centos/微信截图_20210413121154.png)
- 4、打开**test中的nginx的配置文件**,**复制前两条指令**  
  - nginx的VsCode插件  
  - ![img49](img/bs_centos/微信截图_20210429142504.png)  
  - **查看：`sudo nginx -t -c /home/karl/git/test/nginx/server.nginx.conf`**  
  - **启动：`sudo nginx -c /home/karl/git/test/nginx/server.nginx.conf`**  
  - **关闭：`sudo nginx -s stop -c /home/karl/git/test/nginx/server.nginx.conf`**  
  - **重置：`sudo nginx -s reload`**  
![img46](img/bs_centos/微信截图_20210413121355.png)
- 5、进入**test**文件中，**执行**复制的两行指令 (查看和启动)，启动时需输入用户密码
![img47](img/bs_centos/微信截图_20210413121748.png)
- 6、打开浏览器访问**域名**或**地址**  
![img48](img/bs_centos/微信截图_20210413122054.png)

- 注：每次在本地编辑上传项目文件后都要到git/test文件下拉取一次页面才会显示最新的样子，这样很麻烦！所以建议在tmux中再开一个新建用户的窗口，进入git/test文件中，执行指令：**`watch -n 600 git pull`** (单位：秒)，意思是：每隔十分钟拉取一次，且这个窗口不能关闭，关闭只后就不会自动拉取了！(关闭窗口：Ctrl+c)

## git其他指令  

> [顶部](#部署目录)

> [基本指令](#基本指令)  
> [分支管理](#分支管理)  
> [冲突和更改撤销](#冲突和更改撤销)  
> [同步多个远程资源库](#同步多个远程资源库)  
> [配置信息](#配置信息)  

### 基本指令

> [git其他指令](#git其他指令)  

- **下载远程资源库到本地：`git clone 远程资源库地址`，例如：`git clone git@code.aliyun.com:DarkKnight/document.git`**
- **添加跟踪文件：`git add 文件名（支持通配符）`，例如：`git add *`**
- **提交更改：`git commit -m "提交的说明信息`"，例如：`git commit -m "添加了项目说明"`**
- **推送到远程资源库：`git push`**
- **拉取远程资源库更新文件：`git pull`**
- **查看资源库状态：`git status`**

### 分支管理

> [git其他指令](#git其他指令)  

- **查看分支：`git branch -a`**
- **创建并切换分支：`git branch 分支名称`，例如：`git branch test`**
- **切换分支：`git checkout 分支名称`，例如：`git checkout test`**
- **提交到远程分支：`git push origin 远程分支名:本地分支名`，例如：`git push origin test:test`**
- **删除分支：`git branch -D 分支名称`，例如：`git branch -D test`**
- **删除远程分支：`git push origin --delete 分支名称`，例如：`git push origin --delete test`**
- **合并分支：`git merge 分支名称`，分支名称不能是当前分支**
- **切换当前远程推送资源库：`git push --set-upstream origin 分支名称`**

### 冲突和更改撤销

> [git其他指令](#git其他指令)  

- **查看提交日志信息：`git log`**
- **版本回退**
  - **回退版本：`git reset --hard 通过git log查看的历史版本号`**
  - **推送版本回退到远程分支：`git push -f`**
- **冲突解决**
  - **拉取版本更新：`git pull后`修改冲突**
  - **执行正常的提交和推送**

### 同步多个远程资源库

> [git其他指令](#git其他指令)  

- **在aliyun和github上同时创建同名的项目**
- **添加新的远程资源库：`git remote add github git@github.com:huhuiyu/github-aliyun-test.git`**
- **本地提交完毕后**
  - **执行`git push`提交主资源库**
  - **执行`git push github`提交github资源库**
  - **主资源库提交不同分支需要执行`git push github origin 分支名`，其它资源库不变**
- **可以执行`git remote rm github`来删除github资源库**

### 配置信息

> [git其他指令](#git其他指令)  

- **查看配置信息：`git config --list`**
- **设置用户名：`git config --global user.name "用户名"`**
- **设置用户邮箱：`git config --global user.email "用户邮箱"`**

### mysql

> [顶部](#部署目录)  

- **CentOs 8及以上版本**  

- 下载：`wget https://repo.mysql.com//mysql80-community-release-el8-1.noarch.rpm`  
- 安装源：`yum install mysql80-community-release-el8-1.noarch.rpm -y`  
- 查看安装配置文件：`vi /etc/yum.repos.d/mysql-community.repo`  
- 禁用mysql5：`dnf config-manager --disable mysql57-community` 或 `yum-config-manager --disable mysql57-community`  
- 启用mysql8：`dnf config-manager --enable mysql80-community` 或 `yum-config-manager --enable mysql80-community`  
- 关闭默认mysql：`yum module disable mysql -y`  
- 安装mysql： `yum install mysql-community-server -y`  
- 启用mysql服务：`systemctl enable mysqld`  
- 启动mysql服务：`systemctl start mysqld`  
- 查看mysql的默认root密码：`grep 'temporary password' /var/log/mysqld.log`  
- 启动命令行：`mysql -uroot -p`  
- 修改root默认密码，否则不能执行其它管理命令：`ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';`  
- 添加用户：`CREATE USER '用户名'@'%' IDENTIFIED BY '密码';`  
- 用户密码`IDENTIFIED WITH mysql_native_password`可以不使用加密密码  
- 用户授权：`GRANT ALL ON *.* TO '用户名'@'%' with grant option;`  
- 权限功能立即生效：`FLUSH PRIVILEGES;`  

- **CentOs 7及以上版本**  

- 备份本地yum源：`mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak`  
- 获取阿里yum源配置文件：`wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo`  
  - (不是强制步骤，可选择不更新)
  - 更新cache：`yum makecache`  
  - 安装：`yum -y update`  
- 查看是否已安装MySQL：`rpm -qa|grep mysql`  
- 若存在则卸载掉：`rpm -e --nodeps mysql-libs`  
- 使用wget命令下载到本地：`sudo wget https://repo.mysql.com//mysql80-community-release-el7-1.noarch.rpm`  
- 安装：  
  - 1、：`sudo rpm -ivh mysql80-community-release-el7-1.noarch.rpm`  
  - 2、：`sudo yum install mysql-server`(过程中有提示就输入`y`按回车执行即可)  
- 检查是否安装成功：`mysqladmin -V`  
- 开启MySQL：`sudo service mysqld start`  
- 查看状态：`sudo service mysqld status`  
- 查看默认密码：`sudo cat /var/log/mysqld.log`  
- 登录：`mysql -uroot -p`
- 修改root用户默认密码：`ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';`  
- 添加用户：`CREATE USER '用户名'@'%' IDENTIFIED BY '密码';`  
- 用户授权：`GRANT ALL ON *.* TO '用户名'@'%' with grant option;`  
- 权限功能立即生效：`FLUSH PRIVILEGES;`  

### jdk

> [顶部](#部署目录)  

- 执行`yum search java|grep jdk`查找可用的`jdk`版本  
- 执行`yum install java-1.8.0-openjdk-devel.x86_64 -y`安装`openjdk1.8`  
- 执行`javac -version`测试jdk是否安装成功  

### tomcat

> [顶部](#部署目录)  

- 执行`wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz`下载  
- 执行`tar -zxvf apache-tomcat-8.5.66.tar.gz`解压  

**部署java项目：**

- 1、git目录下**新建**javaee文件夹(名字自定义)  
- 2、**导出**java项目到javaee文件夹下(war包)  
- 3、nginx配置文件**添加反代**到tomcat的配置：  

```txt
    location /javaweb/ {
      proxy_redirect off;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_pass http://127.0.0.1:8080/;
    }
```

- 4、**提交推送**项目到git服务器  
- 5、服务器**拉取**项目并执行nginx的**重置**指令  
- 6、进入tomcat的bin目录下执行`./startup.sh`**启动**tomcat  
  - 停止tomcat：`./shutdown.sh`  
  - 执行完毕后，就能通过域名/javaweb/访问到tomcat主页
- 7、进入tomcat的conf目录下，**编辑**server.xml文件(`vi server.xml`)  
- 8、把appBase=""中的内容**修改**为git项目文件下的javaee文件夹：  

```txt
<Host name="localhost"  appBase="/home/karl/git/test-server/javaee"                  │Fast-forward
            unpackWARs="true" autoDeploy="true">
```

配置修改完后,以后只用提交推送java项目的war包，然后拉取到服务器，tomcat会自动把javaee文件夹下的war包解压  
用`域名/javaweb/java项目名/`就能访问到项目了，一但上面的server.xml修改后，通过域名/javaweb/就不能访问到tomcat主页了，只能访问项目了，其是为了安全性。  

### 部署vue项目

> [顶部](#部署目录)

- 1、配置nginx的`server.nginx.conf`文件，新增一个`location`  

> /myvue/：服务器端虚拟路径  
> /home/karl/git/test-server/myvue/：虚拟路径指向的目录  

``` txt

location /myvue/ {
  alias /home/karl/git/test-server/myvue/;
  index index.html;
 expires -1;
  }

```

- 2、配置`vue.config.js`文件，内容如下：  
  - 本项目已提供`vue配置文件`  

``` txt

module.exports = {
  // 生成环境不需要map文件
  productionSourceMap: !process.env.NODE_ENV === 'production',
  // 项目输出路径(build后项目保存的路径)
  outputDir: 'D:\\myvue\\test',
  // 服务器虚拟路径(判断是否是本地启动还是服务器启动)
  publicPath: process.env.NODE_ENV === 'production' ? '/myvue/' : '/'
};

```

- 3、用VsCode打开本地项目：**`Ctrl+~`**→**`npm run build`**(若要执行这一步，上面的两步要配置完)，执行完毕后本地的项目会自动打包到**项目输出路径**(本地目录的aliyun.code文件夹中的myvue文件夹下)，然后**本地提交推送**到Git服务器。  

- 4、打开Putty，进入新建用户的git项目文件夹下，执行**拉取的指令**，因nginx的配置文件有变化，所以要执行**重置**的指令方才生效，最后在浏览器输入**服务器ip或域名**/myvue/，就能进入到部署的vue项目的主页

> [顶部](#部署目录)  

---

- [**返回**](https://github.com/karl1901/server/blob/master/README.MD)  
