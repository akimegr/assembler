 .model small                  ; Модель памяти
 .stack 16h                    
 .data                         
   msg label byte ;стуктура для ввода символов с клавиатуры
   maxnum db  6
   reallen db ?
   numfld db 5 dup(30h)
   mult10 dw 1   ;переменная для преобразования
   ascval db 10 dup(30h),13,10,'$'; Массив цифр для вывода
  x  dw  ?       ; Объявление переменных - х  вспомогательная переменная
  a  dw  30
  b  dw  60
  c  dw  15
  d  dw  7
   
   txt2 db 13,10, 'введите переменную a=$'
   txt3 db 13,10, 'введите пременную  b=$'
   txt4 db 13,10, 'введите переменную c=$'
   txt5 db 13,10, 'введите переменную d=$'
   txt  db 13,10, ' результат X=$'

  .code                         ; Кодовый сегмент
  start: mov ax, @data          ; Начало программы
         mov ds, ax             ; Настройка сегментного регистра данных ds 
     
   
     mov ah, 9   ;  ввод переменной а
     lea dx, txt2
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax, x
     mov a,ax
    
     mov ah, 9     ;   переменная b
     lea dx, txt3
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax, x
     mov b,ax

     mov ah, 9     ;   переменная c
     lea dx, txt4
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax,x
     mov c,ax
  
     mov ah, 9    ;   переменная d
     lea dx, txt5
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax,x
     mov d,ax
  

	mov ax, 3
	imul c
	mov bx, dx
	mov cx, ax
	mov ax, b
	imul a
	sub ax, cx
	sbb dx, bx
	mov cx, d
	add cx, 2
	idiv cx
	mov x, ax


      ; mov ax, b              ; Загрузка константы, начало вычисления выражения z=(a*2+b*c)/(d-3)
      ; imul a                 ; dx:ax<=a*2, сохраниние
      ; mov bx, dx
      ; mov cx, ax             ; bx:cx<=a*2
      ; mov ax, 3
      ; imul c                 ; dx:ax<=b*c, вычисление числителя
     ; mov bx,dx
     ; mov cx, ax
      ; sub ax,cx
      ; sbb bx,dx             ; dx:ax<=a*2+b*c+cf, выч знаменателя
      ; mov cx, d
      ; add cx, 2              ; cx<=d-3
      ; idiv cx                ; ax<=(a*2+b*c)/(d-3), сохр целой части результата
      ; mov x, ax

       mov ah, 9
       lea dx, txt
       int  21h

       call outp              ; Вызов процедуры, вывода на экран 
     
       mov ah, 4ch            ; Загрузка функции 4с
       int 21h                ; Возврат в DOS

      asbin proc         ; процедура преобразования символа в число    
        
       mov mult10,0001
       mov x,0
       mov cx,10
       lea si,numfld-1
       mov bl,reallen
       sub bh,bh
b20:
       mov al,[si+bx]
       and ax,000fh
       mul mult10
       add x,ax
       mov ax,mult10
       mul cx
       mov mult10,ax
       dec bx
       jnz b20
       ret
  asbin  endp

    outp proc                     ; Начало тела процедуры
       mov cx,10              ;основание системы исчисл 
       lea si, ascval+9       ; Установка указателя на конец массива ascval
       mov ax, x              ; промежуточный  Результат х занести в ax
c20:   cmp ax,10              ; Сравнить результат с числом 10
       jb c30                 ; Если меньше то преобразовывать не надо
       xor dx,dx              ; Очистка регистра dx для команды деления
       div cx                 ; Делим на 10
       or dl, 30h             ; Преобразование остатка к ASCII коду
       mov [si], dl            ; Занесение остатка от деления в массив ascval
       dec si                 ; Перемещение указателя массива на 1 байт влево
       jmp c20                ; Переход на начало для преобразования след. цифры
c30:   or al, 30h             ; Если остаток меньше 10, то вывод результата на экран
       mov [si], al            ; дисплея командами (см. ниже)
       lea dx, ascval         ; Загрузка адреса массива
       mov ah, 9              ; Вызов 9-ой функции MS-DOS 
       int 21h
       ret                    ; Возврат в головную программу из п/программы
outp endp                     ; Конец процедуры
end start