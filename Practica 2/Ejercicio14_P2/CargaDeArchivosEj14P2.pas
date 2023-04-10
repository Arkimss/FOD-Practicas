program CargaArchivosEj14P2;
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
	writeln( 'ingrese destino, fechayHora y CantAsientosDisponibles');
	readln(r.destino);
	readln(r.fechayHora);
	readln(r.CantAsientosComprados);
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
	close(mae);
end;
procedure Atexto( var bin: archM; var T: Text);
var
	r:datoM;
begin
	reset(bin);
	rewrite(T);
	while(not eof(bin)) do begin
		read(bin, r); 
		writeln( r.fechayHora,r.CantAsientosDisponibles, r.destino);
	end; 
	close(bin);
	close(T);
end; 
var
	Det1,Det2: archD;
	i,J,K:integer;
	mae: archM;
	m: datoM;
	d: datoD;
	T: text;
begin
	Assign(Det1, 'Detalle1');
	Assign(Det2, 'Detalle2');
	Assign(mae,'Maestro');
	Assign(T,'texto.txt');
	{rewrite(Det2);
	rewrite(Det1);
	rewrite(mae);
	for i:= 1 to 3 do begin
		writeln('Det1');
		LeerD(d);
	end;
	for J:= 1 to 3 do begin
		writeln('Det2');
		LeerD(d);
	end;
	for K:= 1 to 5 do begin
		writeln('MAE');
		LeerM(m);
	end;
	close(Det1);
	close(Det2);
	close(mae);}
	Atexto(mae,T);
end.
