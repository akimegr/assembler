;Программа перекодировки латинского алфавита

   s1 segment stack 'stack'
   stk db 16 dup(?)
   s1 ends
   d1 segment 'data'
   tab1 db 'а','б','в','г','д','е','ж','з','и','к','л','м'
   tab  db 'a','b','c','d','e','f','g','h','i','j','k','l'

   Hello_msg db ' Разработал программу Акимов.Введите символ от 0 до 9,выход по ESC ',13,10,'$'

 d1 ends
 code segment
 assume cs:code,ds:code
 ml proc far  ;Процедура с межсегментным вызовом
 mov ax,s1
 mov ss,ax
 mov ax,offset stk
 mov sp,ax
 push ds ;    Формирование возврата в операционную систему
 xor ax,ax;
 push ax   ;

  mov ax,d1  ;
  mov ds,ax
  mov ah,9
  lea dx,hello_msg
  int 21H

   start:

  push cs         ;настройка сегментного регистра ч-з стек
  pop ds
 start1:
  ; mov ah,0
  ; int 16h ;       ; Прерывание БИОСа для ввода кода нажатой клавиши
  ; cmp al,27d;     ; Сравнение кода клавиши с кодоом ESC
  ; je end_;        ; Переход на метку ЕND  при нажатии ESC

 lat: cmp al,'r';
      je rus;

   ;cmp al,'l';
   ;je lat;

  ;jmp start
   ;lat:
  push cs
  pop ds
  mov ah,0
  int 16h
  cmp al,27d;     ; Сравнение кода клавиши с кодоом ESC
  je end_;   
  cmp al,30h;     ; Сравнение с кодом 0
  jl start       ; Проверка диапозона кодов клавиш 0 - 9
  cmp al,39h
  jg start      ; Вычисление номера символа в перекодировочной таблице ТАБ
  sub al,"0"
  lds bx,cs:[200h]       ; Загрузка указателя перекодировочной таблицы
  xlat                   ; Команда перекодировки символов
  mov ah,2               ;  Вывод перекодируемого символа на экран диссплея
  mov dl,al              ;
  int 21h                ;
  jmp lat                ; Организация цикла программы перекодир. латиницы

  rus:	cmp al,'l';
	je lat;


  push cs
  pop ds
  mov ah,0
  int 16h

  cmp al,27d;     ; Сравнение кода клавиши с кодоом ESC
  je end_;        ; Переход на метку ЕND  при нажатии ESC
  cmp al,30h;     ; Сравнение с кодом 0
  jl rus          ; Проверка диапозона кодов клавиш 0 - 9
  cmp al,39h
  jg rus      ; Вычисление номера символа в перекодировочной таблице ТАБ1
  sub al,"0"
  lds bx,cs:[250h]        ;Загрузка указателя перекодировочной таблицы ТАБ1
   xlat                   ;Команда перекодировки символов
   mov ah,2               ;Вывод перекодируемого символа на экран дисплея
   mov dl,al              ;
   int 21h                ;
  jmp rus                 ; Организация цикла программы перекодир.кирилицы


   end_:
   ret    ; Возврат в операционную систему
   ml endp

  org 200h   ; на адресе смещения 200h находится указатель на
  ad_off dw offset tab ; перекодировочную таблицу ТАВ 
  ad_seg dw seg tab

  org 250h
  ad1_off1 dw offset tab1
  ad1_seg1 dw seg tab1
      code ends
      end ml
