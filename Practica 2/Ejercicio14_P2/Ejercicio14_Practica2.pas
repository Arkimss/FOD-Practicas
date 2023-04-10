program ejercicio14P2;
const
	valorAlto= 'ZZZ';
type	
	datoM= record
		   destino: string[20];
		   fechayHora: LongInt;
		   CantAsientosDisponibles: integer;
		   end;
	datoD= record
		   destino: string[20];
		   fechayHora: LongInt;
		   CantAsientosComprados:integer;
		   end;
	archM= file of datoM;
	archD= file of datoD;
procedure LeerM(var r: datoM);
begin
	writeln( 'ingrese destino, fechayHora y CantAsientosDisponibles');
	readln(r.destino);
	readln(r.fechayHora);
	readln(r.CantAsientosDisponibles);
end;
procedure LeerD(var r: datoD);
begin
	writeln( 'ingrese destino, fechayHora y CantAsientoscomprados');
	readln(r.destino);
	readln(r.fechayHora);
	readln(r.CantAsientosComprados);
end;
procedure Leer(var det:archD; var d: datoD);
begin
	if(not eof(det))then
		read(det, d)
	else
		d.destino := valoralto;
end;
procedure LeerDeM(var det:archM; var d: datoM);// lee un dato del archivo maesstro
begin
	if(not eof(det))then
		read(det, d)
	else
		d.destino := valoralto;
end;
procedure impDato( min: datoD);
begin
	writeln(' destino ' , min.destino);
	writeln(' fyh  ', min.fechayhora);
end;
procedure Minimo(var D1,D2: archD; var Det1,Det2: DatoD; var min:datoD);
begin
	min:= Det2;
	if(( Det1.destino < min.destino) or ((Det1.destino = min.destino) and (Det1.fechayhora < min.fechayhora))) then begin
			min:= Det1;
			Leer(D1, Det1)
			end
	else
		Leer(D2,Det2);
	writeln('MINIMOOOOOOOOOOOOOO');
	impDato(min);
end;
procedure imp(  var m: archM);
var
	d:datoM;
begin
	reset(m);	
	while(not eof(m))do begin
		read(m,d);
		writeln( 'destino: ', d.destino);
		writeln('fechayhora: ',d.fechayhora);
		writeln('.CantAsientosDisponibles: ', d.CantAsientosDisponibles);
	end;
	close(m);
end;
procedure AgregarM(var mae: archM);
var
	i:integer;
	r:DatoM;
begin
	reset(mae);
	seek(mae, FileSize(mae));
	for i:= 1 to 2 do begin
		LeerM(r);
		write(mae,r);
	end;
end;
var
	Det1,Det2: archD;
	mae: archM;
	m: datoM;
	min,d1,d2, aux: datoD;
	
begin
	Assign(Det1, 'Detalle1');
	Assign(Det2, 'Detalle2');
	Assign(mae,'Maestro');
	writeln('impresion del archivo maestro: ');
	imp(mae);
	reset(Det2);
	reset(Det1);
	reset(mae);
	Leer(Det1,d1);
	Leer(Det2,d2);
	LeerDeM(mae,m);
	Minimo(Det1,Det2,d1,d2,min);
	while(min.destino <> valorAlto) do begin
		// CORTE DE CONTROL DEL DETALLE, luego lo busco en el maestro, actualizo el dato, lo cargo en el maestro
		aux:= min;
		while((aux.destino = min.destino) and ( aux.fechayhora = min.fechayhora))do begin
			aux.cantAsientoscomprados += min.cantAsientosComprados;
			Minimo(Det1,Det2,d1,d2,min);
		end;
		while((m.destino <> aux.destino)and (m.fechayhora <> aux.fechayhora))do BEGIN
			LeerDeM(mae,m);
		end;
		m.cantAsientosDisponibles -= aux.cantAsientosComprados; 		
		seek(mae,FilePos(mae) - 1); 
		write(mae,m);
	end;
	close(mae);
	close(Det1);
	close(Det2);
	writeln('impresion del archivo maestro: ');
	imp(mae);
	writeln('qqqq');
end.
