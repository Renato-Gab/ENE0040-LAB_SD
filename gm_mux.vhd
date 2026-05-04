library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity gm_mux is
	port (selector: in std_logic_vector(2 downto 0);
    	      input: in std_logic_vector(7 downto 0);
    	      output: out std_logic);
end gm_mux;

architecture gm_mux_arch of gm_mux is

component MUX8X1 is
    port (S: in std_logic_vector(2 downto 0);
    D: in std_logic_vector(7 downto 0);
    Y: out std_logic);
end component;

begin
	G_MODEL: MUX8X1
	port map(D => input,
	S => selector,
	Y => output);
end gm_mux_arch;




