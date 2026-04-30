library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity questao2_tb is
end questao2_tb;

architecture tb_arch of questao2_tb is

    signal t_A, t_B, t_C, t_D, t_E, t_F, t_G : std_logic;
    signal t_Z : std_logic;
    signal t_comb : std_logic_vector(6 downto 0);

begin
    UUT: entity work.questao2
        port map (
            A => t_A, B => t_B, C => t_C, D => t_D,
            E => t_E, F => t_F, G => t_G,
            Z => t_Z
        );
    stim_proc: process
    begin
        for i in 0 to 127 loop
            t_comb <= std_logic_vector(to_unsigned(i, 7));
            
            t_A <= t_comb(6);
            t_B <= t_comb(5);
            t_C <= t_comb(4);
            t_D <= t_comb(3);
            t_E <= t_comb(2);
            t_F <= t_comb(1);
            t_G <= t_comb(0);
            
            wait for 10 ns;
        end loop;

        wait;
    end process;
end tb_arch;