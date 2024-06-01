[org 0]
[bits 16]

jmp 0x0000:start

start:
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg
print_loop1:
    lodsb
    or al, al
    jz miniOS_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop1

miniOS_info:
    mov si, miniOS_info
print_loop2:
    lodsb
    or al, al
    jz PS_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop2

PS_info:
    mov si, PS_info
print_loop3:
    lodsb
    or al, al
    jz MM_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop3

MM_info:
    mov si, MM_info
print_loop4:
    lodsb
    or al, al
    jz GUI_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop4

GUI_info:
    mov si, GUI_info
print_loop5:
    lodsb
    or al, al
    jz hang
    mov ah, 0x0E
    int 0x10
    jmp print_loop5

hang:
    jmp hang

msg db 'Booting from miniOS!', 0
miniOS_info db 'miniOS Information:', 0
PS_info db '1. Process Scheduling: FCFS, SJF, SRTF, Round Robin', 0
MM_info db '2. Memory Management: First Fit, Best Fit', 0
GUI_info db '3. GUI: Login, Input Entry, Output Text, Scroll', 0

times 510-($-$$) db 0
dw 0xAA55
