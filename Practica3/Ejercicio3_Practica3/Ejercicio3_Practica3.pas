program ej3_Practica3;
{Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.}
const
	corte = -1;
	valorAlto= 9999;
type
	novela= record
			cod:integer;
			genero:string;
			nom:string;
			duracion:string;
			director:string;
			precio:double;
			end;
	archN= file of novela;

procedure leerN(var n:novela);
begin
	writeln('ingrese código, género, nombre, duración, director y precio');
	readln(n.cod);
	if(n.cod <> valorAlto) then begin
	readln(n.genero);
	readln(n.nom);
	readln(n.duracion);
	readln(n.director);
	readln(n.precio);
	end;
end;
procedure leerDeN(var n:archN; var dato: novela);
begin
	if(not eof(n)) then
		read(n,dato)
	else
		dato.cod:= valorAlto;
end;
procedure cargarN(var N:archN);
var
	d:novela;
begin
	rewrite(N);
	d.cod := 0;
	write(N,d);
	leerN(d);
	while(d.cod <> valorAlto) do begin
		write(N,d);
		leerN(d);
	end;
	close(N);
end;

procedure darAlta ( var n:archN);
var
	d,nueN:novela;
begin
	reset(n);
	writeln('Ingrese una nueva novela para agregar al archivo ' );
	leerN(nueN);
	leerDeN(n,d);
	if(d.cod < 0) then begin
		seek(n, d.cod* -1);
		leerDeN(n, d);
		seek(n,FilePos(n) -1);
		write(n,nueN);
		seek(n,0);
		write(n, d);
	end
	else begin
		seek(n,FileSize(n)-1);
		write(n,nueN);
	end;
	close(n);
end;
		
procedure modificarNovela (var n: archN);
var 
	num:integer;
	d:novela;
	ok: boolean;
begin
	ok:=true;
	writeln(' ingrese el codigo de la novela a modificar ');
	readln( num);
	reset(n);
	leerDeN(n,d);
	while(d.cod<> valorAlto) and(ok) do begin 
		if(d.cod = num) then begin 
			writeln(' ingrese los nuevos datos de la novela');
			writeln('ingrese género, nombre, duración, director y precio');
			readln(d.genero);
			readln(d.nom);
			readln(d.duracion);
			readln(d.director);
			readln(d.precio);
			seek(n,FilePos(n) -1);
			write(n,d);
			ok:=false;
		end;
		leerDeN(n,d);
	end;
	if(ok) then
		writeln(' El codigo de novela no se encuentra en el archivo');
end;

procedure eliminar(var n:archN);
var
	num: integer;
	ok:boolean;
	d,r0:novela;
begin 	
	writeln('Ingrese codigo de novela a eliminar');
	readln(num);// leemos el cod de la novela a eliminar
	ok:=true;
	reset(n);//abro el archivo de novelas 
	leerDeN(n,d);// leo el primer elemento del archivo(el registro ficticio en el que se encuentra la posicion del primer elemento borrado)
	r0:= d;// le asigno a una variable el dato obtenido.
	while(d.cod<>valorAlto) and (ok)do begin
		if(d.cod = num) then begin// si el codigo leido es igual al buscado
			seek(n,FilePos(n)-1);// me posiciono en el lugar del dato buscado
			d.cod:=(filePos(n)) * -1;// vuelvo negativo su codigo
			write(n,r0);//le escribo la cabecera que se encontraba en el registro 0, en este registro va a quedar la posicion de otro registro eliminado
			seek(n,0);//voy a la primera posicion del archivo
			write(n,d);// escribo en la cabecera la posicion del ultimo dato eliminado
			ok:=false;
		end;
		leerDeN(n,d);
	end;
	if(ok)then 
		writeln('El elemento no se encuentra en el archivo');
	close(n);
end;

procedure Texto ( var n:ArchN);
var
	t:text;
	d:novela;
begin
	Assign(t,'novelas.txt');
	rewrite(t);
	reset(n);
	leerDeN(n,d);
	while(d.cod<>valorAlto) do begin
		writeln(t, ' ||cod: ', d.cod, '|| ||genero: ', d.genero, '|| ||Nom: ', d.nom, '|| ||duracion ' , d.duracion, '|| ||director ', d.director, '|| ||precio ' , d.precio:3:3, ' ||' );
		leerDeN(n,d);
	end;
	close(n);
	close(t);
end;
procedure imprimirOp2();
begin 
	writeln('.................................');
		writeln('Ingrese 1 para agregar una novela al archivo');
		writeln('Ingrese 2 Para modificar una novela del archivo');
		writeln('Ingrese 3 para Eliminar una novela del archivo');
		writeln('Ingrese 4 para Listar en un archivo de texto todas las novelas, incluyendo las borradas');
		writeln('Ingrese 5 para dejar de trabajar con el archivo');
		writeln('.................................');
end;
procedure Op2(var n:archN);
var
	num: integer;
begin
		imprimirOp2();
		readln(num);
		while(num<5) do begin
			case num of
				1: darAlta(n);
				2: modificarNovela(n);
				3: eliminar(n);
				4: Texto(n);
			end;
			imprimirOp2();
			readln(num);
		end;
		writeln('fin');
end;

procedure menu( var n: archN);
var
	num:integer;
begin 
	writeln(' --------------------------------------------');
	writeln(' Ingrese 1 Para crear un archivo de novelas');
	writeln(' Ingrese 2 para abrir el archivo de novelas');
	writeln(' --------------------------------------------');
	readln(num);
	while(num<=2) do begin
		case num of
			1: cargarN(n);
			2: Op2(n);
		end;
		writeln(' --------------------------------------------');
		writeln(' Ingrese 1 Para crear un archivo de novelas');
		writeln(' Ingrese 2 para abrir el archivo de novelas');
		writeln(' Ingrese 3 para Finalizar el programa');
		writeln(' --------------------------------------------');
		readln(num);
	end;
end;

var
	n:archN;
begin
	Assign(n,'Archivo_de_Novelas');
	menu(n);
end.

			
						
								
									
									
