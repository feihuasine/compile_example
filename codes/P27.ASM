assume cs:codesg
data segment
        dw 0,0
data ends
codesg segment
start:  mov ax,data
        mov ds,ax
        mov bx,0
        jmp word ptr [bx+1]
codesg ends
end start
