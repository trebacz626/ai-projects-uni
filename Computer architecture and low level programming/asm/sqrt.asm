bits    32
global  main

extern  printf
extern scanf

section .data
    welcome_msg      db 'Provide a max value',10,0
    scanf_format     db '%f', 0
    out_format       db 'sqrt(%f) num: %f', 10, 0
    step             dq 0.125

section .bss
    max_number       resd 1
    root             resd 1
    tmp              resq 1

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
        fld     qword[max_number]
        fst    qword[tmp]
        push dword[tmp+4]
        push dword[tmp]
        fld qword[max_number]
        fsqrt
        fst qword[tmp]
        push dword[tmp+4]
        push dword[tmp]
        push    out_format
        call    printf
        add     esp, 20
        sub     eax, eax
        ret