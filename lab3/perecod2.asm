  .MODEL SMALL
  .STACK 16h
  .DATA
   tab db 'abcdefghij' ;
   tab1 db '����������' ;
   spr db '������ ���� 0..9:',13,10,'$'
   exit db '��室 �� <Esc>',13,10,'$'
   msg  db 'r- ��ਫ��, l- ��⨭��",13,10,"$"
  .CODE
   START:mov ax,@DATA
   mov ds,ax ;
   ;�뢮�  
   mov ah,9
   mov dx,offset exit
   int 21h
   mov dx,offset spr
   mov ah,9
   int 21h 
   mov dx,offset msg
   mov ah,9
   int 21h 

   ;
   LAB11:
   mov ah,8
   int 21h
   cmp al,27d;
   je KC ;

   cmp al,'r';
   je LAB22 ;

   cmp al,'0' ;
   jl LAB11
   cmp al,'9'
   ja LAB11
   sub al,'0';
   push ds
    lds bx,cs:[200h]
     xlat ;

  pop ds
  mov ah,2
  mov dl,al
  int 21h
  jmp LAB11

  ;LAB2:

  LAB22:
  mov ah,8
  int 21h
  cmp al,27d;
  je KC
  ;
  cmp al,'l'
  je LAB11

  cmp al,'0'
  jl LAB22
  cmp al,'9'
  ja LAB22
  sub al,'0';
  push ds
  lds bx,cs:[210h]
  xlat       ;
  pop ds
  mov ah,2
  mov dl,al
  int 21h
  jmp LAB22

  KC:mov ah,4ch ;
  int 21h

  org 200h  ;
  dw offset tab
  dw seg tab

  org 210h
  dw offset tab1
  dw seg tab1


  end START
