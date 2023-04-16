program ejercicio1P3;
const
	corte=-1;
	valorAlto= 9999;
type
	
    empleado = record
    numE: integer;
    DNI: integer;
    nombre: string[15];
    ape:string[15];
    edad: integer;
    end;
    Emp= file of empleado;
    texto= file of Text;
procedure cargarEm( var em: empleado);
begin
    writeln('ingrese , apellido,nombre, numero de empleado, Dni y edad del empleado'); 
    readln( em.ape);
    if( em.ape<> 'fin') then begin
        readln(em.nombre);
        readln(em.numE);
        readln(em.dni);
        readln(em.edad);
    end;
end;
procedure imprimir(em: empleado);
begin
    writeln('Num de empleado:   ', em.numE, '   Num de DNI:  ', ' ',em.DNI, '  Apellido del empleado:    ', em.ape,' nombre del empleado: ', em.nombre, ' La edad del empleado es: ', em.edad);
end;
function Empleado_repetido(numE: integer; var arch_emp: emp): boolean;// esta funcion recorre el archivo verificando que no se repita el numero de empleado
    var
        aux: boolean;
        comp: empleado;
    begin
		Seek(arch_emp,0);
        aux:= false;
        while((not eof(arch_emp)) and (not aux))do begin
            read(arch_emp, comp);
            if( comp.numE = numE) then 
                aux:= true;
        end;
    writeln('  El empleado es repetido??  ' ,aux);
    
    Empleado_repetido:= aux;
    end;
procedure Opcion1(var arch_emp: emp);//imprime los empleados que coindidan con un nombre y/o apellido ingresado
var
    nombre, apellido: string[20];
    em:empleado;
begin
    reset(arch_emp);//abro el archivo
    writeln('ingrese nombre y apellido a buscar');    
    readln(nombre);
    readln(apellido);
    while (not eof(arch_emp)) do begin// recorro el archivo
        read( arch_emp, em);
        if((nombre = em.nombre) or (apellido = em.ape)) then begin // si el nombre o el apellido coinciden con el ingresado, se muestran en pantalla sus datos.
            imprimir(em);
        end;
    end;
    close(arch_emp);
    writeln( ' SE ejecuto la primera opcion´');
end;
procedure Opcion2 (var arch_emp: emp);//imprime un empleado por linea
var
    em:empleado;
begin
    reset(arch_emp);//abro el archivo
     while (not eof(arch_emp)) do begin// recorro el archivo
        read( arch_emp, em);
        imprimir(em);// mostrar los datos del empleado
            end;
        close(arch_emp);
         writeln( ' SE ejecuto la segunda opcion´');
end;
procedure Opcion3(var arch_emp: emp);//imprime a los empleados mayores de 70 años
var
    em:empleado;
begin
    reset(arch_emp);//abro el archivo
     while (not eof(arch_emp)) do begin// recorro el archivo
        read( arch_emp, em);
            if(em.edad > 70) then begin//mostrar los datos del empleado mayor a 70 años de edad
                imprimir(em);
        end;
    end;
    close(arch_emp);
     writeln( ' SE ejecuto la tercera opcion´');
end;
procedure Opcion4(var arch_emp:emp);// agregar uno o mas empleados
var
    em:empleado;
begin
    reset(arch_emp);//abro el archivo
    seek(arch_emp, FileSize(arch_emp) );// me posiciono al final del archivo
    writeln( ' se agregara un nuevo empleado');
    cargarEm(em);// leo el empleado
while(em.ape<> 'fin') do begin 
  if( not (Empleado_repetido(em.numE,arch_emp)))then // verifico que	 no se repita el numero de empleado
    write(arch_emp, em);// agrego el nuevo empleado    
    writeln( ' se agregara un nuevo empleado');
    cargarEm(em);// leo el empleado	
	end;
    close(arch_emp);
     writeln( ' SE ejecuto la cuarta opcion´');
end;
procedure Opcion5( var arch_emp: emp);//modifica la edad de uno o mas empleados
var
    num: integer;
    aux: boolean;
    em:empleado;
begin
    writeln(' ingrese el numero de empleado al que se le debe modificar la edad');
    readln(num);
    aux:= true;
    while(num <> -1 )do begin 
        reset(arch_emp);
        while((not eof(arch_emp)) and (aux)) do begin// recorro el archivo 
            read(arch_emp, em); // cada vez que quiero modificar una edad debo recorrer el archivo
             if(num = em.numE )then begin // busco al empleado en el archivo
                writeln( ' ingrese la edad del empleado para que sea modificada');
                readln(num);
                em.edad:= num;
                seek(arch_emp, filePos(arch_emp) - 1);
                write(arch_emp, em);
                aux:= false;// si encuentro al empleado, modifico su edad y dejo de recorrer el archivo 
            end;
        end;
            if(not aux) then begin// si el numero de empleado no se encontraba en el archivo, se informa que no se encuentra.
                writeln( 'el numero de empleado no se encuentra en el sistema');
                  aux:= true;
            end;
    close(arch_emp);
    writeln(' ingrese el numero de empleado al que se le debe modificar la edad');
    readln(num);
	end;
end;
procedure Opcion6 (var arch_emp: emp; var arch_text: Text);
var
	emp: empleado;
begin
	assign(arch_text,'todos_empleados.txt');
	rewrite(arch_text);
	reset(arch_emp);
	while(not eof(arch_emp)) do begin
	read(arch_emp,emp);
	writeln(arch_text,' ',emp.numE, ' ', emp.DNI, ' ', emp.nombre, '  ',emp.ape, ' ', emp.edad);
	end;
	close(arch_emp);
	close(arch_text);
end;

	procedure leer (var archivo:emp; var dato:empleado);
begin
	if (not eof(archivo))
	then read (archivo,dato)
	else dato.numE := corte;
	end;
procedure Opcion7(var arch_emp:emp; var arch_text: Text);
var
	emp: empleado;
begin
	assign(arch_text,'faltaDNIEmpleado.txt');
	rewrite(arch_text);
	reset(arch_emp);
	leer(arch_emp,emp);
	while(emp.numE <>  -1) do begin
	if(emp.DNI= 00) then 
	writeln(arch_text,' ',emp.numE, ' ', emp.DNI, ' ', emp.nombre, '  ',emp.ape, ' ', emp.edad);
	leer(arch_emp,emp);
	end;
	close(arch_emp);
	close(arch_text);
end;
procedure cargar_archivo(var arch_emp: emp);
var
	//nom: string[20];
	em: empleado;
begin
     rewrite(arch_emp);
     cargarEm(em);
     while( em.ape <> 'fin') do begin
       if(not Empleado_repetido(em.numE, arch_emp)) then 
        write(arch_emp, em);
       cargarEm(em);
        end;
        close(arch_emp);
end;
procedure Opcion8(var arch_emp: Emp);
var
	pos,num: integer;
	dato: empleado;
	ok: boolean;
	 
begin
	writeln(' ingrese numero de empleado a eliminar ');
	readln(num);
	ok:= true;
	reset(arch_emp);
	leer(arch_emp,dato);
	while((dato.numE <> valorAlto) and (ok)) do begin
		if(dato.NumE = num) then begin
			ok:=false;
			pos:= FilePos(arch_emp)-1;
		end;
		leer(arch_emp,dato);
	end;
	seek(arch_emp, FileSize(arch_emp) - 1);
	read(arch_emp, dato);
	seek(arch_emp, FileSize(arch_emp) - 1);
	truncate(arch_emp);
	seek(arch_emp, pos);
	write(arch_emp,dato);
	close(arch_emp);
end;
		
procedure imprimirOpciones();
begin
   writeln;
   writeln('-------------------------------------------------------------------------');
   writeln(' seleccione una opción: ');
   writeln(' 1 Para listar Los empleados que tengan un nombre o apellido determinado: ');
   writeln(' 2 Para listar los empleados uno por linea'); 
   writeln(' 3 Para listar en pantalla a los empleados mayores de 70 años, proximos a la jubilación ');
   writeln(' 4 Para añadir uno o más empleados al archivo creado ');
   writeln(' 5 Para modificar la  edad de uno o más empleados '); 
   writeln(' 6 Para Exportar el contenido del archivo a un archivo de texto llamado "todos_empleados.txt” ');
   writeln(' 7 Para Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00) ');
   writeln(' 8 Para Eliminar un elemento del archivo');
   writeln(' 9 Para dejar de trabajar con el archivo');
   writeln('-------------------------------------------------------------------------');
    writeln;
end;

procedure ejecutarOpcion(opcion: integer; var arch_emp: emp);
var
	arch_text6: Text;	
	arch_text7:Text;
begin
	case opcion of
	1: Opcion1(arch_emp);
	2: Opcion2(arch_emp);
	3: Opcion3(arch_emp);
	4: Opcion4(arch_emp);
	5: Opcion5(arch_emp);
	6: Opcion6(arch_emp, arch_text6);
	7: Opcion7(arch_emp, arch_text7);
	8: Opcion8(arch_emp);
    end;
end;
var
    arch_emp: Emp;
    opcion: integer;
	
begin
   writeln('Se creara un archivo con empleados');
    Assign(arch_emp,'Empleados');
   //cargar_archivo(arch_emp);
   imprimirOpciones();
   readln(opcion);
   while(opcion<>9) do begin
	ejecutarOpcion(opcion, arch_emp);
	imprimirOpciones();
	readln(opcion);
   end;
   writeln('Finaliza el programa ');
end.
 
