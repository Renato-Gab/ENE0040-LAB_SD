library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_mux is
end tb_mux;

architecture teste_mux of tb_mux is
component multiplexador is
	port(S: in std_logic_vector (1 downto 0);
	     D: in std_logic_vector (3 downto 0);
	     Y: out std_logic);
end component;

signal S_tb : std_logic_vector(1 downto 0);
signal D_tb : std_logic_vector(3 downto 0);
signal Y_tb : std_logic;

begin

uut: multiplexador port map(
  S => S_tb,
  D => D_tb,
  Y => Y_tb);

stimulus: process
begin

    D_tb <= "0001";
    S_tb <= "00";
    wait for 10 ns;

    S_tb <= "01";
    wait for 10 ns;

    S_tb <= "10";
    wait for 10 ns;

    S_tb <= "11";
    wait for 10 ns;

    D_tb <= "1010";
    S_tb <= "00";
    wait for 10 ns;

    S_tb <= "01";
    wait for 10 ns;

    S_tb <= "10";
    wait for 10 ns;

    S_tb <= "11";
    wait for 10 ns;
    wait;
end process;
end teste_mux;
