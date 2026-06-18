library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod6 is
    port ( clk    : in  std_logic;
           reset  : in  std_logic;
           enable : in  std_logic;
           q      : out std_logic_vector (3 downto 0);
           rco    : out std_logic);
end mod6;

architecture rtl of mod6 is
    signal count : unsigned(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count <= "0000";
            elsif enable = '1' then
                if count = 5 then
                    count <= "0000";
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    Q <= std_logic_vector(count);
    RCO <= '1' when (count = 5 and enable = '1') else '0';
end rtl;
