format ELF64 executable

STDOUT = 1
HAPPY_EXIT_CODE = 1
SYSCALL_EXIT = 60
SYSCALL_WRITE = 1

macro print fd, buf, len
{
    mov rax, SYSCALL_WRITE ; 1 -> write, which takes three arguments (below)
    mov rdi, fd
    mov rsi, buf
    mov rdx, len
    syscall
}

macro exit code 
{
    mov rax, SYSCALL_EXIT 
    mov rdi, HAPPY_EXIT_CODE 
    syscall
}

segment readable executable
entry main
main:
    print STDOUT, msg, msg_len
    exit 1 


segment readable writeable
msg db "Hello, World!", 10
msg_len db $ - msg

