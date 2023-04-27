assume cs:code
stack segment
	db 128 dup (0)
stack ends 
data segment
	dw 0,0
data ends 
code segment
start:
	mov ax,stack 
	mov ss,ax 
	mov sp,128
	mov ax,data 
	mov ds,ax 
	mov ax,0
	mov es,ax 
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]			;将原来int 9中断例程的入口地址保存在ds:0和ds:2单元
	mov word ptr es:[9*4],offset int9
	;在中断向量表中设置新的int 9中断例程的偏移地址
	mov es:[9*4+2],cs
	;在中断向量表中设置新的int 9中断例程的段地址
	mov ax,0b800h
	mov es,ax
	mov ah,'a'
s:
	mov es:[160*12+40*2],ah
	call delay			;调用子程序，让CPU休眠
	inc ah 
	cmp ah,'z'
	jna s
	mov ax,0
	mov es,ax
	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]		;恢复原int 9中断例程的地址
	mov ax,4c00h
	int 21h
delay:			;共执行循环10h*1000h次
	push ax 
	push dx 	;保护现场
	mov dx,10h
	mov ax,0
help:
	sub ax,1	;(AX)=0FFFFh
	sbb dx,0	;无符号运算(AX)=(AX)-1使得CF=1，本句相当于(DX)=(DX)-0-CF(1)=0Fh
	cmp ax,0	
	jne help 	;如果(AX)不等于零则转移至s1，循环0FFFFh次
	cmp dx,0
	jne help 	;如果(DX)不等于零则转移至s1，0Fh不等于零而(AX)等于零使得sub ax,1又等于0FFFFh
	pop dx 
	pop ax 		;恢复现场
	ret 
int9:
	push ax 
	push bx 
	push es			;保护现场
	in al,60h	
	pushf			;标志寄存器入栈
	pushf
	pop bx
	and bh,11111100b;TF和IF为第9位和第8位
	push bx 
	popf 			;TF=0、IF=0
	call dword ptr ds:[0]
	;CS和IP入栈，且目的CS由内存单元高地址给出、IP由低地址给出
	cmp al,1		;esc的通码为1
	jne int9ret
	mov ax,0b800h
	mov es,ax 
	inc byte ptr es:[160*12+40*2+1]
	;更改字母的显示颜色
int9ret:
	pop es 
	pop bx 
	pop ax 			;恢复现场
	iret
code ends
end start 
