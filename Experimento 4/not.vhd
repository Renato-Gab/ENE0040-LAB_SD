library ieee;
use ieee.std_logic_1164.all;

-- Porta logica NOT
entity gatenot is
    port (
        A: in std_logic;
        Y: out std_logic 
    );
end gatenot;

architecture gatenote_arch of gatenot is
begin
    Y <= not A;
end gatenot_arch;
