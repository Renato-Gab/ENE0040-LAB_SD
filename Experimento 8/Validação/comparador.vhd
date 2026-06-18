library ieee;
use ieee.std_logic_1164.all;

entity comparador is
    Port (
        horas_unidade_gm, horas_dezena_gm       : in std_logic_vector(3 downto 0);
        minutos_unidade_gm, minutos_dezena_gm   : in std_logic_vector(3 downto 0);
        segundos_unidade_gm, segundos_dezena_gm : in std_logic_vector(3 downto 0);

        horas_unidade_dut, horas_dezena_dut       : in std_logic_vector(3 downto 0);
        minutos_unidade_dut, minutos_dezena_dut   : in std_logic_vector(3 downto 0);
        segundos_unidade_dut, segundos_dezena_dut : in std_logic_vector(3 downto 0);

        erro_horas, erro_minutos, erro_segundos : out std_logic
    );
end comparador;

architecture comportamento of comparador is
begin
    erro_horas <= '1' when (horas_unidade_gm /= horas_unidade_dut) or (horas_dezena_gm /= horas_dezena_dut) else '0';
    
    erro_minutos <= '1' when (minutos_unidade_gm /= minutos_unidade_dut) or (minutos_dezena_gm /= minutos_dezena_dut) else '0';
    
    erro_segundos <= '1' when (segundos_unidade_gm /= segundos_unidade_dut) or (segundos_dezena_gm /= segundos_dezena_dut) else '0';

end comportamento;