{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño}
program ej2P3;
const 
	corte= -1;
type
	Asistentes = record
				 numA:integer;
				 ape:string;
				 nom:string;
				 email:string;
				 telefono:LongInt;
				 DNI:LongInt;
				 end;
   archA= file of Asistentes;
   
procedure leerA(var a:Asistentes);
begin
	writeln('ingrese numero de asistente, apellido, nombre, email, telefono y DNI del asistente');
	readln(a.numA);
	if(a.numA <> corte) then begin
		readln(a.ape);
		readln(a.nom);
		readln(a.email);
		readln(a.telefono);
		readln(a.DNI);
	end;
end;

procedure cargarA(var a: archA);
var
	dato:Asistentes;
begin
	rewrite(a);
	
	leerA(dato);
	while(dato.numA <> corte) do begin
		write(a,dato);
		leerA(dato);
	end;
end;
procedure LeerDeArch(var a:archA; var dato:Asistentes);
begin
	if(not eof(a))then 
		read(a,dato)
	else
		dato.numA:= corte;
end;
procedure borradoLogico(var a:archA);
var
	dato:Asistentes;
begin
	reset(a);
	LeerDeArch(a,dato);
	while( dato.numA <> corte) do begin
		if(dato.numA < 1000) then begin
			dato.nom:= '***';
			seek(a,FilePos(a)-1);
			write(a,dato);
		end;
		LeerDeArch(a,dato);
	end;
	close(a);
end;
procedure Texto(var a:archA);
var
	t:text;
	d:Asistentes;
begin
	reset(A);
	Assign(t,'AsistentesText');
	rewrite(t);
	LeerDeArch(a,d);
	while(d.numA<>corte) do begin
		writeln(t, d.numA ,' ', d.nom , '  ', d.ape, ' ', d.email, ' ', d.telefono, ' ', d.DNI);
		LeerDeArch(a,d);
	end;
	close(a);
	close(t);
end;  
var
	a:archA;
begin
	Assign(a,'Asistentes');
	cargarA(a);
	borradoLogico(a);
	Texto(a);
end.



