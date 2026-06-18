library ieee;
use ieee.std_logic_1164.all;

entity relogio is
    Port (
        clock  : in std_logic;
        reset  : in std_logic;
        enable : in std_logic;
        horas_dezena     : out std_logic_vector(3 downto 0);
        horas_unidade    : out std_logic_vector(3 downto 0);
        minutos_dezena   : out std_logic_vector(3 downto 0);
        minutos_unidade  : out std_logic_vector(3 downto 0);
        segundos_dezena  : out std_logic_vector(3 downto 0);
        segundos_unidade : out std_logic_vector(3 downto 0)
    );
end relogio;

architecture comportamento of relogio is

    signal carry_minutos  : std_logic;
    signal carry_segundos : std_logic;

begin
    
    HORAS: entity work.mod24
        port map (
            clk     => clock,
            reset   => reset,
            enable  => carry_minutos,
            dezena_hora  => horas_dezena,
            unidade_hora => horas_unidade
        );
    
    MINUTOS: entity work.mod60
        port map (
            clk     => clock,
            reset   => reset,
            enable  => carry_segundos,
            dezena  => minutos_dezena,
            unidade => minutos_unidade,
            rco     => carry_minutos
        );
    
    SEGUNDOS: entity work.mod60
        port map (
            clk     => clock,
            reset   => reset,
            enable  => enable,
            dezena  => segundos_dezena,
            unidade => segundos_unidade,
            rco     => carry_segundos
        );

end comportamento;