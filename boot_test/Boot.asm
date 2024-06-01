[org 0]
[bits 16]

jmp 0x0000:start

start:
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg1
print_loop1:
    lodsb
    or al, al
    jz system_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop1

system_info:
    mov si, msg2
print_loop2:
    lodsb
    or al, al
    jz info1
    mov ah, 0x0E
    int 0x10
    jmp print_loop2

info1:
    mov si, msg3
print_loop3:
    lodsb
    or al, al
    jz info2
    mov ah, 0x0E
    int 0x10
    jmp print_loop3

info2:
    mov si, msg4
print_loop4:
    lodsb
    or al, al
    jz hang
    mov ah, 0x0E
    int 0x10
    jmp print_loop4

hang:
    jmp hang

msg1 db 'Booting from miniOS!', 0
msg2 db 'OS Information:', 0
msg3 db '1. Process Scheduling: FCFS, SJF, SRTF, Round Robin', 0
msg4 db '2. Memory Management: First Fit, Best Fit', 0

times 510-($-$$) db 0
dw 0xAA55   
