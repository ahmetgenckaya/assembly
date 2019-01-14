	__CONFIG H'3F31'
	LIST P=16F877A
	#INCLUDE <P16F877A.INC>
	SAYI1 EQU 0X20
	SAYI2 EQU 0X21
	TOPLAM EQU 0X22
	FARK EQU 0X23
	ORG 0X00
	GOTO ANA_METOT

ANA_METOT
	BANKSEL TRISB
	CLRF TRISB
	BANKSEL PORTB
	CLRF PORTB

	MOVLW B'10010110'			;D'150'
	MOVWF SAYI1

	MOVLW B'11010010'			;D'210'
	MOVWF SAYI2

	;SAYI2 > SAYI1

	BCF STATUS,C

	CLRW
	MOVF SAYI2,W
;	ADDWF SAYI2,W			;W = SAYI2 + SAYI1
;	MOVWF TOPLAM

	SUBWF SAYI1,W			;W = SAYI2 - SAYI1   -   W = SAYI1 - SAYI2
	MOVWF FARK
	
KONTROL
	BTFSS STATUS,C
	GOTO TASMA_NEGATIF		;C B�T� 0 �SE TA�MA YOKTUR.
	GOTO TASMA_POZITIF		;C B�T� 1 �SE TA�MA VARDIR.

TASMA_POZITIF
	BSF PORTB,0
	GOTO KONTROL			;'GOTO KONTROL' SATIRININ YAZILMADI�I DURUMLARDA ��LEM GER�EKLE�MEZ. HER �K� LED B�RL�KTE YANAR.

TASMA_NEGATIF
	BSF PORTB,1
	GOTO KONTROL

END