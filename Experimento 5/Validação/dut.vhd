library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_dut is
    Port ( 
        A : in  STD_LOGIC_VECTOR(3 downto 0);
        Ydut : out STD_LOGIC
    );
end xor_dut;

architecture xor_dut_arch of xor_dut is
    signal x1, x2 : STD_LOGIC;
begin
    -- Cascata: (A0 XOR A1) -> depois XOR A2 -> depois XOR A3
    x1 <= A(0) xor A(1);
    x2 <= x1 xor A(2);
    Ydut  <= x2 xor A(3);
end xor_dut_arch;
