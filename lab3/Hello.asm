.model	small		
.stack	16h
.data
Hello_msg db 'hello dima',13,10,'$'
.code
start: mov ax,@data
mov ds,ax
mov ah,9
lea dx,hello_msg
int 21H
mov ah,4ch
int 21h
end start