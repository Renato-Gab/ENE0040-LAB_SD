library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_multiplexador is
end tb_multiplexador;

architecture behavior of tb_multiplexador is
    signal S_tb : std_logic_vector(2 downto 0) := "000";
    signal D_tb : std_logic_vector(7 downto 0) := "10101010";
    signal Y_tb : std_logic;

begin

    uut: entity work.multiplexador
        port map (
            S => S_tb,
            D => D_tb,
            Y => Y_tb
        );

    stim_proc: process
    begin
        for i in 0 to 7 loop
            S_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        D_tb <= "11110000";
        for i in 0 to 7 loop
            S_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        wait;
    end process;
end behavior;

