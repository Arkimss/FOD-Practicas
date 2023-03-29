program Ej2P2FOD;
const
	valorAlto=999;
type
	Alumno= record
			Cod: integer;
			ape: string[20];
			nom: string [15];
			MatSinFinal: integer;//cantidad de materias aprobadas sin final
			MatConFinal: integer;//cantidad de materias aprobadas con final
			end;
	Materia= record
			 Cod: integer;
			 ConFinal: boolean; // si es false aprobo la cursada, si es true aprobo el final.
			 end; 
	Maestro= file of Alumno;
	Detalle= file of Materia;
	
	
procedure LeerAlumno(var a: Alumno);
begin
	writeln('ingrese codigo de alumno, apellido, nombre, cantidad de materias en la que aprobo la cursada y cantidad de materias aprobadas con final');
	readln(a.Cod);
	if(a.cod<>-1) then begin
		readln(a.ape);
		readln(a.nom);
		readln(a.MatSinFinal);
		readln(a.MatConFinal);
	end;
end;

procedure Leer(var det:Detalle; var  d:Materia);
begin
	if( eof(det))then
		d.Cod := ValorAlto
	else
		read(det,d);
end;
procedure LeerM(var det:Maestro; var  d:Alumno);
begin
	if( eof(det))then
		d.Cod := ValorAlto
	else
		read(det,d);
end;

{
procedure LeerDet(var d: Materia);
begin
	readln(d.Cod);
	d.ConFinal:= true;
end;

procedure cargarDetalle(var d:Detalle);
var
	det: Materia;
begin
	rewrite(d);
	LeerDet(det);
	while(det.cod<> -1) do begin
		write(d, det);
		LeerDet(det);
	end;
	close(d);
end;
procedure cargarMaestro(var m:Maestro);
var
	mae:Alumno;
begin	
	reset(m);
	LeerAlumno(mae);
	while(mae.cod<> -1) do begin
		write(m, mae);
		LeerAlumno(mae);
	end;
	close(m);
end;
}
//cargue acá los archivos y los guarde entre llaves.

procedure ActualizarMaestro (var mae: Maestro; var det:Detalle);// recorro el detalle y el maestro mientras actualizo la cantidad de materias aprobaffas o la cantidad de finales aprobados en el maestro 
var
	Mat:Materia;
	Al:Alumno;
begin
	reset(mae);// abro los archivos
	reset(det);
	// si el detalle no es EOF, lo recorro con un procedimiento Leer para tomar los datos del archivo y poder procesar el ultimo elemento del archivo de manera correcta.
	Leer(det,Mat);
	while(Mat.Cod<>valorAlto) do begin 
	//voy guardando los codigos actuales en una variable auxiliar, para utilizarla en el corte de control 
		read(mae,Al);//leo el maestro
		while (Mat.cod = Al.cod) do begin		  
			if(Mat.ConFinal)then 
				Al.MatConFinal:=Al.MatConFinal + 1
			else
				Al.MatSinFinal:=Al.MatSinFinal + 1;
			Leer(det,Mat);
		end;
		writeln('llego', 'Pos' ,filePos(mae),'finales: ' , al.MatConFinal);
		seek(mae, FilePos(mae) - 1);
		write(mae,Al);
	end;
	close(mae);
	close(det);
end;
procedure imp(a: Alumno);
begin
	writeln(' cod ',a.cod);
	writeln(' ape ' ,a.ape);
	writeln(' nom ',a.nom);
	writeln('Sin : ' ,a.MatSinFinal);
	writeln('Con Final:', a.MatConFinal);
end;
procedure imprimirArchivoMae(var mae: maestro);
var
	r: Alumno;
begin
	reset(mae);	
	while not (eof(mae)) do begin
		writeln('Alumno');
		read(mae, r);				
		imp(r);
	end;
	close(mae);
end;
procedure ArchText( var mae: Maestro);
var
	texto :Text;
	Al: Alumno;
begin
	Assign(texto, ' AlumnosSinFinales.txt');
	rewrite(texto);
	// abro el aechivo maestro
	reset(mae);
	LeerM(mae,Al);
	while(Al.cod <> valorAlto) do begin
	// lo recorro y si tiene mas de 4 materias aprobadas, pero no tiene ningun final lo agrego al archivo de texto
		if((Al.MatConFinal=0) and ( Al.MatSinFinal >= 4)) then begin
			with Al do begin
				writeln(texto, Cod, ape);
				writeln(texto, MatConFinal, MatSinFinal, nom);
			end;
		end;
		LeerM(mae,Al);
	end;
	//una vez que se termina el archivo maestro, finaliza el proceso.
end;
var
	mae: Maestro;
	det: Detalle;
begin
	Assign(mae,'ArchivoMaestroE2');
	Assign(det,'ArchivoDetalleE2');
	{cargarDetalle(det);
	cargarMaestro(mae);}
	//writeln('1');
	//imprimirArchivoMae(mae);
	ActualizarMaestro(mae,det);
	ArchText(mae);
	datetime('20230917');
	//writeln('2');
	//imprimirArchivoMae(mae);
end.
