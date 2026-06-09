library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_jk_as_d_dut is
    Port ( 
        clk, rst : in  STD_LOGIC;
        D        : in  STD_LOGIC;
        Q        : out STD_LOGIC 
    );
end ff_jk_as_d_dut;

architecture Structural of ff_jk_as_d_dut is
    component ff_jk_core is
        Port ( clk, rst : in STD_LOGIC; J, K : in STD_LOGIC; Q : out STD_LOGIC );
    end component;

    -- Fios internos para conectar nas portas J e K do componente interno
    signal internal_j, internal_k : STD_LOGIC;
begin
    -- AQUI ESTÁ A LÓGICA DE CONVERSÃO
    internal_j <= D;
    internal_k <= not D;

    jk_core_inst: ff_jk_core
        port map (
            clk => clk,
            rst => rst,
            J   => internal_j,
            K   => internal_k,
            Q   => Q
        );
end Structural;
