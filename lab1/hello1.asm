   .model	small		;������ ����� ��
   .stack	16h			;ࠧ��� �⥪� �ணࠬ�
   .data				;�ணࠬ��� ᥣ���� ������
   Hello_msg	db	'�ணࠬ�� ��㤥�� ��� Akimova',13,,'$'
  .code				;�ணࠬ��� ᥣ���� ����
  start: mov	ax,@data	;�窠 �室� � �ணࠬ��
  mov	ds,ax			;����ன�� ᥣ���⭮�� ॣ���� ds
  mov	ah,9                    ;�㭪�� �뢮�� ��ப� �� �࠭
  lea	dx,hello_msg            ;����㧪� 㪠��⥫� ��६����� Hello_msg
  int	21H			;�뢮� ᮮ�饭�� �� �࠭
  mov	ah,4ch                  ;��室 � ����樮���� ��⥬�
  int	21h
  end	start                   ;����� �ணࠬ�
