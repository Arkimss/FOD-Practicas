program cargarArchEj9;
type
	dato= record 
		  codP: integer;
		  codL: integer;
		  numMesa: integer;
		  CantVotos: integer;
		  end;
	arch= file of dato;
procedure LeerR(var r: dato);
begin
		writeln('ingrese CP, CL, NM, CV');
		with r do begin
			readln(codP);
			readln(codL);
			readln(numMesa);
			readln(CantVotos);
		end;
end;
var
	votos: arch;
	i:integer;
	r:dato;
begin
	Assign(votos, 'VotosEj9');
	rewrite(votos);
	for i:= 1 to 5 do begin
		LeerR(r);
		write(votos, r);
	end;
	close(votos);
end.

		
