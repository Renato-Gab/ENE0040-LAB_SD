library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessário para as conversões de loop

entity tb_compare_mux is
-- Testbench não tem portas
end tb_compare_mux;

architecture behavioral of tb_compare_mux is

    -- Componente 1: O estrutural (dut_mux)
    component dut_mux is
        port (selector: in std_logic_vector(2 downto 0);
              input   : in std_logic_vector(7 downto 0);
              output  : out std_logic);
    end component;

    -- Componente 2: O comportamental (meucircuito1)
    component meucircuito1 is
        port (S: in std_logic_vector(2 downto 0);
              D: in std_logic_vector(7 downto 0);
              Y: out std_logic);
    end component;

    -- Sinais internos para conectar os componentes
    signal s_sel           : std_logic_vector(2 downto 0) := (others => '0');
    signal s_data          : std_logic_vector(7 downto 0) := (others => '0');
    signal out_estrutural  : std_logic;
    signal out_comportamental : std_logic;

begin

    -- Instância do MUX Estrutural
    DUT_STR: dut_mux port map (
        selector => s_sel,
        input    => s_data,
        output   => out_estrutural
    );

    -- Instância do MUX Comportamental
    DUT_BEH: meucircuito1 port map (
        S => s_sel,
        D => s_data,
        Y => out_comportamental
    );

    -- Processo de Estímulo e Comparação
    stim_proc: process
    begin
        -- Loop externo percorre todos os valores do seletor (0 a 7)
        for i in 0 to 7 loop
            -- Loop interno percorre todas as combinações de dados (0 a 255)
            for j in 0 to 255 loop
                
                s_sel  <= std_logic_vector(to_unsigned(i, 3));
                s_data <= std_logic_vector(to_unsigned(j, 8));
                
                wait for 10 ns; -- Tempo para os sinais propagarem
                
                -- Verificação Automática (Assertion)
                assert (out_estrutural = out_comportamental)
                    report "ERRO: Saídas divergem! Sel=" & integer'image(i) & " Data=" & integer'image(j)
                    severity failure;
                    
            end loop;
        end loop;

        report "Sucesso! Ambos os circuitos sao logicamente equivalentes para todos os casos.";
        wait; -- Finaliza a simulação
    end process;

end behavioral;
