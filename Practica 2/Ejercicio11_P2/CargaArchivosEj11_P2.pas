program CargarArchivosEj11P2;
const
	valorAlto= 'ZZZ';
type
	datoM= record
		   nomP: string[25];
		   cant_per_alfabetizadas: integer;
		   total_Encuestadas: integer;
		   end;
	datoD= record 
		   nomP: string[25];
		   cant_per_alfabetizadas: integer;
		   Total_Encuestadas: integer;
		   nomL:string[25];
		   end;
	archM= file of datoM;
	archD= file of datoD;
	vD= array [1..2] of archD;
	vreg= array[1..2] of datoD;
procedure LeerDeM(var d:archM; var reg: datoM);
begin
	if(not eof(d))then 
		read(d,reg)
	else
		reg.nomP:= valorAlto;
end;
procedure Leer(var d:archD; var reg: datoD);
begin
	if(not eof(d))then 
		read(d,reg)
	else
		reg.nomP:= valorAlto;
end;
procedure LeerDatoM(var r:datoM);
begin
	writeln('ingrese:  nomP, cant_per_alfabetizadas total_Encuestadas ');
	readln( r.nomP);
	readln(r.cant_per_alfabetizadas);
	readln(r.total_Encuestadas);
end;
procedure LeerDatoD(var r:datoD);
begin
	writeln('ingrese:  nomP, cant_per_alfabetizadas total_Encuestadas y nombre de localidad ');
	readln( r.nomP);
	readln(r.cant_per_alfabetizadas);
	readln(r.total_Encuestadas);
	readln(r.nomL);
end;
procedure MBin(var mae: ArchM);
var
	r:datoM;
begin
	writeln('Creación de archivo Maestro');
	rewrite(mae);
	LeerDatoM(r);
	while(r.nomP<>'ZZZ') do begin
		write(mae,r);
		LeerDatoM(r);
	end;
	close(mae);
end;
procedure DBin(var d: ArchD);
var
	r:datoD;
begin
	writeln('Creación de archivo Detalle');
	rewrite(d);
	LeerDatoD(r);
	while(r.nomP<>'ZZZ') do begin
		write(d,r);
		LeerDatoD(r);
	end;
	close(d);
end;
procedure DTexto(var d:archD; i:integer);
var
	t: Text;
	st:string;
	r:datoD;
begin
	str(i,st);
	Assign(t, 'TextoDet' + st);
	rewrite(t);
	reset(d);
	Leer(d,r);
	while(r.nomP<> valorAlto) do begin
		writeln(t,r.cant_per_alfabetizadas:5, r.nomP:30);
		writeln(t,r.Total_Encuestadas:25,r.nomL:30);
		Leer(d,r);
	end;
	close(d);
	close(t);
end;
procedure MTexto(var d:archM);
var
	t: Text;
	r:datoM;
begin
	Assign(t, 'Textomaestro');
	rewrite(t);
	reset(d);
	LeerDeM(d,r);
	while(r.nomP<> valorAlto) do begin
		writeln(t,r.cant_per_alfabetizadas:5,r.Total_Encuestadas:5, r.nomP:15);
		LeerDeM(d,r);
	end;
	close(d);
	close(t);
end;

var
	vdet: vD;
	i:integer;
	st:string;
	M: archM;
begin	
	for i:= 1 to 2 do begin
		str(i,st);
		Assign(vDet[i],'Det' + st);
		//DBin(vDet[i]);
		DTexto(vDet[i],i);
	end;
	Assign(M,'maestro');
	//Mbin(M);
	MTexto(M);
end.
	
