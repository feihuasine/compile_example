assume cs:code
code segment
        mov ax,2000h
        mov es,ax
        jmp dword ptr es:[1000h]
code ends
end
