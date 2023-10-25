#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "machine.h"
#include "images.h"
#include "pixels.h"
#include "bayes.h"

INT32U right_class[100] = { 
	7,2,1,0,4,1,4,9,5,9,
	0,6,9,0,1,5,9,7,3,4,
	9,6,6,5,4,0,7,4,0,1,
	3,1,3,4,7,2,7,1,2,1,
	1,7,4,2,3,5,1,2,4,4,
	6,3,5,5,6,0,4,1,9,5,
	7,8,9,3,7,4,6,4,3,0,
	7,0,2,9,1,7,3,2,9,7,
	7,6,2,7,8,4,7,3,6,1,
	3,6,9,3,1,4,1,7,6,9,
};

INT32U result_class[100];

int main() {

  // 将贝叶斯分类器的物理地址映射到用户态程序可以直接访问的虚拟地址
  bayes_mapping_init();

  // 启动基于贝叶斯分类器的手写体数字的识别
  printf("Handwritten digits recognition based on Bayes Classifier is started!\n\n");

  INT32U right_num = 0;
  INT32U dig_num;
  INT32U feat_vec;

  printf("Classification result: \n\n");

  // 100个手写体数字逐个进行分类识别
  for (dig_num = 0; dig_num < 100; dig_num++) {

    bayes_setREG(BAYES_VECTOR, 0x00000000); // 清空特征向量寄存器 
    bayes_setREG(BAYES_START, 0x00000000); // 清空启动寄存器
    bayes_setREG(BAYES_START, 0x00000001); // 启动向分类器加载特征向量

    // 每个手写体数字由25个特征向量组成
    for (feat_vec = 0; feat_vec < 25; feat_vec++)
      bayes_setREG(BAYES_VECTOR, pixels[dig_num * 25 + feat_vec]);

    // 启动分类器进行手写体数字的分类识别
    bayes_setREG(BAYES_START, 0x00000002);

    while (1) {

      if (bayes_getREG(BAYES_END) == 1) { // 判断分类识别是否结束

        result_class[dig_num] = bayes_getREG(BAYES_CLASSRES); // 获取分类结果

        // 判断分类结果是否与正确结果一致
        if (result_class[dig_num] == right_class[dig_num])
          right_num++;

        break;
      }
    }

    // 打印手写体数字的分类识别结果
    INT32U row, col;
    row = dig_num / 10;
    col = dig_num % 10;
    printf("%d ", result_class[dig_num]);
    fflush(stdout);
    if (col == 9)
      printf("\n");
  }

  // 清空启动寄存器，停止分类器工作
  bayes_setREG(BAYES_START, 0x00000000);

  printf("\nClassification is complete!\n");
  printf("The classification accuracy is %d%%.\n", right_num);

  return 0;
}
