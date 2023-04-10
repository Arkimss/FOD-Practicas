program ej9P2;
const
	valorAlto= 999;
type
	dato= record 
		  codP: integer;
		  codL: integer;
		  numMesa: integer;
		  CantVotos: integer;
		  end;
	arch= file of dato;
procedure Leer(var votos:arch; var d: dato);
begin
	if(not eof(votos))then
		read(votos, d)
	else
		d.codP := valoralto;
end;
var
	votos: arch;
	d:dato;
	CodProvAct:integer;
	CodLocAct:integer;
	TotalVGeneral: integer;
	TVP:integer;
	TVL: integer;
begin
	Assign(votos,'VotosEj9');
	reset(votos);
	TotalVGeneral:=0;
	Leer(votos,d);
	while(d.codP<> valorAlto) do begin
		TVP:=0;
		writeln( 'Codigo De Provincia: ', d.CodP);
		CodProvAct:= d.CodP;
		while(d.codP= CodProvAct)do begin
			TVL:=0;
			writeln( 'Codigo De Localidad: ', d.CodL);
			CodLocAct:= d.CodL;
			while(d.codP = CodProvAct) and (d.CodL = CodLocAct) do begin
				TVL:= TVL + d.cantVotos;
				leer(votos, d);
			end;
			writeln( 'Total de votos de localidad: ', TVL);
			TVP:= TVP + TVL;
		end;
		writeln( 'Total de votos de provincia: ', TVP);
		TotalVGeneral:= TotalVGeneral + TVP;
	end;
	writeln( 'Total de votos Totales: ', TotalVGeneral);
	close(votos);
end.
			
