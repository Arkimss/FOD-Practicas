program ab;
type
celular= record
			 codigoDCelular: integer;
			 nom: string[20];
			 descripcion: string[20];
			 marca: string[20];
			 precio: real;
			 stockMin: integer;
			 stockD: integer;
			 end;
cel= file of celular;
procedure LeerCelular(var c:celular);
begin
	writeln('íngrese codigo de celular, nombre, descripcion, marca, precio stock minimo y stock disponible');
	with c do begin
		readln(codigoDcelular);
		if(codigoDcelular<> -1) then begin
			readln(nom);
			readln(descripcion);
			readln(marca);
			readln(precio);
			readln(stockMin);
			readln(stockD);
		end;
	end;
end; 

procedure creacionArchTexto(var arch_text: Text);
var
	c:celular;
begin
	assign(arch_text, 'celulares.txt');
	rewrite(arch_text);
	LeerCelular(c);
	while(c.CodigoDCelular<>-1) do begin
		with c do begin
		writeln(arch_text,	codigoDCelular, precio:2:2,  marca);
		writeln(arch_text,	stockD, stockMin, descripcion);
		writeln(arch_text,	nom);
		LeerCelular(c);
		end;
	end; 
	close(arch_text);
end;
var
	a: Text;
begin
	creacionArchTexto(a);
end.

