# OPERATING SYSTEM

## 1- What is an Operating System?

**System** is some components integrated together for perform a desired task

**Operating System ** a program that manages the computer hardware, and provides a basis for application programs and acts as an intermediary between users and hardware

**To build an Operating System you must focus on three main objectives:**

1. **Efficiency**   OS is responsive in working with resources and system (مش بيعطل كتير وسهل الاستخدام كدة وسهل التعامل معاه بدون تعقيد)
2. **Ease of usability** to the user in terms of making it convenient
3. **Ability to abstract  and extend to new devices and software** (سهل انك تنقلله من جهاز لجهاز وانك توصل فيه اي جهاز من غير عواقب يعني )

### The Main Functions of OS:

1. It is an interface between User & Hardware
2. Allocation of resources(CPU, MEMORY, I/O DEVICES)
3. Management of memory, security, etc.

## 2- Computer System Components:

![image-20240603132341691](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240603132341691.png)

### Computer system can be divided into four components:-

**1-Operating System** 

A program that acts as an intermediary between a user of a computer and the computer hardware.

> [!IMPORTANT]
>
> **OS**  controls and coordinates the use of the hardware among the various application programs for the various users.

مجرد بتتحكم وتنظم استخدام الابليكشنز للهاردوير 

**2-Hardware** provides basic computing resources CPU, memory, I/O devices

**3-Application programs** programs that are used to perform a specific task and that can be directly used by users

**4-Users** people, machines, other computers

> [!NOTE]
>
> **Von Neumann ** is the operating system's inventor



**Central Processing Unit (CPU,Processor, Microprocessor)** electronic circuit responsible for executing the instructions of a computer program.

السي بي يو هو المسؤول عن تنفيذ العمليات والاوامر اللي جياله من خلال البرامج المختلفة

> [!TIP]
>
> **Registers** are high speed storage area in the CPU, all the data **must** be stored in a register before it can be processed.

![Functional Components of a Computer System](https://4.bp.blogspot.com/-smdfPur3EeI/WUIswxrniyI/AAAAAAAADFE/fcW0w5NElXws9SI4gf2Wi40C7FRh6aO0ACEwYBhgL/s16000/functional%2Bcomponents%2Bof%2Bcomputer.png)

**Arithmetic and logic unit (ALU)**

Allows arithmetic (add , subtract...etc) and logic operations to be carried out (AND, OR, NOT)

مسؤؤل عن تنفيذ العمليات الحسابية والمنطقية جوا البروسيسور

**Control Unit (CU):**

Controls the operation of the computer's ALU, memory and input/output devices, telling them how to respond to the program instructions it has just read and interpreted from the memory unit



### **Memory consists of two types:-**

1-**Main Memory ( RAM & ROM)** 

2-**Secondary Memory(HDD)** 

![image-20240602232033041](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240602232033041.png)

![image-20240603151139887](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240603151139887.png)

**Buses** the routes the data is transmitted from one part of a computer to another, connecting all major internal components to the CPU and memory

**Controller ** is responsible for the way the device connected with it works 

> [!TIP]
>
> - Each device controller is in charge of a specific type of device,
>
> - the CPU and the device controllers can execute concurrently, competing for memory cycle
> - The memory controller takes care of how the memory has to be shared between each device

### Some Important Terms:-

**1. Bootstrap Program** 

the initial program that runs when a computer is powered up or rebooted

- it's stored in the **ROM**

- it must know how to load the **OS and start executing that system**

- it must locate and load into memory the **OS Kernel**

![Bootstrap program](https://imgs.search.brave.com/TyKKrhEnGdnklljUCZzm3jNO1oSWGm1GGhfTPO3sRK4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/dHV0b3JpYWxzcG9p/bnQuY29tL2Fzc2V0/cy9xdWVzdGlvbnMv/bWVkaWEvMTE3MTQv/Qm9vdHN0cmFwJTIw/UHJvZ3JhbS5QTkc)

**2. Interrupt**

The occurrence of an event is usually signaled by an interrupt from hardware or software

- Hardware may trigger an interrupt at any time by sending a signal to the CPU, usually by the way of the system bus

**3.System Call**

Software may trigger an interrupt by executing a special operation called system call

![image-20240603155333563](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240603155333563.png)

