library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dut is
	port(A, B: in std_logic_vector (3 downto 0);
	     S: out std_logic_vector(4 downto 0)
	     );
end dut;

architecture dut_arch of dut is
component somador is
	port(A,B,Cin: in std_logic;
	     S, Cout: out std_logic);
end component;
	signal w1, w2, w3, w4: std_logic;

begin
    INT1 : somador port map(A(0), B(0), '0', S(0), w1);
    INT2 : somador port map(A(1), B(1), w1, S(1), w2);
    INT3 : somador port map(A(2), B(2), w2, S(2), w3);
    INT4 : somador port map(A(3), B(3), w3, S(3), w4);
    S(4) <= w4;
end dut_arch;
