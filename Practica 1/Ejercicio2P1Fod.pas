program ejercicio2P1FOD;
type
	numero = file of integer;
	
var
	arch_num: numero;
	nom: string[20];
	cont: integer;
	i,c: integer;
	//prom: real;
begin
	writeln('ingrese nombre del archivo a abrir');
	readln(nom);
	Assign(arch_num, nom);
	reset(arch_num);
	cont:=0;// cuenta la cantidad de numeros menores a 1500
	c:=0;// suma todos los numeros del archivo
	while(not EOF(arch_num)) do begin
	read(arch_num, i);//lee desde el archivo un dato y lo deja en la variable i
	writeln(i);
	c:= c + i;
	if(i < 1500) then 
		cont:= cont + 1;
	end;
	//prom:= 
	writeln('el promedio de numeros es de ' , c/fileSize(arch_num):3:3);
	writeln('la cantidad  de numeros menores a 1500 es de : ', cont);
	close(arch_num);
end.	
