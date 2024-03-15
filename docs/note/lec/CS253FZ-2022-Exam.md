---
title: 'CS253FZ-2022-Exam'
date: 2022-08-30 01:06:20
tags: [Compilation]
categories: [Exam]
published: true
hideInList: false
feature: 
isTop: false
---

# Question 1

Parts (a) to (e) refers to the assembly listing shown below.

![image-20220830191438351](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202208301914446.png)

1. Match the following: assembler directives, labels, machine instructions, operators, and operands to the items in the boxes. 

   > - A: Directives
   > - B: opcode
   > - C: Michine Code
   > - D: label
   > - E: operand

2. What is the main difference between mnemonics and opcodes?

   > mnemonics is the commend like mov, add ..., it cann't be understanded by computer, the nutural is the opcode.
   >
   > **OPCODE**: It is a number interpreted by your machine(virtual or silicon) that represents the operation to perform
   >
   > **MNEMONIC**: English word MNEMONIC means "A device such as a pattern of letters, ideas, or associations that assists in remembering something.". So, its usually used by assembly language programmers to remember the "OPERATIONS" a machine can do, like "ADD" and "MUL" and "MOV" etc. This is assembler specific.
   >
   > [Difference between: Opcode, byte code, mnemonics, machine code and assembly - Stack Overflow](https://stackoverflow.com/questions/17638888/difference-between-opcode-byte-code-mnemonics-machine-code-and-assembly)

3. If the following keys are typed when the programme is running: 
   `abc123PQR@#$pqr`
   show what will appear on the screen. 

   > 读程序分析
   >
   > 所以答案应该是 `ABCPQ`

4. The hexadecimal values in locations 21h and 32h have been replaced with XX and YY. Write out these values.

   

5. Suppose the CS contains 12EFh. What is the starting address in main memory of the instruction `cmp dl,‘Q’`?

   ![image-20220830210055753](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202208302100788.png)

   这边直接加上偏移地址，starting address = 12EF + 002E = 131D

6. Explain the main difference between an edge-triggered and a level-triggered D flip-flop.

   

7.  

   1. Give three differences between static and dynamic memory.

      > ![image-20220830210435401](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202208302104439.png)

   2. How does caching help to speed up execution of programmes?

      > reduce IO time

8.  

   1. What is the difference between ROM and PROM?
   2. What is the difference between PROM and EPROM?
   3. What is the difference between EPROM and EEPROM?

   > [ROM、PROM、EPROM、EEPROM、Flash ROM分别指什么?](https://blog.csdn.net/woshizzai/article/details/80109617)
   >
   > **ROM**指的是“只读存储器”，即Read-Only Memory， 一次性制造，其中的代码与数据将永久保存(除非坏掉)，不能进行修改。
   >
   > **PROM**指的是“可编程只读存储器”既Programmable Red-Only Memory。这样的产品只允许写入一次
   >
   > **EPROM**指的是“可擦写可编程只读存储器”，即Erasable Programmable Read-Only Memory。 它的特点是具有可擦除功能，擦除后即可进行再编程
   >
   > **EEPROM**指的是“电可擦除可编程只读存储器”，即Electrically Erasable Programmable Read-Only Memory。它的最大优点是可直接用电信号擦除，也可用电信号写入。





# Question 2

A simple 4-bit CPU consists of an ALU made up of the multiplexer shown below. It uses only one register, the Accumulator A. It can take one operand B using two addressing modes: immediate and direct. Immediate means that the operand follows the opcode and direct means that the operand is pointed out by the address which follows the opcode. The difference is encoded by the bit S2, with 1 meaning immediate and 0 meaning direct.

The 4 actions available are LOAD, which loads the accumulator, ADD which adds operator B to the accumulator A, AND which does a logical ‘and’ between B and A, XOR, which does a logical ‘xor’ between A and B and ADD, which adds A and B ignoring any carry. The result is put back into the accumulator.

A load immediate 5 instruction looks like: `LOAD 5h`
An ADD direct A instruction looks like: `ADD @Ah`

![image-20220830192044881](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202208301920913.png)

1.  
   1. How many bits does each instruction require?
   2. How many memory locations can this CPU address directly?



2. Obtain the machine code in hex for: 
   ```assembly
   XOR @8
   AND 9
   ```

   

3. Suppose the memory locations 0, 1, 2, 3 and 4 contains the values 5, 6, 7, 8, 9 respectively. What is stored in the accumulator after the CPU has executed the following code segment?

   ```assembly
   LOAD @3 
   ADD 5
   XOR @0
   ```

   

4. Write a few lines of code that will calculate the two’s complement of the number 7.





# Question 3

Intel CPU’s can handle different types of data, such as byte, string, integer and floating-point numbers. For numbers, Intel CPU’s use the little-endian convention of storing data in memory.

1. Briefly explain the main difference between big and little-endian conventions of data storage.

   > 大端存储与小端存储模式主要指的是数据在计算机中存储的两种字节优先顺序。小端存储指从内存的低地址开始，先存储数据的低序字节再存高序字节；相反，大端存储指从内存的低地址开始，先存储数据的高序字节再存储数据的低序字节。
   >
   > *各自优点：*
   > 小端存储：便于数据之间的类型转换，例如：long类型转换为int类型时，高地址部分的数据可以直接截掉。
   > 大端存储：便于数据类型的符号判断，因为最低地址位数据即为符号位，可以直接判断数据的正负号。

2. Determine how the 8086 stores the real value 6.75 in short real format.

   110.11

3. The following block of code is used to provide data to an 8086 assembly language programme. The offset address pointed to by the label ‘num’ is 1000h. 

   ![image-20220830192325301](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202208301923326.png)

   Fill in the contents of the memory from location 1000h.



4. The registers in 8086 are 16-bit long, but the address bus is 20-bit long. How does 8086 generate the addresses for data, code and stack from the 16-bit registers?

   > Use two register, and one register stand the segment address, one register stand offset address. So the real address = (segment address)\*10H + offset address.



# Question 4

8086 CPU has three types of interrupts, hardware, software and exceptions.

1. What is the difference between these three types of interrupts?

   > - The Hardware Interrput is caused when an external signal applied to the INTR pin or NMI pin of the processor
   > - The Software Interrput is caused by the execution of an assembly language INT command.
   > - The Exceptions Interrput is triggred by internal errors such as divide by zero, normolly to print an error message.

2. Why are interrupts necessary for the proper functioning of the CPU? Give one function each for hardware and software interrupts.

   > 系统需要中断机制，否则就得用轮询确认 IO 是否到达

3. When an interrupt occurs, explain briefly the actions taken by the CPU.

   > When Interrupted the microprocessor,
   >
   > - suspends execution of the main program,
   > - calls a procedure which services the interrupt (interrupt handler or interrupt service routine),
   > - returns control to the mainline program.

4. There are only 2 pins on the 8086 for hardware interrupts, namely NMI and INTR. Explain how the 8086 can allow for interrupts from more than two external sources, for example, from the keyboard, the printer, and the serial communication port.

   > Interrupt vector table
   >
   > 8086支持256个中断，对应每个中断需要安排一个中断服务程序。256个中断服务程序的首地址(CS:IP)按序排列在一起组成一个中断向量表, 每个中断向量由4字节组成。



# Question 5

Metal Oxide Semiconductor Field Effect Transistors (MOSFETs) are used in the fabrication of most semiconductor devices.

1. Sketch the structure of an n-channel MOSFET, marking clearly metal, oxide, n-doped, p-doped and silicon parts.

2. Explain how well each of the following materials support the flow of current in terms of charge carriers and energy bands:
   1. metal
   2. oxide
   3. n-doped silicon
   4. p-doped silicon
   5. pure silicon
3. Tri-state devices made from CMOS inverters are needed to connect input and output lines to data buses. Explain how these tri-state devices function, and what can happen if they are not used.