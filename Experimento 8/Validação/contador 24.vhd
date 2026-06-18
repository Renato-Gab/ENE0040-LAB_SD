library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod24 is
    port ( clk          : in  std_logic;
           reset        : in  std_logic;
           enable       : in  std_logic;
           dezena_hora  : out std_logic_vector (3 downto 0);
           unidade_hora : out std_logic_vector (3 downto 0));
end mod24;

architecture rtl of mod24 is
    signal dezena  : unsigned(3 downto 0) := "0000";
    signal unidade : unsigned(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                dezena  <= "0000";
                unidade <= "0000";
            elsif enable = '1' then
                if dezena = 2 and unidade = 3 then
                    dezena  <= "0000";
                    unidade <= "0000";
                elsif unidade = 9 then 
                    dezena  <= dezena + 1;
                    unidade <= "0000";
                else
                    unidade <= unidade + 1;
                end if;
            end if;
        end if;
    end process;

    dezena_hora  <= std_logic_vector(dezena);
    unidade_hora <= std_logic_vector(unidade);
end rtl;
                  
               
