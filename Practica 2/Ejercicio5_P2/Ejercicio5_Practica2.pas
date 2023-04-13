program ejercicio5P2;
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
		   NYA: string;
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

procedure Nmin( var V: VN; var VR:VRN; var min: DatoN);
var
	PosMin, i: integer;
begin
	min:= VR[1];
	PosMin:=1;
	for i:= 2 to 50 do begin
		if(VR[i].numP < min.numP) then begin
			min:= VR[i];
			PosMin:= i;
		end;
	end;
	LeerDeArchN(V[PosMin], VR[PosMiN]);
end;

procedure Fmin( var V: VF; var VR:VRF;var min: DatoF);
var
	PosMin, i: integer;
begin
	min:= VR[1];
	PosMin:=1;
	for i:= 2 to 50 do begin
		if(VR[i].numP < min.numP) then begin
			min:= VR[i];
			PosMin:= i;
		end;
	end;
	LeerDeArchF(V[PosMin], VR[PosMiN]);
end;

procedure AsignarAMae (d:DatoN ;var DM: DatoM);
begin
	DM.NumP:= d.NumP;
	DM.DNI:=d.DNI ;
	DM.Nom:=d.Nom;
	DM.ape:= d.ape;
	DM.num_Mat_med:= d.num_Mat_med;// nnumero de matricula del medico.
	DM.DNI_Madre:=d.DNI_Madre;
	DM.DNI_Padre:=d.DNI_Padre;
	DM.NYA_Madre:=d.NYA_Madre;
	DM.NYA_Padre:=d.NYA_Padre;
end;
procedure EsFallecido(d:datoF; var DM:DatoM);
begin
	DM.fallecido:= true;
	DM.num_Mat_med_d:=d.num_Mat_med_d; // nnumero de matricula del medico que firmó el deceso.
	DM.FyH_Deceso:=d.Fecha_y_Hora;
	DM.lugarF:=d.lugarF;
end;
procedure NoEsFallecido(var DM:DatoM);
begin
	DM.fallecido:= false;
	DM.num_Mat_med_d:=valorAlto; // nnumero de matricula del medico que firmó el deceso.
	DM.FyH_Deceso:=valorAlto;
	DM.lugarF:='Is a live';
end;
procedure crearText(var mae: archM; var maeText: text);
var
	r:datoM;
begin
	reset(mae);
	rewrite(maeText);
	while(not eof(mae)) do begin
		read(mae, r);
		with r do begin
			writeln(maeText, 'NumP: ' ,NumP,' DNI: ' ,DNI, ' num_Mat_med ', num_Mat_med, ' Nom ', Nom);
			writeln(maeText, ' Apellido ', ape);
			writeln(maeText, ' DNI_Madre: ' , DNI_Madre , '  NYA_Madre ',  NYA_Madre);
			writeln(maeText, ' DNI_Padre : ', DNI_Padre , ' NYA_Padre ', NYA_Padre);
			writeln(maeText, ' fallecido: ', fallecido, ' num_Mat_med_d ', num_Mat_med_d, '  FyH_Deceso ', FyH_Deceso ,' lugarF ', lugarF);
		end;
	end; 
	close(mae);
	close(maeText);
end; 	
VAR
	i_st:string;
	i: integer;
	vecNac:VN;
	vecFal: VF;
	RegsF: VRF;
	minF: datoF;
	minN: datoN;
	RegsN: VRN;
	mae: archM;
	maeText:text;
	DM: datoM;
begin
	assign( mae, 'Maestro');
	rewrite(mae);
	for i:= 1  to 50 do begin
		str(i,i_st);
		assign(vecNac[i], ' DetNac' + i_st);
	    assign(vecFal[i], ' DetFal' + i_st);
		Reset(vecNac[i]);
		Reset(vecFal[i]);
		LeerDeArchF(vecFal[i], RegsF[i]);
		LeerDeArchN(vecNac[i], RegsN[i]);
	end;
	Nmin(vecNac,RegsN,MinN);
	Fmin(vecFal,RegsF,minF);
	while(minN.numP<> valorAlto) do begin
		if(minN.numP = minF.numP) then begin
			AsignarAMae(MinN,DM);
			EsFallecido(MinF,DM);
			Fmin(vecFal,RegsF,minF);
			end
		else
			NoEsFallecido(DM);
		write(mae,DM);
		Nmin(vecNac,RegsN,MinN);
	end;
	for i:= 1 to 50 do begin
		close(vecNac[i]);
		close(vecFal[i]);
	end;
	close(mae);
	Assign(maeText,'Texto Maestro');
	crearText(mae,maeText);
end.
