#include <stdio.h>
int main(){
	asm {
		  mov ah, 0x2     // ใช้ function 2 ส่งอักขระไปยังจอภาพ
		  mov dl, "6504016665 COS3105"        // ส่งตัวอักษร ‘a’ ไปจอภาพ
		  int 21h
	}
   return 0;
}