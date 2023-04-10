program ej11p2;
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
procedure minimo(var Det:vD; var regs: vreg; var min: DatoD);
begin
	min:= regs[1];
	if(regs[2].nomP <= min.nomP) then begin
		min:= regs[2];
		Leer(Det[2], Regs[2]);
	end
	else
		Leer(Det[1],regs[1]);
end;

var
	vdet: vD;
	st:string[2];
	vR: vreg;
	min: datoD;
	DM:datoM;
	i:integer;
	M: archM;
	provAct,locAct: string[25];// provincia y localidad actual
	cantEnLoc:integer;//cantidad total de encuestados en cada localidad.
	cantEnProv:integer;// cantidad total de encuestados en una provincia.
	cantAlfLoc:integer;//cantidad de alfabetizados en una localidad 
	cantAlfProv:integer;//cantidad de alfabetizados en una provincia
	cantTotalAlf:integer;//cantidad total de alfabetizados
	cantTotalEn:integer;//cantidad total de encuestados
begin
	cantTotalAlf:=0;
	cantTotalEn:=0;
	for i:= 1 to 2 do begin
		str(i,st);
		Assign(vDet[i],'Det' + st);
		reset(vDet[i]);
		Leer(vDet[i],vR[i]);
	end;
	Assign(M,'maestro');
	reset(M);
	LeerDeM(M,DM);
	Minimo(vDet,vR,min);
	while(min.nomP<>valorAlto) do begin
		provAct:= min.NomP;
		cantEnProv:=0;
		cantAlfProv:=0;
		while(min.nomp = ProvAct) do begin
			locAct:= min.NomL;
			cantAlfLoc:=0;
			cantEnLoc:=0;
			while(min.nomp = ProvAct) and (min.nomL= locAct) do begin
				cantEnLoc+= min.total_Encuestadas;
				cantAlfLoc+=min.cant_per_alfabetizadas;
				Minimo(vDet,vR,min);
			end;
			cantEnProv+=cantEnLoc;
			cantAlfProv+=cantAlfLoc;
		end;
		cantTotalAlf+= cantAlfProv;
		cantTotalEn+= cantEnProv;
		while(DM.nomP <> provAct) do 
			LeerDeM(M,DM);
		seek(M,FilePos(M) - 1);
		Dm.cant_per_alfabetizadas:= cantTotalAlf;
		Dm.total_Encuestadas:= cantTotalEn;
		write(M,DM);
	end;
end.
