program ej7;
const
	valoralto = 9999;
	marca='***';
type
	ave = record
		cod: integer;
		especie: string[20];
		familia: string[20];
		descripcion: string[20];
		zonaG: string[30];
	end;
	archA = file of ave;


procedure leerA( var a:ave); 
begin
	writeln(' Ingrese codigo, nombre de la especie, familia de ave, descripcion y zona geografica');
	readln(a.cod);
	if(a.cod <> valorAlto) then begin
	readln(a.especie);
	readln(a.familia);
	readln(a.descripcion);
	readln(a.zonaG);
	end;
end;

procedure crearArchivo(var a:archA; var t:text);
var d: ave;
begin
	{reset(t); //abro}
	
	assign(t,'textoDeAves.txt');
	rewrite(t);
	rewrite(a); //creo
	leerA(d);
	while (d.cod<> valorAlto) do begin
		write(a,d);
		writeln( t,'cod: ', d.cod ,'  especie: ', d.especie , '  familia: ' ,d.familia, '  descripcion: ', d.descripcion,'  ZonaG: ' , d.zonaG);
		leerA(d);
	end;
	close(a);
		{with aux do begin
			readln(t, cod, especie);
			readln(t, familia);
			readln(t, descripcion);
			readln(t, zonaG);
		end;
		write(a, aux); //los guardo en el archivo binario
	end;
	close(t);
	close(a);
	writeln('Archivo maestro cargado');}
end;

procedure LeerDeArch(var a:archA; var dato: ave);
begin
	if not eof(a) then read(a, dato)
	else dato.cod := valoralto;
end;
procedure EliminarLog(var a:archA);
var
	d: integer;
	dato:ave;
begin
	reset(a);
	LeerDeArch(a,dato);
	writeln('ingrese codigo de la especie a eliminar');
	readln(d);
	while(d <> 500) do begin
		while(dato.cod <> valorAlto) and (dato.cod <> d) do
			LeerDeArch(a,dato);
		if(dato.cod= d) then begin
			dato.especie:= marca;
			seek(a,FilePos(a)-1);
			write(a,dato);
		end
		else
			writeln('el codigo no se encuentra en el archivo');
		seek(a,0);
		writeln('ingrese codigo de la especie a eliminar');
		readln(d);
	end;
	close(a);
end;
procedure EliminarFisico(var a:archA);
var
	d:ave;
	pos,cont:integer;
begin
	reset(a);
	LeerDeArch(a,d);
	cont:= 2;
	while(d.cod<>valorAlto)  do begin
		if(d.especie = marca) then begin 
			pos:= FilePos(a)-1;// me guardo la posicion en la que hay espacio
			seek(a,FileSize(a)-1);// obtengo el elemento en la ultima posicion del archivo
			LeerDeArch(a,d);
			seek(a,pos);// pongo el ultimo elemento del archivo en un espacio libre
			write(a,d);
			cont-=1;
			seek(a,Filesize(a)-1);// pongo el EOF sobre el ultimo elemento del archivo
			truncate(a);
			//reset(a);// me posiciono de nuevo al principio del archivo en busca de espacios libres.
			write( cont );
			seek(a,0);
		end;
		LeerDeArch(a,d);
	end;
end;
procedure te(var a: archA);
var t:text;
d:ave;
begin
	Assign(t,'ArchConEliminados.txt');
	rewrite(t);
	reset(a);
	LeerDeArch(a,d);
	while(d.cod<> valorAlto) do begin
		writeln(t,'| cod: ', d.cod, '| |especie: ', d.especie, '|  |familia ', d.familia, ' |');
		writeln(t, ' |descripcion: ', d.descripcion, '| |ZonaG ' , d.zonaG , ' |');
		LeerDeArch(a,d);
	end;
	close(A);
	close(t);
end;
 
procedure imprimirOp2();
begin 
	writeln('.................................');
		writeln('Ingrese 1 para eliminar elementos logicamente del archivo ');
		writeln('Ingrese 2 Para Eliminar Fisicamente los elementos borrados logicamente');;
		writeln('Ingrese 3 para dejar de trabajar con el archivo');
		writeln('.................................');
end;

procedure Op2(var a:ArchA);
var
	num: integer;
begin
		imprimirOp2();
		readln(num);
		while(num<3) do begin
			case num of
				1: EliminarLog(a);
				2: EliminarFisico(a);
			end;
			imprimirOp2();
			readln(num);
		end;
		writeln('fin');
end;

procedure menu( var a:ArchA; var t: text);
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
			1: crearArchivo(a,t);
			2: Op2(a);
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
	a: archA;
	t:text;
begin 
	Assign(t,'infoAves.txt');
	Assign(a,'ArchAves');
	menu(a,t);
	te(a);
end.
