---
title: 'CS253FZ-2021-Exam'
date: 2022-07-08 01:06:23
tags: [Compilation]
categories: [Exam]
published: true
hideInList: false
feature: 
isTop: false
---

CS253FZ-2021-Exam
<!--more-->


# QUESTION 1

Parts (a) to (d) refers to the assembly listing shown below.

![image-20220703092424567](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207030924980.png)

1. Give the names of the items shown in the boxes
   - A: Mechine Code
   - B: Directives 
   - C: Label 
   - D: Operator
   - E: Comment

2. What is the main difference between assembler directives and assembly language instructions? 汇编器指令和汇编语言指令之间的主要区别是什么？

   Assembler instruction generates machine code, thus contributes towards the size of the program. Assembler directive does not create any machine code, thus does not contribute to program size. It directs the assembler to perform certain actions during assembly phase. 汇编指令会产生机器码，因此对程序的大小有贡献。汇编器指令不产生任何机器码，因此对程序的大小没有贡献。它指示汇编器在汇编阶段执行某些动作。

3. Only certain characters will be displayed when keys are pressed. What are these characters? 按键时，只有某些字符会被显示出来。这些字符是什么？

   041h 到 7Ah 除了'Q'

4. The hexadecimal values in locations 21h and 2Bh have been replaced with XX and YY. Write out these values.

5. When ‘Q’ is typed to terminate the program, explain if it will be echoed on the screen before the program returns control to the operating system. 当输入'Q'来终止程序时，解释一下在程序将控制权返回给操作系统之前，是否会在屏幕上有响应。

   不会 直接跳到done

6. Both the bipolar junction transistor (BJT) and the junction field effect transistor (JFET) allow current flow to be controlled by a signal. Briefly explain the difference in operation between these two devices.

   ![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207031623421.png)

7. Briefly explain the differences between the operation of a complex instruction set computer (CISC) and a reduced instruction set computer(RISC), and give one advantage of each.

   CISC or RISC? Better Performance Approach 1 (CISC) make the machine instructions more like the HLL so that fewer are required to execute the program (Compiler Simplification). CISC Smaller faster programs, many compilers use a subset of the instructions.
   Approach 2 (RISC) optimise the performance of the most frequently used instructions. Replace memory references with register references. Instruction pipe lines should allow branching to be supported.
   RISC makes use of Switch-able register sets (very local cache).
   Register optimisation, stores most used variables in registers.

   - CISC use more complex instruction set. One instruction can do more things. 
     - The compiler can Simply and the program is smaller
   - RISC optimise the performance of the most frequently used instructions.
     - RISC store those most frequently used instructions into registers.

8. Both microcontrollers and FPGAs can be used during the design process for a system. Explain briefly why FPGAs are microcontrollers when prototyping mass consumer microwave ovens and washing machines. 微控制器和 FPGA 都可以在系统设计过程中使用。在为大众消费微波炉和洗衣机进行原型设计时，简要解释为什么 FPGA 是微控制器。

   > ![1](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207040007079.png)
   > 在这里，moodle 上

   When prototyping a product, such as a microwave oven or a washing machine, engineers can write software for a microcontroller to control the functions of the system, or choose an FPGA and write a hardware description language (HDL) program to control the system.
   For mass consumer products, it is cheaper to prototype using FPGA as the HDL program can be used to set up the mask to build an application specific integrated circuit (ASIC) chip which will be very cheap to produce. 在对微波炉或洗衣机等产品进行原型设计时，工程师可以为微控制器编写软件来控制系统的功能，或者选择 FPGA 并编写硬件描述语言 (HDL) 程序来控制系统。
   对于大众消费产品，使用 FPGA 进行原型制作成本更低，因为 HDL 程序可用于设置掩膜来构建专用集成电路 (ASIC) 芯片，该芯片的生产成本非常低廉。



# Question 2

The block of code shown below uses Pythagoras theorem to calculate the distance in two dimensions of a point (x, y), with values stored as short reals in SX and SY, from the origin (0, 0), and put it in short real format at the location pointed by SD.

![image-20220703092802716](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207030928759.png)

1. With SX and SY given values of 4.0 and 3.0, the answer generated in short real format is 40A0 0000 in hex. Show that the result is correct.

   40A0 0000

   BIN= >> 0100 0000 1010 0000 0000 0000 0000 0000

   第一个0表示正数 后面八位1000 0001是指数位 指数位转为十进制129-127就是指数位2

   之后尾数位为010 0000 0000 0000 0000 0000

   结果为 1.01 * 2^2 =101=5 而 $\sqrt{4^2+3^2} = 5^2$ 与答案相符

2. It can be shown that Pythagoras Theorem holds in three dimensions:
   $$
   x^2 + y^2 + z^2 = d^2
   $$
   Write a few lines of codes in the space pointed out by <<HERE<< to find the distance of a point (x, y, z) from the origin. You can assume that SX, SY and SZ have been properly initialized.

   ```assembly
   FLD SZ	;Push SZ onto FP stack将SZ推入栈
   
   FMUL ST,ST(0);Multiply ST*ST将刚刚推入的栈顶元素乘以自身
   
   FADD ST,ST(1);ADD top two numbers on stack将之前得到的x^2+y^2结果与z^2相加
   ```

   

3. If SX, SY and SZ have been given the values 8.0, 9.0 and 12.0 respectively, determine the output stored in the location SD after running the code. Give your answer in hex format. 

   17 =》10001 =》 1.0001 * 2^4

   =》符号位 正数0 指数位 127+4=131 =》1000 0011 尾数为 0001 0000……

   0100 0001 1000 1000 0000 0000 0000 0000

   =》4188 0000 in hex



# Question 3

Examine the block of code below which will display the binary contents of the register BX.

![image-20220703092938671](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207030929700.png)

1. The decimal number 2,345 is stored in register BX as binary coded decimal (BCD). Write out the binary contents of BX. 

   0000100100101001

2. Write a block of x86 assembly code which will display the BCD contents of BX.

3. Convert 2,345 from decimal to hexadecimal. If this number is stored in BX, show the binary contents of BX.

4. Write a block of x86 assembly code which will display the contents of BX in hexadecimal. For example, if BX contains 3ACh, the code should display 03AC.



写代码块，直接放了



# Question 4

The block of code below is used to create a delay. The number of machine cycles required to complete each of the instruction is given in the comments. For the loops, one number shows number of cycles needed for doing the loop, the other
shows the number needed to get out of the loop.

![image-20220703093036634](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207030930660.png)

1. How many machine cycles are needed to complete the execution of the code?

   $$((3+2+16)\times50000-(16-4)+4+17)\times500-(17-5)=525004488$$

2. It was found that the code takes 25 seconds to run in the DOSbox emulator. What is the average speed of the emulated clock in DOSbox? 发现该代码在DOSbox仿真器中运行需要25秒。在DOSbox中模拟的时钟的平均速度是多少？
   $$
   525004488/25 = 21000179.52
   $$

3. Should a similar block of code be run on a modern CPU, it is very likely that the time taken to run it will not match the required time calculated. This is due to modern CPUs using different techniques to speed up the average processing time of instructions. Give three examples of these techniques, and briefly explain each.

   1. 使串行代码在多核上运行的一种非常方便的方法是利用 OpenMP，将工作负载分配到多个 CPU 内核
   2. OpenACC 是一种使用硬件加速器的非常简单的方法，将工作负载分配给加速器
   3. ParallelwareAnalyzer 可以帮助进行矢量化。例如，它提供了有关如何重构代码以启用自动矢量化 (例如 PWR020) 或如何提高矢量化性能 (例如 PWR019) 的提示。



# Question 5

1. 
   - List the 3 types of interrupts, and briefly explain why they are used.
   - Explain briefly the actions the CPU will take when attending to an interrupt,
2. Give two advantages and two disadvantages of dynamic RAM over static RAM.
3. A hard-disk drive (HDD) contains 16,383 cylinders and 16 heads. Each track has 63 sectors, with each sector holding 512 bytes. What is the total capacity of this HDD?
4. Give two advantages and two disadvantages of solid state drive (SSD) compared to HDD.

## Q5-Answer

1. 

   1. **List the 3 types of interrupts, and briefly explain why they are used.**

      > Lecture-9&10

      - Hardware Interrupts

        An external signal applied to the INTR (interrupt) pin or NMI (interrupt) pin of the processor causes an interrupt. 施加到处理器的 INTR（中断）引脚或 NMI（中断）引脚的外部信号会导致中断。

      - Exception Interrupts

        Triggered by internal errors such as divide by zero, normally to print an error message. 由内部错误触发，例如除以零，通常打印错误消息。

      - Software Interrupts

        Caused by the execution of an assembly language INT command. Simply a call to a function in BIOS. 由执行汇编语言 INT 命令引起。只需调用 BIOS 中的函数。

   2. **Explain briefly the actions the CPU will take when attending to an interrupt,**

      > Lecture-9&10

      Hardware requests service routine by bringing IRQx low. The 8259A signals to CPU via INTR line. The CPU responds with Interrupt Acknowledge signal (INTA).
      The Acknowledge signal causes the 8259A to place the interrupt number (0-255) on the data bus. CPU reads the data.
      CPU hardware related registers onto the stack, including current CS:IP,SP and Flags.
      CPU multiplies Interrupt No.(Type) by 4 and looks up the jump address in the vector table. CS and IP are changed. Execution of the interrupt service routine continues until IRET. IRET registers to be restored to their former values.
      CS and IP are restored and the main program continues.

      

2. **Give two advantages and two disadvantages of dynamic RAM over static RAM.**

   > Lecture-11

   - Much higher densities possible (larger memory) 可能的密度更高（更大的内存）
   - Lower Cost 更低的开销
   - But requires extra refresh control signal. 但需要额外的刷新控制信号。
   - Typically 60nS, no dissipation when not accessed. 通常为 60nS，未访问时无耗散。(比静态 RAM 更慢)

   > ![image-20220704000514669](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207040005721.png)

3. **A hard-disk drive (HDD) contains 16,383 cylinders and 16 heads. Each track has 63 sectors, with each sector holding 512 bytes. What is the total capacity of this HDD?**

   > Lecture-13

   $$
   total\ capacity = 512\ Byte\ block \times Cylinders\ 16383\times 16\ Heads\times 63\ sectors=8\ GByte
   $$

   > 1 GByte = 1024\*1024\*1024  1Byte = 8bit

4. **Give two advantages and two disadvantages of solid state drive (SSD) compared to HDD**

   > ![1](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207040007079.png)
   > 在这里，moodle 上

   - SSDs offer advantages in performance 高性能

   - potentially reduced operational costs compared to disk-based storage devices. 运营成本低

     

   - cost more, and are generally used only on more expensive PCs. 对个人来说，更贵

   - need to build the hardware system internally, 对公司来说，需要建立硬件系统

