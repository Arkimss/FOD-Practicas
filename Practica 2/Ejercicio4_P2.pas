program fod_p2_ej4;
uses crt;

const
	valoralto = 9999;
	n = 5;
	
type
	fecha = record
		dia, mes, anio: integer;
	end;	
	
	sesion = record
		cod_usuario, tiempo_sesion: integer;
		fecha: fecha;
	end;	
	
	detalle = file of sesion;
	
	maestro = file of sesion;
	
	vectorDetalles = array [1..n] of detalle;
	
	vectorRegistros = array [1..n] of sesion;
	

procedure leer (var archivo: detalle; var dato: sesion);
begin
	if not(eof(archivo)) then
		read(archivo, dato)
	else
		dato.cod_usuario:= valoralto;
end;



var
	vD: VectorDetalles;
	Mae: maestro;
	i:integer;
	st:string;
begin
	Assign(Mae, '/var/log/');
	for i:= 1 to n do begin
		str(i,st);
		Assign(vD[i], 'Detalle' + st ); 


