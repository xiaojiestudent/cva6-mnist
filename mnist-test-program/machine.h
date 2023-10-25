typedef unsigned  char              BOOLEAN;
typedef unsigned  char              INT8U;        
typedef signed    char              INT8S;        
typedef unsigned  short             INT16U;       
typedef signed    short             INT16S;       
typedef unsigned  int               INT32U;       
typedef signed    int               INT32S;
typedef unsigned  long long int	    INT64U;	    

typedef unsigned char  u8;
typedef unsigned short u16;
typedef unsigned int   u32;

#define REG8(add) *((volatile INT8U *)(add))
#define REG16(add) *((volatile INT16U *)(add))
#define REG32(add) *((volatile INT32U *)(add))
#define REG64(add) *((volatile INT64U *)(add))

// 贝叶斯分类器基地址和偏移地址
#define BAYES_BASE			0x50000000
#define BAYES_START   		0x00000000
#define BAYES_CLASSRES   	0x00000008
#define BAYES_VECTOR	   	0x00000010
#define BAYES_END   		0x00000018


#define DELAY_CNT 3000000

// 延迟函数
void delay(INT64U cnt) {
	INT32U i = 0;
	while(i < cnt) {
		i ++;
	}
}
