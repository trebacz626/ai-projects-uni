bits    32
global  main

extern  printf
extern scanf

section .data
    welcome_msg      db 'Provide a max value',10,0
    scanf_format     db '%lf', 0
    out_format       db 'sqrt(%f) num: %f', 10, 0

section .bss
    max_number       resq 1
    root             resq 1

section .text

    for_loop:
    main:
        ;print welcome message
        push    welcome_msg
        call    printf
        add     esp, 4
        ;scanf word
        push    max_number
        push    scanf_format
        call    scanf 
        add     esp, 8
        ;print word
        push dword[max_number+4]
        push dword[max_number]
        fld qword[max_number]
        fsqrt
        fstp qword[root]
        push dword[root+4]
        push dword[root]
        push    out_format
        call    printf
        add     esp, 20
        sub     eax, eax
        ret