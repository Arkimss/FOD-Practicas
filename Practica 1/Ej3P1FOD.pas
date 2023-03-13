program ejercicio3P1FOD;
type
	empleado = record
	numE: integer;
	DNI: integer;
	nombre: string[15];
	ape:string[15];
	edad: integer;
	end;
	Emp= file of empleado;
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
	//write('   numero de DNI:  ', ' ',em.DNI);
	//write('   apellido del empleado:    ', em.ape);
	//write('   nombre del empleado:      ', em.nombre);
	//write('   la edad del empleado es:      ', em.edad);
end;
procedure incisoi(var arch_emp: emp);
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
			writeln('inciso i'); 
			imprimir(em);
		end;
	end;
	close(arch_emp);
end;
procedure incisoii (var arch_emp: emp);
var
	em:empleado;
begin
	reset(arch_emp);//abro el archivo
	 while (not eof(arch_emp)) do begin// recorro el archivo
		read( arch_emp, em);
		imprimir(em);// mostrar los datos del empleado
			end;
		close(arch_emp);
end;
procedure incisoiii(var arch_emp: emp);
var
	em:empleado;
begin
	reset(arch_emp);//abro el archivo
	 while (not eof(arch_emp)) do begin// recorro el archivo
		read( arch_emp, em);
			if(em.edad > 70) then begin//mostrar los datos del empleado mayor a 70 años de edad
				writeln('||||este empleado es mayor de 70||||');
				imprimir(em);
		end;
	end;
	close(arch_emp);
end;
procedure recorrido(var arch_emp: emp);
begin
	incisoi(arch_emp);
	incisoii(arch_emp);
	incisoiii(arch_emp);
end;

procedure agregarEmpleado(var arch_emp:emp);
	function Empleado_repetido(numE: integer; var arch_emp: emp): boolean;// esta funcion recorre el archivo verificando que no se repita el numero de empleado
	var
		aux: boolean;
		comp: empleado;
	begin
		aux:= false;
		//como dice uno o mas podria hacer un read de la cantidad de empleados que se quieren agregar y un for a partir de ese numero, pero nose...
		while((not eof(arch_emp)) and (not aux))do begin
			read(arch_emp, comp);
			if( comp.numE = numE) then 
				aux:= true;
		end;
	Empleado_repetido:= aux;
	end;
var
	em:empleado;
begin
	reset(arch_emp);//abro el archivo
	cargarEm(em);// leo el empleado
	if( not (Empleado_repetido(em.numE,arch_emp))) then begin// verifico que no se repita el numero de empleado
		seek(arch_emp, FileSize(arch_emp) - 1);// me posiciono al final del archivo
		write(arch_emp, em);// agrego el nuevo empleado
	end;
	//seek(arch_emp, FileSize(arch_emp) - 1);//verificación del ejercicio
	//read(arch_emp,em);
	//imprimir(em);
	//writeln( ' el ultimo se guardo piola');
	close(arch_emp);
end;
procedure modificarEdad( var arch_emp: emp);
var
	aux: integer;
begin
	writeln(' ingrese el numero de empleado al que se le debe modificar la edad');
	readln();
	while(eof  
	//como dice uno o mas podria hacer un read de la cantidad de edades que se quieren modificar y un for a partir de ese numero, pero nose...
var
	arch_emp: Emp;
	em: empleado;
	nom: string[20];
begin
	 writeln( ' ingrese el nombre del archivo');
	 readln( nom);
	 assign ( arch_emp, nom);
	 rewrite(arch_emp);
	 cargarEm(em);
	 while( em.ape <> 'fin') do begin
		write(arch_emp, em);
		cargarEm(em);
	end;
	close(arch_emp);
	recorrido(arch_emp);
	//ejercicio4();
	agregarEmpleado(arch_emp);
	
end.
