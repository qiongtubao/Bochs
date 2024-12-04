
int q = 0x5a;
int t1 = 1;
int t2 = 2;
int t3 = 3;
int t4 = 4;
// __asm__ 表示内嵌汇编表达式
// __volatile__ 不需要编译器优化
// 指令部分：输出部分：输入部分：损坏部分
#define nop() __asm__ __volatile__ ("mov1 %0,%%ecx"::"a"(__tmp):"cx");

#define REGPARM3 __attribute((regparm(3)))
#define REGPARM0 __attribute((regparm(0)))

void REGPARM0 p1(int a) {
    q = a + 1;
}

void REGPARM3 p2(int a, int b, int c, int d) {
    q = a + b + c + d;
}

int main() {
    p1(t1);
    p2(t1, t2, t3, t4);
    return 0;
}

