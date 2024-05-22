# Compiler and flags
CC = gcc
CFLAGS = -Wall -g -Iinclude
# Linker flags
LDFLAGS = -lreadline

# The build target executable:
TARGET = minios

# Source, Object files
SRCS = boot/boot.c boot/function.c kernel/kernel.c kernel/system.c kernel/20192569/makechild.c kernel/20192569/ipc.c kernel/20192569/pi.c kernel/20192569/round_robin.c
OBJS = $(SRCS:.c=.o)

# Include directory
INCLUDE_DIR = include

all: $(TARGET) boot/final.img

# Build the main target
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)

# To obtain object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Create the final image
boot/final.img: boot/Boot.img boot/Sector2.img boot/disk.img
	cat boot/Boot.img boot/Sector2.img boot/disk.img > boot/final.img

boot/disk.img: boot/boot.img
	objcopy -O binary boot/boot.img boot/disk.img

boot/boot.img: boot/boot.o boot/function.o
	ld -melf_i386 -Ttext 0x10200 -e _start -nostdlib boot/boot.o boot/function.o -o boot/boot.img

boot/boot.o: boot/boot.c
	$(CC) -c -m16 -ffreestanding boot/boot.c -o boot/boot.o

boot/function.o: boot/function.c
	$(CC) -c -m16 -ffreestanding boot/function.c -o boot/function.o

boot/Boot.img: boot/Boot.asm
	nasm -f bin -o boot/Boot.img boot/Boot.asm

boot/Sector2.img: boot/Sector2.asm
	nasm -f bin -o boot/Sector2.img boot/Sector2.asm

# Clean up:
clean:
	rm -f $(OBJS) $(TARGET) *.o boot/final.img boot/boot.img boot/Sector2.img boot/disk.img boot/main.img
