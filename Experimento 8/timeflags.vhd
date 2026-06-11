library IEEE;
use IEEE.std_logic_1164.all;

entity timeflags is
    port (
        dezena  : in  std_logic_vector(3 downto 0); 
        unidade : in  std_logic_vector(3 downto 0);
        T5      : out std_logic;                    
        T6      : out std_logic;                   
        T20     : out std_logic;                    
        T60     : out std_logic                     
    );
end timeflags;

architecture behavior of timeflags is
    -- Sinal interno de 8 bits para juntar a dezena e a unidade
    signal tempo_bcd : std_logic_vector(7 downto 0);
begin

    -- Concatena os 4 bits da dezena com os 4 bits da unidade
    tempo_bcd <= dezena & unidade;

    T5  <= '1' when tempo_bcd = x"05" else '0';
    T6  <= '1' when tempo_bcd = x"06" else '0';
    T20 <= '1' when tempo_bcd = x"20" else '0';
    T60 <= '1' when tempo_bcd = x"60" else '0';

end behavior;
