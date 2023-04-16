program Ejercicio8_Practica3;
const 
	valorAlto= 'zzz';
type 
	Distribucion = record
				   nom:string[20];
				   anoLan:integer;
				   NVK: integer;
				   CantD:integer;
				   descripcion: string[20];
				   end;
	archD= file of Distribucion; 

procedure leerD( var d: Distribucion);
begin 
	writeln('ingrese nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción ' );
	readln(d.nom);
	if( d.nom <> valorAlto) then begin
		readln(d.anoLan);
		readln(d.NVK);
		readln(d.cantD);
		readln(d.descripcion);
	end;
end;
	
procedure cargarD( var d:archD);
var
	da:Distribucion;
	t: text;
	
begin
	rewrite(d);
	Assign(t,'ArchivoDeDistribuciones.txt');
	rewrite(t);
	da.cantD:=0;
	write(d,da);
	leerD(da);
	while(da.nom<> valorAlto) do begin 
		write(d,da);
		writeln(t,  da.nom, da.anoLan, da.NVK, da.cantD, da.descripcion);
		leerD(da);
	end;
	close(t);
	close(d);
end;
procedure LeerDeArch(var a:archD; var dato: Distribucion);
begin 
	if( not eof(a))then
		read(a,dato)
	else
		dato.nom:= valorAlto;
end;
procedure ExisteDistribucion (var a:ArchD; var es:boolean; nom:string);
var
	d:Distribucion;
begin 
	reset(a);
	es:=false;
	LeerDeArch(a,d);
	while(d.nom<> valorAlto)and(not es) do begin
		if(d.nom= nom) then 
			es:= true;
		LeerDeArch(a,d);
	end;
	close(a);
end;
procedure BajaDistribucion(var a:ArchD);
var
	eliminar: string[20];
	existe:boolean;
	r0,d:Distribucion;
begin 
	writeln('ingrese nombre a eliminar');
	readln(eliminar);
	ExisteDistribucion(a,existe,eliminar);
	if( existe ) then begin 
		reset(a);
		LeerDeArch(a,d);
		r0:=d;
		while (d.nom <> eliminar)do 
			LeerDeArch(a,d);
		d.cantD:= FilePos(a) * -1;
		seek(a,FilePos(a) -1);
		write(a,r0);
		seek(a,0);
		write(a,d);
		close(a);
	end
	else
		writeln(' el elemento no esta en el archivo');
end;
	
	
	
	
	
procedure AltaDistribucion ( var a:archD);
var
	r0,nueD:Distribucion;
	existe:boolean;
begin
	leerD(nueD);
	ExisteDistribucion(a,existe,nueD.nom);
	if(not existe) then begin 
		reset(a);
		LeerDeArch(a,r0);
		if(r0.cantD = 0) then begin
			seek(a,FileSize(a)-1);
			write(a,nueD);
			end
		else begin
			seek(a, r0.cantD * -1);
			LeerDeArch(a,r0);
			seek(a,FilePos(a)-1);
			write(a,nueD);
			seek(a,0);
			write(a,r0);
		end;
		close(A);
	end
	else
		writeln('La distribucion ya existe');
	
end;



procedure imprimirOp2();
begin 
	writeln('.................................');
		writeln('Ingrese 1 para eliminar distribuciones logicamente');
		writeln('Ingrese 2 Para agregar una distribucion al archivo, aprovechando el espacio libre');;
		writeln('Ingrese 3 para dejar de trabajar con el archivo');
		writeln('.................................');
end;
procedure Op2(var a:ArchD);
var
	num: integer;
begin
		imprimirOp2();
		readln(num);
		while(num<3) do begin
			case num of
				1: BajaDistribucion(a);
				2: AltaDistribucion(a);
			end;
			imprimirOp2();
			readln(num);
		end;
		writeln('fin');
end;

procedure menu( var p:ArchD);
var
	num:integer;
begin 
	writeln(' --------------------------------------------');
	writeln(' Ingrese 1 Para crear un archivo');
	writeln(' Ingrese 2 para trabajar sobre un archivo');
	writeln(' Ingrese 3 para dejar de trabajar ');
	writeln(' --------------------------------------------');
	readln(num);
	while(num<=2) do begin
		case num of
			1: cargarD(p);
			2: Op2(p);
		end;
		writeln(' --------------------------------------------');
		writeln(' Ingrese 1 Para crear un archivo');
		writeln(' Ingrese 2 para trabajar sobre un archivo');
		writeln(' Ingrese 3 para dejar de trabajar ');
		writeln(' --------------------------------------------');
		readln(num);
	end;
end;


var
	a:archD;
	
begin
	Assign(a,'Distribuciones');
	Menu(a);
	
end.
