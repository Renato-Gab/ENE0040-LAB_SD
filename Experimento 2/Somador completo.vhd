library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity somador is
	port(A,B,Cin: in std_logic;
	     S, Cout: out std_logic);
end somador;

architecture somador_arch of somador is
begin
	S <= A xor B xor Cin;
	Cout <= (A and B) or (A and Cin) or (B and Cin);

end somador_arch;
