# 服务器部署教程

---

**部署前准备**：已购买**阿里云ECS服务器**和**域名**  
注：没有域名也可以用服务器公网ip地址访问(服务器是必须有的)

## 部署部分

### 1、putty

- 1、下载**putty**和**tortoisgit**
- 2、安装**putty**和**tortoisgit**
- 3、为了方便使用建议把**putty**和**tortoisgit**目录下的**PuTTYgen**放到桌面
- 4、打开**putty**  
![img01](img/bs/微信截图_20210412232234.png)
- 5、打开**ip地址连接**  
![img02](img/bs/微信截图_20210412232750.png)
- 6、第一次打开ip连接会弹框，点击**是**，继续  
![img03](img/bs/微信截图_20210412232827.png)
- 7、登录**服务器**，登录默认的root用户  
![img04](img/bs/微信截图_20210412232943.png)
![img05](img/bs/微信截图_20210412233227.png)
![img06](img/bs/微信截图_20210412233415.png)

### 2、tmux

- 1、**安装tmux：**`yum install tmux -y`  
![img07](img/bs/微信截图_20210412234746.png)
![img08](img/bs/微信截图_20210412235001.png)
- 2、创建一个**session(会话)**：`tmux`  
![img09](img/bs/微信截图_20210412235132.png)
![img10](img/bs/微信截图_20210412235351.png)

> 其他操作：  
**恢复到上次启动的session：tmux a**  
**查看全部session：tmux ls**  
**删除指定session：tmux kill-session -t session(ID/名)**  
**横向分割窗口：Ctrl+b " 或 tmux split-window -h**(双引号要 用shift+引号键，'或'字后面是指令)  
**竖向分割窗口：Ctrl+b % 或 tmux split-window**(百分号要用shtift+5键，'或'字后面是指令)  
**移动到指定方向的窗口：Ctrl+b 方向键**  
**关闭当前窗口：Ctrl+d 或 exit**('或'字后面是指令)  

### 3、用户

---

- [**返回**](https://code.aliyun.com/kangxianghui/server/tree/master)