program ej6P3;
const 
	valorAlto= 999 ; 
type
	prenda= record 
			cod_prenda: integer;
			descripcion:string [20];
			colores: string[20];
			tipo_prenda: string[20];
			stock : integer; 
			precio_unitario: double;
			end;
	archPO= file of integer; // archivo de prendas obsoletas, contiene codigos de prendas
	archP= file of prenda; 
	
procedure  leerP( var p: prenda); 
begin 
	writeln('Ingrese cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario ');
	readln(p.cod_prenda); 
	if(p.cod_prenda<> valorAlto) then begin
	readln(p.descripcion);
	readln(p.colores);
	readln(p.tipo_prenda);
	readln(p.stock);
	readln(p.precio_unitario);
	end; 
end; 

procedure cargarOP( var a: archPO);
var
	num:integer;
begin
	rewrite(a);
	writeln('Ingrese el codigo de prenda que quedara obsoleta');
	readln(num);
	while( num <> valorAlto) do begin 
		write(a,num);
		writeln('Ingrese el codigo de prenda que quedara obsoleta');
		readln(num);
	end;
	close(a);
end;
procedure cargarP( var P: archP);
var
	d:prenda;
	t:text;
begin
	rewrite(p);
	Assign(t,'TextoDeArchPrendas');
	rewrite(t);
	d.stock:= 0;
	write(P,d);
	leerP(d);
	while(d.cod_prenda<>valorAlto) do begin 
		write(p,d);
		writeln(t,' |cod_prenda ', d.cod_prenda, '|  |Descripcion: ' ,d.descripcion,  '|  |Colores: ', d.colores, '|   |Tipo de Prenda: ', d.tipo_prenda, '|  |Stock: ',d.stock, '| Precio Unitario: ', d.precio_unitario:3:3, ' | ');
		leerP(d);
	end;
	close(p);
	close(t);
end; 
procedure LeerDeArchP(var p: archP ; var d: prenda);
begin 
	if(not eof(p)) then 
		read(p,d)
	else
		d.cod_prenda:=valorAlto; 
end; 
procedure LeerDeArchPO(var p: archPO ; var d: integer);
begin 
	if(not eof(p)) then 
		read(p,d)
	else
		d:=valorAlto; 
end;
procedure EliminarLog( var p: archP; var a: archPO); 
var
	d,r0: prenda;
	dPO:integer;
begin 
	reset(p);// ABRO LOS ARCHIVOS
	reset(a);
	LeerDeArchP(p,d);
	r0:= d;// guardo el primer elemento de la pila de espacios disponibles
	LeerDeArchPO(a,dPo);
	while(dPO<> valorAlto) do begin // se recorre hasta que se terminen los elementos de prendas obsoletas
		while(d.cod_prenda<> valorAlto) and (dPo<> d.cod_prenda)do  // se recorre el archivo de prendas hasta encontrar el codigo del archivo PO
			LeerDeArchP(p,d);
		if(dPo= d.cod_prenda)then begin  // si encuentro el codigo me posiciono sobre el elemento
			d.stock:= FilePos(p) * -1;
			seek(p,FilePos(p)-1);
			d.descripcion:= '***';
			write(p,r0);// escribo el ultimo elemento de la pila en el nuevo espacio disponible
			seek(p,0);
			write(p,d);// escribo el elemento borrado al tope de la pila, para indicar que el espacio se puede ocupar.
		end;
		seek(p,0);
		LeerDeArchPO(a,dPO);
	end;
	close(a);
	close(p);
end;

procedure EliminarFisico(var p: archP; var nueP: archP);
var
	d:prenda;
	t:text;
begin
	reset(p);
	Assign(t,'NuevoArchivoDePrendasText.txt');	// creo un nuevo archivo para almacenar los elementos que no fueron borrados logicamente en el archivo anterior
	rewrite(t);
	Assign(nueP,'NuevoArchivoDePrendas');
	rewrite(nueP);
	LeerDeArchP(p,d);
	while(d.cod_prenda<>valorAlto) do begin
		if(d.stock>0) then begin // si no tiene stock negativo ( si no es un elemento que fue borrado), se agrega al nuevo archivo
			write(nueP,d);
			writeln(t,' |cod_prenda ', d.cod_prenda, '|  |Descripcion: ' ,d.descripcion,  '|  |Colores: ', d.colores, '|   |Tipo de Prenda: ', d.tipo_prenda, '|  |Stock: ',d.stock, '| Precio Unitario: ', d.precio_unitario:3:3, ' | ');
		end;
		LeerDeArchP(p,d);
	end;
	close(t);
	close(nueP);
	close(p);
end;
procedure CargarA(var p:archP; var PO: archPO);
var
	num: integer;
begin 
	writeln(' --------------------------------------------');
	writeln(' Ingrese 1 Para crear un archivo de prendas');
	writeln(' Ingrese 2 para crear un archivo con el codigo de prendas obsoletas');
	writeln(' --------------------------------------------');
	readln(num);
	case num of
	1: cargarP(p);
	2: cargarOP(PO);
	end;
end;
procedure imprimirOp2();
begin 
	writeln('.................................');
		writeln('Ingrese 1 para eliminar los elementos obsoletos del archivo de prendas');
		writeln('Ingrese 2 Para Eliminar Fisicamente los elementos borrados logicamente');;
		writeln('Ingrese 3 para dejar de trabajar con el archivo');
		writeln('.................................');
end;

procedure Op2(var p:ArchP; var nueP: archP; var PO: archPO);
var
	num: integer;
begin
		imprimirOp2();
		readln(num);
		while(num<3) do begin
			case num of
				1: EliminarLog(p,PO);
				2: EliminarFisico(p,nueP);
			end;
			imprimirOp2();
			readln(num);
		end;
		writeln('fin');
end;

procedure menu( var p:ArchP; var nueP: archP; var PO: archPO);
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
			1: cargarA(p,PO);
			2: Op2(p,nueP,PO);
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
	P,nueP:archP;
	PO: archPO;
begin
	Assign(p,' ArchivoDePrendas');
	Assign(PO,'ArchivoDePrendasObsoletas');
	menu(p,nueP,PO);
end.

