library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity golden is
	port(A, B: in std_logic_vector (3 downto 0);
	     S: out std_logic_vector (4 downto 0)
	);
end golden;

architecture golden_arch of golden is
begin

S <= std_logic_vector(('0' & unsigned(A)) + ('0' & unsigned(B)));

end golden_arch;


