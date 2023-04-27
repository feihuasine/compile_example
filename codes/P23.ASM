assume cs:codesg,ds:datasg,ss:stacksg
datasg segment
        db 'ibm             '
        db 'dec             '
        db 'dos             '
        db 'vax             '
datasg ends
stacksg segment
        dw 0,0,0,0,0,0,0,0
stacksg ends
codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov ax,stacksg
        mov ss,ax
        mov sp,10h
        mov cx,4
        mov bx,0
      s:mov si,0
        push cx
        mov cx,3
     s0:mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s0
        add bx,16
        pop cx
        loop s

        mov ax,4c00h
        int 21h
codesg ends
end start
