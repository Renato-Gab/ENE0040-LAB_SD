library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity questao1 is
    port (
        A, B, C : in std_logic;
        X, Y    : out std_logic
    );
end questao1;

architecture questao1_arch of questao1 is

    component multiplexador is
        port (
            S : in std_logic_vector(1 downto 0);
            D : in std_logic_vector(3 downto 0);
            Y : out std_logic
        );
    end component;

    component gatenot is
        port (
            A : in std_logic;
            Y : out std_logic
        );
    end component;

    signal setvect      : std_logic_vector(1 downto 0);
    signal data1, data2 : std_logic_vector(3 downto 0);
    signal notC         : std_logic;

begin

    setvect(0) <= B;
    setvect(1) <= A;

    INT1 : gatenot 
        port map (
            A => C, 
            Y => notC
        );

    data1(0) <= '0';
    data1(1) <= C;
    data1(2) <= notC;
    data1(3) <= '1';

    data2(0) <= '1';
    data2(1) <= notC;
    data2(2) <= '0';
    data2(3) <= C;

    INT2 : multiplexador 
        port map (
            S => setvect, 
            D => data2, 
            Y => Y
        );

    INT3 : multiplexador 
        port map (
            S => setvect, 
            D => data1, 
            Y => X
        );
end questao1_arch;
