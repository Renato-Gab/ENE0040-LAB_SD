library ieee;
use ieee.std_logic_1164.all;


entity meucircuito1 is
    port (S: in std_logic_vector(2 downto 0);
    D: in std_logic_vector(7 downto 0);
    Y: out std_logic);
end meucircuito1;


architecture meucircuito1_arch of meucircuito1 is
begin
    Y <= D(0) when (S = "000") else
         D(1) when (S = "001") else
         D(2) when (S = "010") else
         D(3) when (S = "011") else
         D(4) when (S = "100") else
         D(5) when (S = "101") else
         D(6) when (S = "110") else
         D(7);
end meucircuito1_arch;

