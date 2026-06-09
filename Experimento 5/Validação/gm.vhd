library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gm is
    Port ( 
        A : in  STD_LOGIC_VECTOR(3 downto 0);
        Ygm : out STD_LOGIC
    );
end xor_gm;

architecture xor_gm_arch of xor_gm is
begin
    Ygm <= (A(0) xor A(1)xor A(2) xor A(3));
end xor_gm_arch;
