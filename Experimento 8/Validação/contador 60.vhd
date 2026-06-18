library ieee;
use ieee.std_logic_1164.all;

entity mod60 is
    port ( clk     : in  std_logic;
           reset   : in  std_logic;
           enable  : in  std_logic;
           dezena  : out std_logic_vector(3 downto 0);
           unidade : out std_logic_vector(3 downto 0);
           rco     : out std_logic);
end mod60;

architecture Estrutural of mod60 is

    signal s_carry_unidade : std_logic;

begin

    UNIDADES: entity work.mod10
        port map ( 
            clk    => clk,
            reset  => reset,
            enable => enable,
            Q      => unidade,
            RCO    => s_carry_unidade
        );

    DEZENAS: entity work.mod6
        port map ( 
            clk    => clk, 
            reset  => reset, 
            enable => s_carry_unidade,
            Q      => dezena,
            RCO    => RCO
        );

end Estrutural;
