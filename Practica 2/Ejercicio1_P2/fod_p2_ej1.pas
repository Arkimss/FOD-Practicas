program fod_p2_ej1;

const 
	valoralto = 9999;

type
	empleado = record // arch maestro
		monto: real;
		codigo: integer;
	end;
	
	ingreso = record // arch detalle
		codigo: integer;
		nombre: string;
		monto: real;
	end;
	
	maestro = file of empleado;
	detalle = file of ingreso;
	
procedure leerRegistro(var r: ingreso);
begin
	writeln('Ingrese un nuevo ingreso de comision');
	readln(r.codigo);
	if (r.codigo <> -1) then begin
		readln(r.nombre);
		readln(r.monto);
	end;	
end;

procedure cargarDetalle(var det: detalle);
var
	r: ingreso;
begin
	rewrite(det);
	leerRegistro(r);
	while (r.codigo <> -1) do begin
		write(det, r);
		leerRegistro(r);
	end;
	close(det);
end;

procedure imprimirRegistroDet(r: ingreso);
begin
	writeln(r.codigo);
	writeln(r.nombre);
	writeln(r.monto:2:2);
end;

procedure imprimirArchivoDet(var det: detalle);
var
	r: ingreso;
begin
	reset(det);	
	while not (eof(det)) do begin
		writeln('COMISION');
		read(det, r);				
		imprimirRegistroDet(r);
	end;
	close(det);
end;

procedure imprimirRegistroMae(r: empleado);
begin
	writeln(r.codigo);
	writeln(r.monto:2:2);
end;

procedure imprimirArchivoMae(var mae: maestro);
var
	r: empleado;
begin
	reset(mae);	
	while not (eof(mae)) do begin
		writeln('EMPLEADO');
		read(mae, r);				
		imprimirRegistroMae(r);
	end;
	close(mae);
end;

procedure leer( var archivo: detalle; var dato: ingreso);
begin
	if (not(eof(archivo))) then
		read(archivo, dato)
	else
		dato.codigo := valoralto;
end;

procedure cargarMaestro(var mae: maestro; var det: detalle);
var
	i: ingreso;
	e: empleado;
	total: real;
	aux: integer;
begin
	rewrite(mae); //crear maestro
	reset(det); //abrir detalle
	leer(det, i);
	while (i.codigo <> valoralto) do begin //recorrer el detalle
		aux:= i.codigo; //guardar el codigo del registro
		total:= 0.0; //inicializar total en cero
		while (aux = i.codigo) do begin //buscar si hay varios con el mismo codigo
			total:= total + i.monto; //vamos sumando en total
			leer(det, i); //leer otro registro detalle
		end;
		e.codigo:= aux;
		e.monto:= total;
		write(mae, e); //guardamos el registro actualizado en el maestro
	end;	
	close(det);
	close(mae);
end;

var
	mae: maestro;
	det: detalle;

begin
	assign(mae, 'maestro');
	assign(det, 'detalle');
	 cargarDetalle(det);
	imprimirArchivoDet(det);
	cargarMaestro(mae, det);
	imprimirArchivoMae(mae);
end.
