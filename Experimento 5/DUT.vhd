library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dut is
	port(A, B: in std_logic_vector (3 downto 0);
	     S: out std_logic);
end dut;

architecture dut_arch of dut is
component somador is
	port(A,B,Cin: in std_logic;
	     S, Cout: out std_logic);
end component;
	signal sCout, sY: std_logic_vector (3 downto 0);
begin

somador0 : somador
	port map(
	A => A(0),
	B => B(0),
	Cin => '0',
	S => sY(0),
	Cout => sCout(0));

somador1 : somador
	port map(
	A => A(1),
	B => B(1),
	Cin => sCout(0),
	S => sY(1),
	Cout => sCout(1));

somador2 : somador
	port map(
	A => A(2),
	B => B(2),
	Cin => sCout(1),
	S => sY(2),
	Cout => sCout(2));

somador3 : somador
	port map(
	A => A(3),
	B => B(3),
	Cin => sCout(2),
	S => sY(3),
	Cout => sCout(3));
S <= sCout(3) & sY;
