void *mapped_base;
int mem_fd;

// 将贝叶斯分类器的物理地址映射到用户态程序可以直接访问的虚拟地址
void bayes_mapping_init() {
    // 打开 /dev/mem 文件
    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd == -1) {
        perror("Error opening /dev/mem");
        exit(EXIT_FAILURE);
    }

    // 映射物理内存
    mapped_base = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, BAYES_BASE);
    if (mapped_base == (void *)-1) {
        perror("Error mapping physical memory");
        close(mem_fd);
        exit(EXIT_FAILURE);
    }
}

// 设置贝叶斯分类器中的接口寄存器
void bayes_setREG(INT32U offset, INT32U val) {
    REG32(mapped_base + offset) = val;
}

// 读取贝叶斯分类器中的接口寄存器
INT32U bayes_getREG(INT32U offset) {
    return REG32(mapped_base + offset);
}

