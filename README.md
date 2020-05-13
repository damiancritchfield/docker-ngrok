# docker-ngrok

## 1.服务端运行

```
docker run -d -p 18081:18081 -p 18082:18082 -p 18083:18083 -p 2222:2222 -p 2223:2223 registry-vpc.cn-shenzhen.aliyuncs.com/liaolangsheng/ngrok:v1.0.0 server
```

## 2.客户端运行

获取客户端文件
```
docker cp 8342aab77fb8:/root/ngrok/bin/ngrok ~/ngrok-client
docker cp 8342aab77fb8:/root/ngrok/bin/ngrok.cfg ~/ngrok-client
docker cp 8342aab77fb8:/root/ngrok/bin/start_ngrok_client.sh ~/ngrok-client
```

如下：

1
workdir=$(cd $(dirname $0); pwd)
步骤1

dirname $0，取得当前执行的脚本文件的父目录

步骤2

cd到父目录，即进入当前工作目录

步骤3

pwd显示当前工作目录