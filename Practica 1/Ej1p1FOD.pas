program ejercicio1_PracticaFOD;
type
	numero = file of integer;
var
	arch_num: numero;
	num: integer;
begin
	Assign(arch_num, 'Av');
	rewrite( arch_num);
	writeln( ' ingrese un numero');
	readln( num);
	while( num<> 30000) do begin	
		write( arch_num, num);
		writeln( ' ingrese un numero');
		readln( num);
		end; 
	writeln(filesize(arch_num));
	close( arch_num);
end.

