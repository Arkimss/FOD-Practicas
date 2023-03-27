//se necesita un archivo de texto en el que esten cargados celulares(codigo, el nombre, su descripcion, la marca, el precio, su stock minimo y su stock disponible)
//a partir del archivo anterior hay que crear un archivo de registros que contenga todos los datos del archivo de texto
TYPE

	celular= record
			 codigoDCelular: integer;
			 nom: string[20];
			 descripcion: string[20];
			 marca: string[20];
			 precio: real;
			 stockMin: integer;
			 stockD: integer;
			 end;
	cel= file of celular;
procedure LeerCelular(var c:celular);
begin
	writeln('íngrese codigo de celular, nombre, descripcion, marca, precio stock minimo y stock disponible');
	with c do begin
		readln(codigoDcelular);
		if(codigoDcelular<> -1) then begin
			readln(nom);
			readln(descripcion);
			readln(marca);
			readln(precio);
			readln(stockMin);
			readln(stockD);
		end;
	end;
end; 

{procedure creacionArchTexto(var arch_text: Text);
var
	c:celular;
begin
	rewrite(arch_text);
	LeerCelular(c);
	while(c.CodigoDCelular<>-1) do begin
		with c do begin
		writeln(arch_text,				
				'Codigo: ',codigoDCelular,
				' precio: ',precio:2:2,
				' marca: ',marca);
		writeln(arch_text,				
				'Stock disp: ', stockD,
				' stock minimo: ', stockMin,
				'descripcion: ', descripcion);
		writeln(arch_text,				
				'Nombre: ', nom);
		LeerCelular(c);
		end;
	end; 
	close(arch_text);
end;}
procedure TextABin(var arch_text: Text; var arch_cel: cel);
var
	c:celular;
begin
	
	reset(arch_text);
	rewrite(arch_cel);
	
	while(not EOF(arch_text)) do begin
		with c do begin
			readln(arch_text, CodigoDCelular,precio,marca);
			readln(arch_text, stockD,stockMin,descripcion);
			readln(arch_text, nom);
		end;
		//imprimirCel(c);
		write(arch_cel, c);
		writeln('SIUUUUUUUUUUUU0');	
	end;
	close(arch_cel);
	close(arch_text);
	writeln('SIUUUUUUUUUUUU0');
end;

procedure imprimirCel(c:celular);
begin
	with c do begin 
		writeln('CodigoDCelular ', CodigoDCelular);
		writeln('precio ', precio);
		writeln('marca ', marca);
		writeln('stockD ',stockD);
		writeln('stockMin ',stockMin);
		writeln('descripcion ',descripcion); 
		writeln(' nombre ' ,nom);
	end;
end;
		
procedure ImprimirOpciones();
begin
		Writeln('Opcion 1: Crear un archivo binario a partir de un archivo de texto');
		writeln('Opcion 2: Listar Celulares que tienen un stock menor al minimo');
		writeln('Opcion 3: Listar Celulares cuya descripcion tenga una cadena de caracteres ingresada por el usuario');
		writeln('Opcion 4: Exportar el Archivo binario a un archivo de texto');
		writeln('Opcion 5: Finalizar el Programa');
end;
	
procedure ListarMinStock( var arch_cel: cel);
var
	c:celular;
begin
	reset(arch_cel);
	while(not eof(arch_cel)) do begin 
		read(arch_cel, c);
		if(c.stockD < c.stockMin) then 
			imprimirCel(c);
	end;
	close(arch_cel);
end;	

procedure ListarDescripcion(var arch_cel: cel);
var
	c:celular;
	des: string[20];
	
begin
	reset(arch_cel);
	writeln(' ingrese descripcion a buscar');
	readln(des);
	while(not eof(arch_cel)) do begin 
		read(arch_cel, c);
		if(Pos(des, c.descripcion)= 1) then 
			imprimirCel(c);
	end;
	close(arch_cel);
end;
{procedure CrearArhivoDeTexto(var arch_text: Text);
var	
	c:celular;
begin
	
	rewrite(arch_text);
	LeerCelular(c);
	while(c.nom <> 'fin') do begin 
		with c do begin
		writeln(arch_text, CodigoDCelular, precio, marca);
		writeln(arch_text, stockD, stockMin, descripcion);
		writeln(arch_text, nom);
		LeerCelular(c);
		end;
	end;
	close(arch_text);
end;}
procedure BinAText( var arch_cel: cel);
var
	c:celular;
	arch_text:text;
begin 
	reset(arch_cel);
	assign(arch_text, 'celulares.txt');
	rewrite(arch_text);
	while( not EOF(arch_cel)) do begin 
		with c do begin
			Read(arch_cel, c);
			writeln(arch_text, CodigoDCelular, precio, marca);
			writeln(arch_text, stockD, stockMin, descripcion);
			writeln(arch_text, nom);
		end;
	end; 
	close(arch_text);
	close(arch_cel);
end;
procedure AgregarCel( var arch_cel: cel);
var
	c: celular;
begin
	reset(arch_cel);
	seek( arch_cel, FileSize(arch_cel));
		LeerCelular(c);
	while(c.nom <> 'fin')do begin 
		LeerCelular(c);
		write(arch_cel,c);
		end;
	close(arch_cel);
end;
procedure ModStock(var arch_cel: cel);
var
	c:celular;
	nom:string;
	ok: boolean; 
begin 
	reset(arch_cel);
	ok:= true;
	writeln( ' ingrese nombre del celular a modificar stock');
	readln(nom);
	while(nom<> 'fin') do begin 
		while((not eof(arch_cel)) and(ok)) do begin
			read(arch_cel, c);
			if(c.nom = nom) then begin
				writeln( ' ingrese el stock disponible del celular');
				readln(c.stockD);
				seek(arch_cel, FilePos(arch_cel) - 1);
				write(arch_cel, c);
				ok:= false; 
			end;
		seek(arch_cel, 0);
		end;
		writeln('ingrese el nombre del celular');
		readln(nom);
end;
	close(arch_cel);
end;
			
		
procedure EjecutarOpcion( var arch_text: text;var arch_cel: cel; num: integer);
	begin
		Case num of
		1: TextABin(arch_text, arch_cel);
		2: ListarMinStock(arch_cel);
		3: ListarDescripcion(arch_cel);
		4: BinAText(arch_cel);
		5: AgregarCel(arch_cel);
		6: ModStock(arch_cel);
		//7:
		end;
	end;
procedure menu ( var arch_text: text;var arch_cel: cel);
var
	 num: integer;
begin
	writeln('Elija una opcion');
	ImprimirOpciones();
	Readln(num);
	while(num<> 8) do begin
	EjecutarOpcion( arch_text, arch_cel,num);
	writeln('Elija una opcion');
	ImprimirOpciones();
	Readln(num);
	end;
end;
var
	arch_text: Text;
	arch_cel: cel; 
	nom:string;
begin 	
	writeln('ingrese Nombre del archivo binario');
	readln(nom);
	assign(arch_cel, nom);
	assign(arch_text, 'celulares.txt');
	menu(arch_text,arch_cel);
end.
	
