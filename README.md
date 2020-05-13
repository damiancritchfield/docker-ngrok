# docker-ngrok

## 1.构建镜像

```
git clone https://github.com/damiancritchfield/docker-ngrok.git
cd docker-ngrok
docker build -t registry-vpc.cn-shenzhen.aliyuncs.com/liaolangsheng/ngrok:v1.0.1 . 
docker push registry-vpc.cn-shenzhen.aliyuncs.com/liaolangsheng/ngrok:v1.0.1
```

注意：docker build默认并不保证能重构证书。

## 2.服务端运行

```
docker run -d -p 18081:18081 -p 18082:18082 -p 18083:18083 -p 2222:2222 -p 2223:2223 registry-vpc.cn-shenzhen.aliyuncs.com/liaolangsheng/ngrok:v1.0.1 server
```

## 3.客户端运行

获取客户端文件
```
docker cp 706749517e29:/root/ngrok/bin/ngrok ~/ngrok-client && \
docker cp 706749517e29:/root/ngrok/bin/ngrok.cfg ~/ngrok-client && \
docker cp 706749517e29:/root/ngrok/bin/start_ngrok_client.sh ~/ngrok-client
```

## 4.shell脚本获取当前目录

```
workdir=$(cd $(dirname $0); pwd)
```

步骤1

dirname $0，取得当前执行的脚本文件的父目录

步骤2

cd到父目录，即进入当前工作目录

步骤3

pwd显示当前工作目录