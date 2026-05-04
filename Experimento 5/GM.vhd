library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity GM is
	port(A, B: in std_logic_vector (3 downto 0);
	     S: out std_logic_vector (4 downto 0)
		);
end GM;

architecture GM_ARCH of GM is
begin
    S <= ('0' & unsigned(A)) + ('0' & unsigned(B));
end GM_ARCH;
