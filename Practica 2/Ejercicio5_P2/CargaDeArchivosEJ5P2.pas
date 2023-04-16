program cargaej5p2;
const
	ValorAlto=9999;
type 
	direccion= record 
			   calle:integer;
			   num: integer;
			   depto: integer;
			   ciudad: string;
			   end;
	DatoF= record
		   numP: integer;
		   DNI: LongInt;
		  Nom: string;
		   ape: string;
		   num_Mat_med_d:integer; // nnumero de matricula del medico que firmó el deceso.
		   Fecha_y_Hora: LongInt;
		   lugarF: string; // lugar en el que fallecio la persona.
		   end;
	DatoN=  record
			numP: integer;
		    DNI: LongInt;
		    Nom: string;
		    ape: string; 
		    dir: direccion;
		    num_Mat_med:integer; // nnumero de matricula del medico.
		    DNI_Madre: LongInt;
		    DNI_Padre:LongInt;
		    NYA_Madre: string;
		    NYA_Padre: string;
		    end;
	DatoM= record
		   numP: integer;
		   DNI: LongInt;
		   Nom: string;
		   ape: string; 
		   num_Mat_med:integer; // nnumero de matricula del medico.
		   DNI_Madre: LongInt;
		   DNI_Padre:LongInt;
		   NYA_Madre: string;
		   NYA_Padre: string;
	   	   fallecido: boolean;
		   FyH_Deceso: LongInt;
		   num_Mat_med_d:integer; // nnumero de matricula del medico que firmó el deceso.
		   lugarF: string;
		   END;
		   
	ArchM= file of datoM;
	ArchN= file of DatoN;
	ArchF= file of DatoF;
	VRN= array [1..50] of DatoN;// vector de registros de nacimientos
	VRF= array [1..50] of DatoF;// vector de registros de fallecidos
	VN= array [1..50] of archN; // vector de archivos de nacimientos
	VF= array [1..50] of archF; 

procedure LeerDir(var d:direccion; i:integer);
var
	st:string;
begin
	with d do begin
		calle:=i;
		num:= i;
		depto:= i;
		str(i,st);
		ciudad:= st;
	end;
end;
procedure LeerNacimiento(var D: datoN; i:integer);
var
	st:string;
begin
	write('ingrese nro partida nacimiento, nombre, apellido, dirección detallada(calle,nro, piso, depto, ciudad), matrícula');
    write('del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del');   
    write(' padre');
    with d do begin
		numP:= i;
		DNI:= i;
		str(i,st);
		Nom:= st;
		ape:= st; 
		LeerDir(dir,i);
		num_Mat_med:= i; // nnumero de matricula del medico.
		DNI_Madre:=i;
		DNI_Padre:=i;
		NYA_Madre:=st;
		NYA_Padre:= st;
	end;
end;
procedure LeerFallecido(var  F: datoF; i:integer);
var
	st:string;
begin
	write('nro partida nacimiento, DNI, nombre y');
    write('apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y');   
    write('lugar');
    with F do begin
		numP:= i;
		DNI:= i;
		str(i,st);
		Nom:= st;
		ape:= st; 
		num_Mat_med_d:= i; // nnumero de matricula del medico.
		Fecha_y_Hora:=i;
		lugarF:= st;
	end;
end;
procedure LeerDeMaestro( var mae:archM; dato: DatoM);
begin
	if(not eof(mae)) then
		read(mae,dato)
	else
		dato.numP:= ValorAlto;
end;

procedure LeerDeArchF(var f: ArchF;var dato: DatoF);
begin
if(not eof(f)) then
		read(f,dato)
	else
		dato.numP:= ValorAlto;
end;

procedure LeerDeArchN(var n: ArchN; var dato: DatoN);
begin
if(not eof(n)) then
		read(n,dato)
	else
		dato.numP:= ValorAlto;
end;
var
	i_st:string;
	i: integer;
	vecNac:VN;
	D:DatoN;
	E:DatoF;
	vecFal: VF;
begin
	for i:= 1  to 50 do begin
		str(i,i_st);
		assign(vecNac[i], ' DetNac' + i_st);
	    assign(vecFal[i], ' DetFal' + i_st);
	    rewrite(vecNac[i]);
	    rewrite(vecFal[i]);
		LeerNacimiento(D,i);
		LeerFallecido(E,i+1);
		write(vecNac[i],D);
		write(vecFal[i],E);
		close(vecNac[i]);
		close(vecFal[i]);
	end;
end.
