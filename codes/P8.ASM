assume cs:code
code segment
        dw 0123h,0345h,0678h,09abh,0cdeh,0fedh,0ba9h,0876h

  start:mov bx,0
        mov ax,0

        mov cx,8
      s:add ax,cs:[bx]
        add bx,2
        loop s

        mov ax,4c00h
        int 21h

code ends
end start

