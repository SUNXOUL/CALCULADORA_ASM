;------------------------------------------------------------------------------
; Directivas de Preprocesamiento
.model small
.stack 100h
.data

;------------------------------------------------------------------------------
; Declaración de cadenas y variables
msg_Menu db 10, 13, 'Menu', 10, 13, '$'
msg_Suma db '   1. Suma $'
msg_Resta db 10,13,'   2. Resta $'
msg_Multiplicacion db 10,13,'   3. Multiplicacion $'
msg_Division db 10,13,'   4. Division $'
msg_Salir db 10,13,'   5. Salir $'
msg_Opcion db 10,13,'   Seleccione: $'
msg_PrimerNumero db 10,13,10,13,'Ingrese el primer numero: $'
msg_SegundoNumero db 10,13,'Ingrese el segundo numero: $'
msg_Resultado db 10,13,10,13,'El resultado es: $'
msg_Cerrar db 10,13,10,13,'Finalizado $' 
msg_Continuar db 10,13,10,13,'Presione ENTER para continuar $'

num1 db ?
num2 db ?
resultado db ? 
seleccion  db ?

;------------------------------------------------------------------------------
; Carga de la direccion de la base
.code
mov ax, @data
mov ds, ax

;------------------------------------------------------------------------------
; Etiqueta para el menu
menu:
    ; Imprimir el menu
    lea dx, msg_Menu
    mov ah, 9
    int 21h

    ; Imprimir opciones
    lea dx, msg_Suma
    mov ah, 9
    int 21h

    lea dx, msg_Resta 
    mov ah, 9
    int 21h

    lea dx, msg_Multiplicacion
    mov ah, 9
    int 21h

    lea dx, msg_Division 
    mov ah, 9
    int 21h

    lea dx, msg_Salir 
    mov ah, 9
    int 21h

    ; Solicitar seleccion al usuario
    lea dx, msg_Opcion 
    mov ah, 9
    int 21h

    ; Leer la seleccion del usuario
    mov ah, 1
    int 21h
    sub al, 48
    mov seleccion, al

;------------------------------------------------------------------------------
; Switch (simulado "FALSO XD")
cmp seleccion, 1
je Op_Suma

cmp seleccion, 2
je Op_Resta

cmp seleccion, 3
je Op_Multiplicacion

cmp seleccion, 4
je Op_Division

cmp seleccion, 5
je exit_p

;------------------------------------------------------------------------------
; Funcion de Suma
Op_Suma:
    ; Entrada del primer numero
    lea dx, msg_PrimerNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num1, al

    ; Entrada del segundo numero
    lea dx, msg_SegundoNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h 
    sub al, 48
    mov num2, al

    ; Realizar la suma
    add al, num1
    mov ah, 0
    aaa

    ; Ajustar y convertir a caracteres   \ bh representa el valor mas significativo de el bx y bl el menos significativo
    mov bx, ax
    add bh, 48
    add bl, 48 
    add num1, 48
    add num2, 48

    ; Imprimir el texto del resultado
    lea dx, msg_Resultado 
    mov ah, 9
    int 21h

    
    mov ah, 2  
    mov dl, num1
    int 21h 
    
    mov ah, 2  
    mov dl, '+'
    int 21h
    
    mov ah, 2  
    mov dl, num2
    int 21h 
    
    mov ah, 2  
    mov dl, '='
    int 21h 
    
    ;Resultado final
    mov ah, 2
    mov dl, bh
    int 21h 
    
    mov ah, 2
    mov dl, bl
    int 21h  
    
    jmp regresar

;------------------------------------------------------------------------------
; Funcion de Resta
Op_Resta:   
    
    ; Entrada del primer numero
    lea dx, msg_PrimerNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num1, al

    ; Entrada del segundo numero
    lea dx, msg_SegundoNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h 
    sub al, 48
    mov num2, al

    ; Realizar la resta
    mov al,num1
    sub al,num2
    
    ; Ajustar y convertir a caracteres   \ bh representa el valor mas significativo de el bx y bl el menos significativo
    mov bx, ax
    add bh, 48
    add bl, 48 
    
    ; Imprimir el resultado
    lea dx, msg_Resultado
    mov ah, 9
    int 21h

    ;Resultado final
    mov ah, 2
    mov dl, bh
    int 21h 
    
    mov ah, 2
    mov dl, bl
    int 21h

    jmp regresar

;------------------------------------------------------------------------------
; Función de Multiplicación
Op_Multiplicacion:
    ; Entrada de datos
    lea dx, msg_PrimerNumero
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num1, al

    lea dx, msg_SegundoNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num2, al

    ; Operacion de multiplicacion
    mul num1
    mov resultado, al
    aam

    ; Ajustar y convertir a caracteres
    add ah, 48
    add al, 48
    mov bx, ax

    ; Imprimir el resultado
    lea dx, msg_Resultado 
    mov ah, 9
    int 21h

    ; Imprimir el resultado en dos partes
    mov ah, 2
    mov dl, bh
    int 21h

    mov ah, 2
    mov dl, bl
    int 21h

    jmp regresar

;------------------------------------------------------------------------------
; Funcion de Division
Op_Division:
    ; Entrada del primer numero
    lea dx, msg_PrimerNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num1, al

    ; Entrada del segundo numero
    lea dx, msg_SegundoNumero 
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov num2, al

    ; Realizar la division
    mov cl, num1
    mov ax, cx
    div num2
    mov resultado, al
    mov ah, 00
    aad

    ; Ajustar y convertir a caracteres
    add ah, 48
    add al, 48
    mov bx, ax

    ; Imprimir el resultado
    lea dx, msg_Resultado 
    mov ah, 9
    int 21h

    ; Imprimir el resultado en dos partes
    mov ah, 2
    mov dl, bh
    int 21h

    mov ah, 2
    mov dl, bl
    int 21h
    jmp regresar
;------------------------------------------------------------------------------
; Funcion de Salida
exit_p:
    ; Imprimir mensaje de cierre
    lea dx, msg_Cerrar
    mov ah, 9
    int 21h

    ; Salir del programa
    exit:
    mov ah, 4ch
    int 21h  
    
regresar:
    ;Imprimir mensaje de continuacion
    lea dx, msg_Continuar 
    mov ah, 9    
    int 21h  
    
    ;Espera de caracter para continuar
    mov ah, 1
    int 21h
    sub al, 48

    ; Volver al menu
    jmp menu
