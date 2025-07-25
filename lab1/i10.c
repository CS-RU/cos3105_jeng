#include <stdio.h>
int main(){
  asm {
    mov ah,0x9      //ฟังก์ชั่น 9 พิมพ์ตัวอักษร
    mov al,'b'       // ตัวอักษร b
    mov bh,0x0       //
    mov bl,0xcc      // สีของตัวอักษร
    mov cx,10        //จำนวนตัวอักษร
    int 10h
  }
  return 0;
}