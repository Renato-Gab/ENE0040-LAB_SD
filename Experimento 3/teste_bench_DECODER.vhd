library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder is
end tb_decoder;

architecture behavior of tb_decoder is

    signal A_tb : std_logic_vector(3 downto 0) := "0000";
    signal Y_tb : std_logic_vector(15 downto 0);

begin

    uut: entity work.decoder
        port map (
            A => A_tb,
            Y => Y_tb
        );

    stim_proc: process
    begin
        for i in 0 to 15 loop
            A_tb <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end behavior;