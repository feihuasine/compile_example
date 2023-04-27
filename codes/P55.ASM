assume cs:code
code segment
        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,2000
      s:mov byte ptr es:[bx],'A'
        add bx,2
        loop s

        mov ax,4c00h
        int 21h
code ends
end
