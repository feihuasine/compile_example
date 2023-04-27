assume cs:code
data segment
        db 'Welcome to masm!',0
data ends
code segment
start:  mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str

        mov ax,4c00h
        int 21h
show_str:       mov al,dh
                mov ah,0
                sub ax
                mov bx,ah
                mul bx
                mov es,ax
                mov al,dl
                mov ah,0
                sub ax
                mov bx,2
                mul bx
                mov di,0
                mov al,cl
                mov ah,0
              s:mov cx,[si]
                jcxz ok
                mov byte ptr es:[bx+di],[si]
                inc di


             ok:

code ends
end start
