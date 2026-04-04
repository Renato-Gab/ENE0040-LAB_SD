library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_somador is
end tb_somador;

architecture teste of tb_somador is
component somador is
	port(A,B,Cin: in std_logic;
	     S, Cout: out std_logic);
end component;

signal A,B,Cin: STD_LOGIC :='0';
signal S,Cout: STD_LOGIC;

begin

uut: somador port map(
	A => A,
	B =>B,
	Cin => Cin,
	S => S,
	Cout => Cout);

A <= not A after 40 ns;
B <= not B after 20 ns;
Cin <= not Cin after 10 ns;

end teste;
