library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_d_gm is
    Port ( clk, rst : in STD_LOGIC; D : in STD_LOGIC; Q : out STD_LOGIC );
end ff_d_gm;

architecture Behavioral of ff_d_gm is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            Q <= '0';
        elsif rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end Behavioral;
