assume cs:code
code segment
start:  mov ax,0b800h
        mov es,ax
        mov ah,'a'
      s:mov es:[160*12+40*2],ah
        call delay
        inc ah
        cmp ah,'z'
        jna s

        mov ax,4c00h
        int 21h

delay:  push ax
        push dx
        mov dx,1000h
        mov ax,0
    s1: sub ax,1
        sbb dx,0
        cmp ax,0
        jne s1
        pop dx
        pop ax
        ret

code ends
end start

