# cva6-mnist

在 RISC-V 开源 SoC cva6 上面增加一个贝叶斯推理模块，实现由硬件电路完成的快速 MNIST 数字识别。

## 软件部分

* `mnist-test-program` 文件夹包含了测试软件的代码，里面有编译脚本 `compile.sh`，可以参考该脚本将源代码编译到 RISC-V 架构的 ELF 可执行文件。
* 注意该测试程序使用了 mmap 等系统调用，需要自行安装使用 libgcc 库的 RISC-V 交叉编译器，如果 host 系统是 Ubuntu 或者 Debian，可以直接使用系统包管理器 apt 来安装。当前 cva6 项目自动安装的编译器使用的是 newlib 库，无法编译这个测试程序。

## 硬件部分

将本项目中贝叶斯模块的代码文件夹 `bayes` 拷贝到 cva6 项目的 `corev_apu/fpga/src` 目录下，并修改 cva6 项目的以下文件完成模块整合：

* `Makefile` 将贝叶斯模块的代码作为新的依赖添加进去
* `corev_apu/tb/ariane_soc_pkg.sv` 这个是配置文件，用于对总线进行配置，需要添加一个接口用于插上贝叶斯模块，并且分配好地址区间
* `corev_apu/fpga/src/ariane_peripherals_xilinx.sv` 这里面包含了 SoC 各个外设的实例化，在这里实例化贝叶斯模块，并且连接到总线对应的接口上
* `corev_apu/fpga/src/ariane_xilinx.sv` 这里面包含了总线的实例化，添加一个接口（对应贝叶斯模块）即可
* `corev_apu/tb/ariane_peripherals.sv` 这个是 SoC 的仿真测试代码，对应外设部分，修改方法和和 `ariane_peripherals_xilinx.sv` 一样
* `corev_apu/tb/ariane_testharness.sv` 这个是 SoC 的仿真测试代码，对应总线部分，修改方法和和 `ariane_xilinx.sv` 一样
* `corev_apu/fpga/src/bootrom/cv64a6.dts` 这个是设备树文件，使用 device-tree-compiler 后可以得到 bootrom 的数据（`corev_apu/fpga/src/bootrom/bootrom_64.sv`），但是由于测试程序是在用户态通过内存映射与硬件进行交互，不依赖于内核态驱动程序的加载，所以这个修改对于跑通测试并不是必要的

对于具体修改内容，可以参考本项目提供的 patch 文件。

## 测试方法

* 根据 cva6 项目官方文档搭建 SoC 构建环境，并安装 RISC-V 工具链。
* 参考本项目 README 完成贝叶斯模块在 cva6 SoC 上的集成，并综合成比特流文件。
* 将 cva6 项目提供的 Linux 内核镜像打包好，制作成可启动镜像，并烧写进 SD 卡。
* 在 SD 卡上创建一个存放测试相关文件的分区并格式化。
* 参考本项目 README 用安装好的交叉编译器 riscv-gcc 将测试程序编译成 RISC-V 指令集的 ELF 可执行文件，放到 SD 卡测试分区的文件系统内。
* 给开发板上电，启动 Linux 操作系统，挂载测试分区并运行测试程序。
