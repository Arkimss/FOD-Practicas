program ej4_Practica3;
const
	valorAlto= 9999;
type
	reg_flor = record
		nombre: String[45];
		codigo:integer;
		end;
	
	tArchFlores = file of reg_flor;

procedure cargarA(var f: tArchFlores);
var
	d:reg_flor;
Begin
	rewrite(f);//creo el archivo de flores
	d.codigo:= 0; //asigno al tope de la pila 0 para indicar que no hay lugar libre disponible
	d.nombre:= 'unknow';// se le asigna un nombre al azar
	write(f,d);
	writeln('ingrese codigo y nombre de la flor');
	readln(d.codigo);
	readln(d.nombre);
	while(d.codigo<>valorAlto) do begin
		write(f,d);
		writeln('ingrese codigo y nombre de la flor');
		readln(d.codigo);
		readln(d.nombre);
	end;
	close(F);
end;
procedure LeerDeArch(var a:tArchFlores; var d: reg_flor);
begin
	if(not eof(a))then
		read(a,d)
	else
		d.codigo:=valorAlto;
end;

procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
	Nuevo:reg_flor;
	r0:reg_flor;
begin
	Nuevo.nombre:=nombre;// asigno a un registro de flores la nueva flor
	Nuevo.codigo:=codigo;
	reset(a);// abro el archivo de flores
	LeerDeArch(a,r0);// leo el primer elemento
	if(r0.codigo = 0) then begin// si el codigo del primer elemento del archivo es 0, significa que no hay espacios libres, entonces agrego la nueva flor al final del archivo
		seek(a,FileSize(a)-1);
		write(a,Nuevo);
	end
	else begin
		seek(a, r0.codigo*-1);// sino es 0, me posiciono en el espacio libre
		LeerDeArch(a,r0);//copio el registro que contiene el espacio libre en una variable
		seek(a,FilePos(a)-1);// pongo el nuevo dato en el espacio libre
		write(a,Nuevo);
		seek(a,0);// reemplazo la cabecera de la pila
		write(a,r0);
	end;
	close(a);
end;

procedure agregarFlores(var a: tArchFlores);
var
	nom:string;
	cod:integer;
begin
	writeln('ingrese codigo y nombre de la flor a agregar');
	readln(cod);
	readln(nom);
	agregarFlor(a,nom,cod);
end;


procedure Eliminar(var a: tArchFlores);
var
	num: integer;
	d,r0:reg_flor;
	ok:boolean;
begin	
	writeln('ingrese el codigo de flor a eliminar');
	readln(num);
	reset(a);
	ok:=true;
	LeerDeArch(a,d);
	r0:= d;
	while(d.codigo<> valorAlto) and(ok)do begin
		if(d.codigo= num) then begin // si encontramos el codigo
			d.codigo:= FilePos(a) * -1;// le asignamos al codigo actual la posicion del elemento en el registro, pero en negativo
			d.nombre:= '***'; // 
			seek(a,FilePos(a)-1);// escribo en la posicion a borrar la posicion del siguiente espacio libre.
			write(a,r0);
			seek(a,0);
			write(a,d);// escribo en el principio del archivo la posicion del nuevo espacio libre
			ok:=false;
		end;
		LeerDeArch(a,d);
	end;
	close(a);
end;
procedure ImprimirA(var a:tArchFlores);
var
	d:reg_flor;
	T:text;
begin
	reset(a);
	Assign(t,'Flores.txt');// esto lo hago por que si, no lo pide el ejercicio
	rewrite(T);
	LeerDeArch(a,d);
	while(d.codigo<>valorAlto) do begin
		if(d.nombre<>'***') then 
			writeln('El codigo de la flor es: ', d.codigo , ' Y su nombre es :', d.nombre);
		writeln (t,'El codigo de la flor es: ', d.codigo , ' Y su nombre es :', d.nombre);
		LeerDeArch(a,d);
	end;
	close(a);
	close(t);
end;
procedure imprimirOp2();
begin 
	writeln('.................................');
		writeln('Ingrese 1 para agregar una flor al archivo');
		writeln('Ingrese 2 Para imprimir todas las flores del archivo');
		writeln('Ingrese 3 para Eliminar una flor del archivo');
		writeln('Ingrese 4 para dejar de trabajar con el archivo');
		writeln('.................................');
end;
procedure Op2(var n:tArchFlores);
var
	num: integer;
begin
		imprimirOp2();
		readln(num);
		while(num<4) do begin
			case num of
				1: agregarFlores(n);
				2: ImprimirA(n);
				3: Eliminar(n);
			end;
			imprimirOp2();
			readln(num);
		end;
		writeln('fin');
end;
procedure menu( var n:tArchFlores);
var
	num:integer;
begin 
	writeln(' --------------------------------------------');
	writeln(' Ingrese 1 Para crear un archivo de flores');
	writeln(' Ingrese 2 para abrir el archivo de flores');
	writeln(' --------------------------------------------');
	readln(num);
	while(num<=2) do begin
		case num of
			1: cargarA(n);
			2: Op2(n);
		end;
		writeln(' --------------------------------------------');
		writeln(' Ingrese 1 Para crear un archivo de flores');
		writeln(' Ingrese 2 para abrir el archivo de flores');
		writeln(' Ingrese 3 para Finalizar el programa');
		writeln(' --------------------------------------------');
		readln(num);
	end;
end;


var
	a:tArchFlores;
begin
	Assign(a,'Archflores');
	menu(a);
end.
