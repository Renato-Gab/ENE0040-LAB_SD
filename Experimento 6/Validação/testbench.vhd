library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_driver is
    Port ( 
        clk_out       : out STD_LOGIC;
        rst_out       : out STD_LOGIC;
        D_stim        : out STD_LOGIC;
        out_dut_q     : in  STD_LOGIC;
        out_gm_q      : in  STD_LOGIC;
        out_subtracao : out STD_LOGIC
    );
end testbench_driver;

architecture Behavioral of testbench_driver is
    signal clk_internal : STD_LOGIC := '0';
begin

    -- 1. Gerador de Clock (Inverte a cada 5 ns -> Período de 10 ns)
    clk_internal <= not clk_internal after 5 ns;
    clk_out      <= clk_internal;

    -- 2. Comparador que vai direto para o gráfico de ondas
    out_subtracao <= out_dut_q xor out_gm_q;

    -- 3. Processo de Estímulos
    process
    begin
        report "Testbench do Flip-Flop iniciado..." severity note;

        -- Passo 1: Aplica o Reset inicial
        rst_out <= '1';
        D_stim  <= '0';
        wait for 12 ns; -- Espera passar a primeira borda de subida
        
        -- Passo 2: Libera o Reset
        rst_out <= '0';
        wait for 10 ns;

        -- Passo 3: Testar gravar '1'
        D_stim <= '1';
        wait for 10 ns; 
        assert ((out_dut_q xor out_gm_q) = '0') report "ERRO ao gravar 1!" severity failure;

        -- Passo 4: Manter em '1' para ver se continua estável
        wait for 10 ns;
        assert ((out_dut_q xor out_gm_q) = '0') report "ERRO em manter 1!" severity failure;

        -- Passo 5: Testar gravar '0'
        D_stim <= '0';
        wait for 10 ns;
        assert ((out_dut_q xor out_gm_q) = '0') report "ERRO ao gravar 0!" severity failure;

        -- Passo 6: Ativar o Reset com D em '1' para testar a prioridade do Reset
        D_stim  <= '1';
        rst_out <= '1';
        wait for 10 ns;
        assert ((out_dut_q xor out_gm_q) = '0') report "ERRO no Reset assíncrono!" severity failure;

        report "SUCESSO! O Flip-Flop D feito com JK (DUT) e o D nativo (GM) responderam igual." severity note;
        wait; -- Finaliza a simulação
    end process;

end Behavioral;
