 .model small                  ; ������ �����
 .stack 16h                    
 .data                         
   msg label byte ;������ ��� ����� ᨬ����� � ����������
   maxnum db  6
   reallen db ?
   numfld db 5 dup(30h)
   mult10 dw 1   ;��६����� ��� �८�ࠧ������
   ascval db 10 dup(30h),13,10,'$'; ���ᨢ ��� ��� �뢮��
  x  dw  ?       ; ������� ��६����� - �  �ᯮ����⥫쭠� ��६�����
  a  dw  30
  b  dw  60
  c  dw  15
  d  dw  7
   
   txt2 db 13,10, '������ ��६����� a=$'
   txt3 db 13,10, '������ �६�����  b=$'
   txt4 db 13,10, '������ ��६����� c=$'
   txt5 db 13,10, '������ ��६����� d=$'
   txt  db 13,10, ' १���� X=$'

  .code                         ; ������ ᥣ����
  start: mov ax, @data          ; ��砫� �ணࠬ��
         mov ds, ax             ; ����ன�� ᥣ���⭮�� ॣ���� ������ ds 
     
   
     mov ah, 9   ;  ���� ��६����� �
     lea dx, txt2
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax, x
     mov a,ax
    
     mov ah, 9     ;   ��६����� b
     lea dx, txt3
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax, x
     mov b,ax

     mov ah, 9     ;   ��६����� c
     lea dx, txt4
     int  21h
     mov ah,0ah
     lea dx,msg
     int 21h
     call asbin
     mov ax,x
     mov c,ax
  
     mov ah, 9    ;   ��६����� d
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


      ; mov ax, b              ; ����㧪� ����⠭��, ��砫� ���᫥��� ��ࠦ���� z=(a*2+b*c)/(d-3)
      ; imul a                 ; dx:ax<=a*2, ��࠭����
      ; mov bx, dx
      ; mov cx, ax             ; bx:cx<=a*2
      ; mov ax, 3
      ; imul c                 ; dx:ax<=b*c, ���᫥��� �᫨⥫�
     ; mov bx,dx
     ; mov cx, ax
      ; sub ax,cx
      ; sbb bx,dx             ; dx:ax<=a*2+b*c+cf, ��� �������⥫�
      ; mov cx, d
      ; add cx, 2              ; cx<=d-3
      ; idiv cx                ; ax<=(a*2+b*c)/(d-3), ��� 楫�� ��� १����
      ; mov x, ax

       mov ah, 9
       lea dx, txt
       int  21h

       call outp              ; �맮� ��楤���, �뢮�� �� ��࠭ 
     
       mov ah, 4ch            ; ����㧪� �㭪樨 4�
       int 21h                ; ������ � DOS

      asbin proc         ; ��楤�� �८�ࠧ������ ᨬ���� � �᫮    
        
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

    outp proc                     ; ��砫� ⥫� ��楤���
       mov cx,10              ;�᭮����� ��⥬� ���� 
       lea si, ascval+9       ; ��⠭���� 㪠��⥫� �� ����� ���ᨢ� ascval
       mov ax, x              ; �஬������  ������� � ������ � ax
c20:   cmp ax,10              ; �ࠢ���� १���� � �᫮� 10
       jb c30                 ; �᫨ ����� � �८�ࠧ��뢠�� �� ����
       xor dx,dx              ; ���⪠ ॣ���� dx ��� ������� �������
       div cx                 ; ����� �� 10
       or dl, 30h             ; �८�ࠧ������ ���⪠ � ASCII ����
       mov [si], dl            ; ����ᥭ�� ���⪠ �� ������� � ���ᨢ ascval
       dec si                 ; ��६�饭�� 㪠��⥫� ���ᨢ� �� 1 ���� �����
       jmp c20                ; ���室 �� ��砫� ��� �८�ࠧ������ ᫥�. ����
c30:   or al, 30h             ; �᫨ ���⮪ ����� 10, � �뢮� १���� �� ��࠭
       mov [si], al            ; ��ᯫ�� ��������� (�. ����)
       lea dx, ascval         ; ����㧪� ���� ���ᨢ�
       mov ah, 9              ; �맮� 9-�� �㭪樨 MS-DOS 
       int 21h
       ret                    ; ������ � �������� �ணࠬ�� �� �/�ணࠬ��
outp endp                     ; ����� ��楤���
end start