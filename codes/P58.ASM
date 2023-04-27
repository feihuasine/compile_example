assume cs:codesg,ds:datasg
datasg segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1900','1991','1992'
        db '1993','1994','1995'

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000
        dd 5937000

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8266
        dw 11542,14430,15257,17800
datasg ends
table segment
        db 21 dup ('year summ ne ?? ')
table ends
codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov dx,table
        mov es,dx

        mov cx,21
        mov bx,0
        mov si,0
        mov di,0

      s:mov ax,ds:[si+0]
        mov es:[bx+0],ax
        mov ax,ds:[si+2]
        mov es:[bx+2],ax

        mov ax,ds:[si+84]
        mov es:[bx+5],ax
        mov ax,ds:[si+86]
        mov es:[bx+7],ax

        mov ax,ds:[di+168]
        mov es:[bx+10],ax

        mov dx,es:[bx+7]
        mov ax,es:[bx+5]
        div word ptr es:[bx+10]
        mov es:[bx+13],ax

        add si,4
        add di,2
        add bx,16
        loop s

        call winclear

        call showmsg


        


        mov ax,4c00h
        int 21h

winclear:       push ax
                push bx
                push cx
                push es

                mov ax,0b800h
                mov es,ax
                mov bx,0
                mov cx,2000
             s0:mov byte ptr es:[bx],' '
                add bx,2
                loop s0

                pop es
                pop cx
                pop bx
                pop ax
                ret

showmsg:        push ax
                push bx
                push cx
                push ds
                push es
                push di
                push si

                mov ax,0b800h
                mov es,ax
                mov di,2

                mov ax,table
                mov ds,ax
                mov si,0

                mov cx,4

             s1:mov al,ds:[si]
                mov es:[di],al
                add di,2
                inc si
                loop s1

                call dtoc


                pop si
                pop di
                pop es
                pop ds
                pop cx
                pop bx
                pop ax
                ret

dtoc:           push

                inc si
                mov ax,ds:[si]
                add si,2
                mov dx,ds:[si]


codesg ends
end start
