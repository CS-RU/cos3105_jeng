[org 7c00h]            ; BIOS will load us to this address

mov ax, 0b800h         ; Console memory is at 0xb8000
mov es, ax             ; Set ES segment to video memory

; Clear screen
xor di, di             ; Start at beginning of screen
mov cx, 80*25          ; Number of characters on screen
mov al, ' '            ; Space character
mov ah, 0fh            ; Color attribute (white on black)
repne stosw            ; Fill screen with spaces

; Animation loop
animation_loop:
    ; Get current time for color cycling
    mov ah, 0           ; Get system time
    int 1ah             ; BIOS time interrupt
    mov al, dl          ; Use lower byte of time for color variation
    
    ; Cycle through rainbow colors with blinking
    and al, 0fh         ; Keep only lower 4 bits for color
    or al, 80h          ; Add blinking bit
    mov bl, al          ; Store color in BL
    
    ; Write: 6504016665 COS3105 with rainbow colors
    mov byte [es:0],  '6'
    mov byte [es:1],  bl
    
    inc bl
    and bl, 8fh         ; Keep blinking, cycle colors
    mov byte [es:2],  '5'
    mov byte [es:3],  bl
    
    inc bl
    and bl, 8fh
    mov byte [es:4],  '0'
    mov byte [es:5],  bl
    
    inc bl
    and bl, 8fh
    mov byte [es:6],  '4'
    mov byte [es:7],  bl
    
    inc bl
    and bl, 8fh
    mov byte [es:8],  '0'
    mov byte [es:9],  bl
    
    inc bl
    and bl, 8fh
    mov byte [es:10], '1'
    mov byte [es:11], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:12], '6'
    mov byte [es:13], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:14], '6'
    mov byte [es:15], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:16], '6'
    mov byte [es:17], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:18], '5'
    mov byte [es:19], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:20], ' '
    mov byte [es:21], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:22], 'C'
    mov byte [es:23], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:24], 'O'
    mov byte [es:25], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:26], 'S'
    mov byte [es:27], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:28], '3'
    mov byte [es:29], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:30], '1'
    mov byte [es:31], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:32], '0'
    mov byte [es:33], bl
    
    inc bl
    and bl, 8fh
    mov byte [es:34], '5'
    mov byte [es:35], bl
    
    ; Small delay
    mov cx, 0ffffh
delay_loop:
    nop
    loop delay_loop
    
    jmp animation_loop

; Padding to 512-byte boot sector
times 510-($-$$) db 0
dw 0aa55h