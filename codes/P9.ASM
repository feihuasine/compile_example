assume cs:code
code segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
start:	mov ax,cs
		mov ss,ax
		mov sp,30h
		
		mov bx,0h
		mov cx,8h
	s:	push cs:[bx]
		add bx,2h
		loop s
		
		mov bx,0h
		mov cx,8h
	s2:	pop cs:[bx]
		add bx,2h
		loop s2
		
		mov ax,4c00h
		int 21h
code ends
end start
		