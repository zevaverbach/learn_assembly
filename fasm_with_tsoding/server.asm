format ELF64 executable

STDOUT = 1
HAPPY_EXIT_CODE = 0
SYSCALL_EXIT = 60
SYSCALL_WRITE = 1
SYSCALL_SOCKET = 41
AF_INET = 2
SOCK_STREAM = 1

macro print buf, len
{
    mov rax, SYSCALL_WRITE ; 1 -> write, which takes three arguments (below)
    mov rdi, STDOUT
    mov rsi, buf
    mov rdx, len
    syscall
}

macro exit code 
{
    mov rax, SYSCALL_EXIT 
    mov rdi, code 
    syscall
}

macro socket domain, type, protocol
{
    mov rax, SYSCALL_SOCKET
    mov rdi, domain
    mov rsi, type
    mov rdx, protocol
    syscall
}

segment readable executable
entry main
main:
    print msg, msg_len
    socket AF_INET, SOCK_STREAM, 0
    mov dword [socket_fd], eax
    print [socket_fd], 32
    exit HAPPY_EXIT_CODE


segment readable writeable
msg db "Starting web server!", 10
msg_len db $ - msg
socket_fd dd 0
