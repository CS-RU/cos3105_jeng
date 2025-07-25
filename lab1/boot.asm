[org 7c00h]            ; BIOS will load us to this address
mov ax, 0b800h         ; Console memory is at 0xb8000
mov es, ax             ; Set ES segment to video memory

; Clear screen
xor di, di             ; Start at beginning of screen
mov cx, 80*25          ; Number of characters on screen
mov al, ' '            ; Space character
mov ah, 0fh            ; Color attribute (white on black)
repne stosw            ; Fill screen with spaces

; Write: 6504016665 COS3105
mov byte [es:0],  '6'
mov byte [es:1],  0Fh

mov byte [es:2],  '5'
mov byte [es:3],  0Fh

mov byte [es:4],  '0'
mov byte [es:5],  0Fh

mov byte [es:6],  '4'
mov byte [es:7],  0Fh

mov byte [es:8],  '0'
mov byte [es:9],  0Fh

mov byte [es:10], '1'
mov byte [es:11], 0Fh

mov byte [es:12], '6'
mov byte [es:13], 0Fh

mov byte [es:14], '6'
mov byte [es:15], 0Fh

mov byte [es:16], '6'
mov byte [es:17], 0Fh

mov byte [es:18], '5'
mov byte [es:19], 0Fh

mov byte [es:20], ' '
mov byte [es:21], 0Fh

mov byte [es:22], 'C'
mov byte [es:23], 0Fh

mov byte [es:24], 'O'
mov byte [es:25], 0Fh

mov byte [es:26], 'S'
mov byte [es:27], 0Fh

mov byte [es:28], '3'
mov byte [es:29], 0Fh

mov byte [es:30], '1'
mov byte [es:31], 0Fh

mov byte [es:32], '0'
mov byte [es:33], 0Fh

mov byte [es:34], '5'
mov byte [es:35], 0Fh

sleep:
hlt                    ; Halts CPU until the next external
                        ;interrupt is fired
jmp sleep              ; Loop forever

times 510-($-$$) db 0  ; Pad to 510 bytes
dw 0aa55h              ; Add boot magic word to mark us
                        ; as bootable
