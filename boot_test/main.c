

void kprintf(char* str, int line){
	char *video = (char*)(0xB8000 + 160 * line);

	for (int i = 0; str[i] != 0; i++){
		*video++ = str[i];
		*video++ = 0x03;
	}
	return;
}

void main(){
	kprintf("Use function in C!", 10);
}
