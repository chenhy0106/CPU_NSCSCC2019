# nscscc2019 CPU

## 仓库内容

### /src
1. 此文件夹包含CPU源代码和所用IP核。如需综合成可下载的bit流，需要把源代码添加到比赛发布包中soc_up文件夹下的工程中。
2. 把CPU添加到soc上时，需要修改soc_up_top.v中的部分内容。\
    (1). 检查soc的中断输入和reset输入是高有效还是低有效\
    (2). 检查CPU输入输出端口名称和soc_up_top.v中的是否相符。未用到的debug输入输出端口可以删除。
3. 综合时如遇到乘法IP核错误（“CE端不存在”），需要打开乘法IP设置，勾选时钟使能。

### /pmon
1. 包含可以运行的pmon版本。官方给的.bin文件不一定能运行成功。
2. 网口未测试，暂且认为有bug不能用。

### /ucore
1. 包含可以运行的ucore版本。
2. 成功启动后，用户态程序有三个，分别是sh、ls和cat。
3. 发布包中有包含更多用户态程序的ucore版本，未测试。

## 启动ucore步骤
（请使用此仓库中的pmon（/pmon/gzrom.bin）和ucore（/ucore/ucore-kernel-initrd），用其他版本我也不知道能不能运行成功（摊手））
### 1. 下载pmon
参考\FPGA_test_v1.00\FPGA_soc_test\pmon运行并load内核启动的方法_v1.00.pdf中（1）、（2）、（3）步下载pmon。

### 2. 下载bit流
下载综合实现好的cpu+soc的比特流。

### 3. 下载ucore：
1. 如果网口可用，参考\FPGA_test_v1.00\FPGA_soc_test\pmon运行并load内核启动的方法_v1.00.pdf中（4）、（5）步下载ucore，此方法速度较快。
2. 如果网口不可用：\
    a. 在pmon命令行中输入ymodem。\
    b. 通过串口软件发送ucore-kernel-initrd（SecureCRTPortable软件中点击transfer->send ymodem），速度较慢\
    c. 发送完毕后，在pmon命令行中输入load /dev/ram/ymodem
    d. 成功启动ucore

