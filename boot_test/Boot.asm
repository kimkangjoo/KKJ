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
    jz OS_info
    mov ah, 0x0E
    int 0x10
    jmp print_loop1

system_info:
    mov si, OS_info
print_loop2:
    lodsb
    or al, al
    jz logo
    mov ah, 0x0E
    int 0x10
    jmp print_loop2

info1:
    mov si, info_1
print_loop3:
    lodsb
    or al, al
    jz boot_menu
    mov ah, 0x0E
    int 0x10
    jmp print_loop3

info2:
    mov si, info_2

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
OS_info db 'OS Information:', 0
info_1 db '1. Process Scheduling: FCFS, SJF, SRTF, Round Robin', 0
info_2 db '2. Memory Management: First Fit, Best Fit', 0

times 510-($-$$) db 0      ; 부트 섹터를 0으로 채움
dw 0xAA55
