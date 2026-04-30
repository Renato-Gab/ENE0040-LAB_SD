library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity questao1_tb is
end questao1_tb;

architecture tb_arch of questao1_tb is

    signal t_A, t_B, t_C : std_logic;
    signal t_X, t_Y      : std_logic;

begin

    UUT: entity work.questao1
        port map (
            A => t_A,
            B => t_B,
            C => t_C,
            X => t_X,
            Y => t_Y
        );

    stim_proc: process
    begin
        for i in 0 to 7 loop
            (t_A, t_B, t_C) <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end tb_arch;
