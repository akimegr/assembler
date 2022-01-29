; вычислить выражение  a*b/c-d и записать результат в файл  RES.TXT.
;сформировать звук частотой  1000 ГЦ ,а длительность считать из файла SOUND.TXT
.286
.model small
.stack 256
.data
	an db 100  ;пременные
	bn db 30
	cn db 200
	dn db 98
	dlit dw 0
	buffer db 3 dup(?)           ; буфер для перекодировки
	filename db 'RES.TXT',0      ; записать результат
	soundfile db 'SOUND.TXT',0   ; файл откуда читаем длительность звука

	time dw ?
	ton dw ?

.code
	include common.inc     ;
start:                         ;
	mov ax,@data
	mov ds,ax
	mov al,an
	mul bn                 ; умножение чисел a*b
	mov cx,ax			;м
	mov al,3			;м
	mul cn			;м
	mov dx,ax			;м
	add cx,dx			;м
	mov dl,dn			;м
	mov ax,cx			;м
	sub dl,5			;м
	div dl			;м
	
	
	
	
	
	;div cn                 ; деление a*b/c
	;sub al,dn              ; вычитание    a*b/c-d
	xor ah,ah              ; очистка остатка от деления(в АХ - результат)
;
	push 10                ; перевод числа в строку
	push offset buffer+3   ;  поместить в стек
	push ax                ; результат вычисления
	mov ah,3Ch             ; создание файла
	xor cx,cx              ; 
	mov dx,offset filename ;загрузка указателя на имя файла
	int 21h
	mov bx,ax              ; загружаем дескриптор файла в bx
	call num2str           ; перевод числа в строку
	add sp,6               ;
	mov cx,offset buffer+3 ;загрузка числа записываемых в байт
	sub cx,ax  ;  
	mov dx,ax              ; адреc буфера с данными
	mov ah,40h             ; Номер функции записи в  файл
	int 21h
	mov ah,3Eh             ;закрываем файл res.txt
	int 21h

	mov ax,3D00h           ; открываем файл sound.txt
	mov dx,offset soundfile   ; адрес имени файла
	xor cl,cl
	int 21h

	mov ah,3Fh             ; читаем cодержимое файла
	mov dx,offset buffer   ; адрес буфера куда будут читаться данные
	mov cx,4               ; число считываемых байт
	int 21h

	push 10                ; превод строки в число(система счисления)
	push offset buffer  ;
	push 4               ;   длина строки
	call str2num           ; перевод строки в число
	add sp,6			;очистка стека
	mov time, ax	

	mov ah,3Fh             ; читаем cодержимое файла
	mov dx,offset buffer   ; адрес буфера куда будут читаться данные
	mov cx,1               ; число считываемых байт
	int 21h

	mov ah,3Fh             ; читаем cодержимое файла
	mov dx,offset buffer   ; адрес буфера куда будут читаться данные
	mov cx,4               ; число считываемых байт
	int 21h

	push 10                ; превод строки в число(система счисления)
	push offset buffer  ;
	push 4               ;   длина строки
	call str2num           ; перевод строки в число
	add sp,6			;очистка стека
			


	

	
	;mov dlit,ax
	;mov ax,3D00h           ; открываем файл sound.txt
	;mov dx,offset soundfile   ; адрес имени файла
	;xor cl,cl
	;int 21h
	;mov ah,3Fh             ; читаем cодержимое файла
	;mov dx,offset buffer   ; адрес буфера куда будут читаться данные
	;mov cx,4               ; число считываемых байт
	;int 21h
	;push 10                ; превод строки в число(система счисления)
	;push offset buffer  ;
	;push 4               ;   длина строки
	;call str2num           ; перевод строки в число
	;add sp,6
	
	push ax              ;частота звучания
	call sound
	add sp,2
	push 0                  ;
	push time   ;
	call pause ;
	add sp,4               ;
	call nosound
	mov ah,3Eh             ; закрываем файл
	int 21h
	call exit              ; выход из программы
end start
