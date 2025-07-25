#include <stdio.h>
#include <dos.h>
#include <bios.h>
#include <conio.h>
void far interrupt (*oldint_8h)(void);
void far interrupt timer_hook(void);
int m=0;
int t=0;
int active=0;
char far* vga = (char far*)0xB8000000; // แสดงผลออกการ์ดจอ
void far interrupt timer_hook(void){
  int i;
  if(active==1){
  (*oldint_8h)();
  return;
  }
  t++;
  m++;
  if(t>10){
  active = 1;
  t = 0;
  for(i=0;i<200;i+=2){
    *(vga + i) = m%2==0? 'A' : 'B';
    *(vga + i + 1) = 0x7;
  }
  active=0;
  }
  (*oldint_8h)();
}
int main(void){
  int ch;
  asm {
   mov ax, 0x3;
   int 10h
  }
  oldint_8h = getvect(0x8);
  setvect(0x8, timer_hook);
  while(ch!='z'){
    ch = getch();
    putch(ch);
  }
  setvect(0x8, oldint_8h);
  asm{
  mov ah,0
  mov al,3
  int 10h
  }
  return 0;
}