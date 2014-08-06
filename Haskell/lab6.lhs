You are going to implement the "first" sap:

We'll go over this design. During lab next time we will implement the next iteration of
the sap.


Instruction Set Architecture of the Sap-1a

Word size: 		one byte (8 bits)

Memory: 		16 bytes

Registers: 		A, Out (each one byte) plus PC (4 bits)

Instructions: 
  Notes: M means a memory address
	 c(M) means contents of memory location addressed by M
	 mmmm means a four bit memory address representing address location M
	 xxxx means 4 don't-care bits

	Instruction	Format		Meaning
	-----------	------		-------
	LDA M       0000mmmm    A <- c(M)
	ADD M       0001mmmm    A <- A + c(M)
	SUB M       0010mmmm    A <- A - c(M)
	OUT         1110xxxx   	Out <- A
	HLT         1111xxxx   	Halt execution
	STA M       0011mmmm   	c(M) <- A
	JMP M       0100mmmm   	PC <- M
	JAZ M       0101mmmm   	PC <- M if A == 0


In order to do this we need to "simulate" memory and the cpu state. A computer can be
modelled as a memory to memory function. The effect of an instruction is to alter
memory, alter a register (the cpu state). 

First ... what do we need to model in the cpu? The cpu has registers which is a kind
of memory. The most relevant being the PC and the A. Depending on how true we want to
be to the actual SAP we have some choices.

First let's look at memory. Memory is really just a list of locations. So we
can model memory as an "array" which is indexed by a memory location.
But we can't use a list in get to a memory location by lopping off the top
of the list ... memory shouldn't disappear. So we'll use get and put to access
and replace memory locations. There are 16 bytes of memory.

>	get m n = m !! n
>	put m n v = take n m ++ [v] ++ drop (n+1) m

Next we should consider what a word looks like. Works in memory are just bit strings.
Each word is just 1 byte long (8 bits).  We could store these bit strings as the
memory word, in which case we'd have to reassemble the bits into their
meaning each time (eg a memory address [0101] would have to be translated into
5 to access memory as an index).  Or we could store it as a pair of ints (Int,Int) where
the first Int is the opcode and the second the argument. Then when we are looking at
data we'd have to "reassemble" the pair into the actual Int.

We could do both to do a comparison, but lets start with the pair version.

>	type Mem = [(Int,Int)]
>	type Addr = Int
>	type OpCode = Int

Q1. Write a pair of functions getData and putData that convert between the memory
format and an int. So getData takes a pair, and converts it to an int. putData takes
an int, and converts it to a memory pair.

getData ((Addr, OpCode), tail) = (Addr * 10) + OpCode

putData 

Here we have the cpu state:

>	type PC   = Int
>	type A    = Int
>	type Out  = Int

>	type Cpu_s = ((PC, A, Out), Mem)


Now we can write the individual instructions:


	LDA M       0000mmmm    A <- c(M)

We'll assume that the instruction has already been decode (which is how
we know it is an LDA instruction) so that we have mem_addr

>	lda :: Addr -> Cpu_s -> Cpu_s
>	lda 

	ADD M       0001mmmm    A <- A + c(M)

>	add :: Addr -> Cpu_s -> Cpu_s

	SUB M       0010mmmm    A <- A - c(M)

>	sub :: Addr -> Cpu_s -> Cpu_s


	OUT         1110xxxx   	Out <- A

>	out :: Addr -> Cpu_s -> Cpu_s

	STA M       0011mmmm   	c(M) <- A

>	sta :: Addr -> Cpu_s -> Cpu_s

	JMP M       0100mmmm   	PC <- M

>	jmp :: Addr -> Cpu_s -> Cpu_s

	JAZ M       0101mmmm   	PC <- M if A == 0

>	jaz :: Addr -> Cpu_s -> Cpu_s


Now we can write the eval loop. HLT is directly interpreted by the
eval loop.

	HLT         1111xxxx   	Halt execution

>	eval :: Cpu_s -> Cpu_s

The basic work of eval is to first
	1. get the (op, arg) from the mem specified at location pc
	2. if the op is a halt, then halt, and dump the cpu state
	3. if it is not a halt, then eval the operator in the current state.

To eval the operator in the current state is just a big
switch statement.

>	evalOp	:: (OpCode, Addr) -> Cpu_s ->Cpu_s


>	sapTestProg2 :: Mem
>	sapTestProg2 = [(0,14), (5,8), (1,15), (3,15), (0,14), (2,13), (3,14), (4,1), (0,15), (14,0), (15,0), (0,0), (0,0), (0,1), (0,6), (0,0) ]

>	sapTestProg1 :: Mem
>	sapTestProg1 = [(0, 6), (1,7), (2,8), (3,7),(14,0), (15, 0),(0,4),(0,5), (0,2)]

>	initState1 :: Cpu_s
>	initState1 = ((0,0,0), sapTestProg1)

>	initState2 :: Cpu_s
>	initState2 = ((0, 0, 0), sapTestProg2)


Testing jaz and jmp

>	jmpProg :: Mem
>	jmpProg = [(4, 3), (0, 5), (1,5), (15,0), (0,1), (0,2)]

>	jmpProg2 :: Mem
>	jmpProg2 = [(0, 4), (5, 3), (1,5), (15,0), (0,1), (0,2)]

>	jmpProg3 :: Mem
>	jmpProg3 = [(0, 4), (5, 3), (1,5), (15,0), (0,0), (0,2)]




How about looking at some logic gates as well as an adder. The logic gates are easy:

>	b_not a = not a
>	b_and  a b = a && b
>	b_or a b = a || b
>	nand a b = b_not (b_and a b)

>	nor a b = b_not (b_or a b)

We'll follow the circuit for the half adder in Figure 8 through 10 Section 11.3.
Implement these circuits.

>	half :: Bool -> Bool -> (Bool, Bool)
>	full :: Bool -> Bool -> Bool -> (Bool, Bool)
>	adder :: [Bool] -> [Bool] -> ([Bool], Bool)

Now, implement the circuits in problems Sec 11.3: 2,4, 10, 11, 13, 15



If you finish all the above and are looking for more enrichment ... try
implementing the SAM.
