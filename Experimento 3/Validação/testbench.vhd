library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
    port (
        S_out : out std_logic_vector(2 downto 0);
        D_out : out std_logic_vector(7 downto 0)
    );
end testbench;

architecture behavioral of testbench is
begin
    process
    begin
        for i in 0 to 7 loop
            S_out <= std_logic_vector(to_unsigned(i, 3));
            for j in 0 to 255 loop
                D_out <= std_logic_vector(to_unsigned(j, 8));
                wait for 10 ns;
            end loop;
        end loop;
        wait;
    end process;
end behavioral;
