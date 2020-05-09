如下：

1
workdir=$(cd $(dirname $0); pwd)
步骤1

dirname $0，取得当前执行的脚本文件的父目录

步骤2

cd到父目录，即进入当前工作目录

步骤3

pwd显示当前工作目录