library ieee;
use ieee.std_logic_1164.all;

-- Porta logica OR
entity GATEOR is
    port (
        A: in std_logic;
        B: in std_logic;
        Y: out std_logic 
    );
end GATEOR;

architecture GATEOR_ARCH of GATEOR is
begin
    Y <= A or B;
end GATEOR_ARCH;
