Build:
	gcc -E src\main.c -o out.i
	gcc -S src\main.c -o out.asm
	gcc -c src\main.c -o out.obj
	gcc src\main.c -o out.exe
