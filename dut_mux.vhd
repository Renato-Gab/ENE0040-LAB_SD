library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dut_mux is
	port (selector: in std_logic_vector(2 downto 0);
    	      input: in std_logic_vector(7 downto 0);
    	      output: out std_logic);
end dut_mux;

architecture dut_mux_arch of dut_mux is

component multiplexador is
	port(S: in std_logic_vector (1 downto 0);
	     D: in std_logic_vector (3 downto 0);
	     Y: out std_logic);
end component;

signal w1,w2 : std_logic;
signal f: std_logic_vector(3 downto 0);
signal f_s: std_logic_vector(1 downto 0);

begin
	MUX_A: multiplexador
		port map(D => input(3 downto 0),
			 S => selector(1 downto 0),
			 Y => w1
		);
	MUX_B: multiplexador
		port map(D => input(7 downto 4),
			 S => selector(1 downto 0),
			 Y => w2
		);
	f <= "00" & w2 & w1;
	f_s <= '0' & selector(2);
	
	MUX_F: multiplexador
		port map (D => f,
			  S => f_s,
			  Y => output
		);
end dut_mux_arch;