------------------ Top module ------------------
-- A onda vai ficar enorme então roda por uns 2 ms (com M em vez de N, milisegundo); os sinais mais embaixo da onda são do comparador, que vai ficar sempre 0 (porque os dois relógios são iguais)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_relogio_completo is
end tb_relogio_completo;

architecture sim of tb_relogio_completo is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal horas_dezena_dut, horas_unidade_dut       : std_logic_vector(3 downto 0);
    signal minutos_dezena_dut, minutos_unidade_dut   : std_logic_vector(3 downto 0);
    signal segundos_dezena_dut, segundos_unidade_dut : std_logic_vector(3 downto 0);

    signal horas_dezena_gm, horas_unidade_gm       : std_logic_vector(3 downto 0);
    signal minutos_dezena_gm, minutos_unidade_gm   : std_logic_vector(3 downto 0);
    signal segundos_dezena_gm, segundos_unidade_gm : std_logic_vector(3 downto 0);

    signal erro_horas, erro_minutos, erro_segundos : std_logic;

begin

    clk <= not clk after 10 ns;

    RELOGIO: entity work.relogio
        port map (
            clock => clk,
            reset   => reset,
	    enable => '1',
            horas_dezena => horas_dezena_dut,   horas_unidade => horas_unidade_dut,
            minutos_dezena   => minutos_dezena_dut, minutos_unidade   => minutos_unidade_dut,
            segundos_dezena   => segundos_dezena_dut, segundos_unidade  => segundos_unidade_dut
        );

    RELOGIO_GM: entity work.relogio_gm
        port map (
            clock => clk,
            reset   => reset,
            horas_d => horas_dezena_gm,   horas_u => horas_unidade_gm,
            min_d   => minutos_dezena_gm, min_u   => minutos_unidade_gm,
            seg_d   => segundos_dezena_gm, seg_u  => segundos_unidade_gm
        );

    COMPARADOR: entity work.comparador
        port map (
            horas_dezena_dut    => horas_dezena_dut,    horas_unidade_dut    => horas_unidade_dut,
            minutos_dezena_dut  => minutos_dezena_dut,  minutos_unidade_dut  => minutos_unidade_dut,
            segundos_dezena_dut => segundos_dezena_dut, segundos_unidade_dut => segundos_unidade_dut,
            
            horas_dezena_gm     => horas_dezena_gm,     horas_unidade_gm     => horas_unidade_gm,
            minutos_dezena_gm   => minutos_dezena_gm,   minutos_unidade_gm   => minutos_unidade_gm,
            segundos_dezena_gm  => segundos_dezena_gm,  segundos_unidade_gm  => segundos_unidade_gm,
            
            erro_horas => erro_horas,
	    erro_minutos => erro_minutos,
	    erro_segundos => erro_segundos
        );

    process
    begin
        reset <= '1';
        wait for 15 ns;
        reset <= '0';
        
        wait for 1800000 ns;
        wait;
    end process;

end sim;
