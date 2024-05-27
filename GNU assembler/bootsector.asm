.code16
.global init

init:
	mov $msg, %si
	mov $0xe, %ah

print_char:
	lodsb
	cmp $0, %al
	je done
	int $ox10
	jmp print_char

done:
	hlt

msg:
	.asciz "Hallo Welt"
	
.fill 510-(.-init), 1, 0

.word 0xaa55
