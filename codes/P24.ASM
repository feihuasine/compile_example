assume cs:codesg,ss:stacksg,ds:datasg
stacksg segment
        dw 0,0,0,0,0,0,0,0
stacksg ends
datasg segment
        db '1. display      '
        db '2. brows        '
        db '3. replace      '
        db '4. modify       '
datasg ends
codesg segment
start:  mov ax,stacksg
        mov ss,ax
        mov sp,10h
        mov ax,datasg
        mov ds,ax
        mov bx,0
        mov cx,4
      s:push cx
        mov si,3
        mov cx,5
     s0:mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s0
        add bx,10h
        pop cx
        loop s
        
        mov ax,4c00h
        int 21h
codesg ends
end start
