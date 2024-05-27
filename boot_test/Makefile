CC = gcc

final.img : Boot.img Sector.img disk.img
	cat Boot.img Sector.img disk.img > final.img

disk.img : main.img
	objcopy -O binary main.img disk.img

main.img :main.o function.o
	ld -melf_i386 -Ttext 0x10200 -nostdlib main.o function.o -o main.img

main.o : main.c
	gcc -c -m32 -ffreestanding main.c -o main.o

function.o : function.c
	gcc -c -m32 -ffreestanding function.c -o function.o

Boot.img : Boot.asm
	nasm -f bin -o Boot.img Boot.asm

Sector.img : Sector.asm
	nasm -f bin -o Sector.img Sector.asm

clean :
	rm *.o
