library IEEE;
use IEEE.std_logic_1164.all;

entity TOP_VERIFICACAO_TB is
    port (
        clk_out   : out std_logic;
        rst_out   : out std_logic;
        en_out    : out std_logic;
        rci_out   : out std_logic;
        load_out  : out std_logic;
        d_uni_out : out std_logic_vector(3 downto 0);
        d_dez_out : out std_logic_vector(3 downto 0)
    );
end TOP_VERIFICACAO_TB;

architecture BEHAVIORAL of TOP_VERIFICACAO_TB is

    -- DECLARAÇÃO DE TODOS OS SINAIS INTERNOS (O que estava faltando!)
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    signal en_tb     : std_logic := '0';
    signal rci_tb    : std_logic := '0';
    signal load_tb   : std_logic := '0';
    signal d_uni_tb  : std_logic_vector(3 downto 0) := (others => '0');
    signal d_dez_tb  : std_logic_vector(3 downto 0) := (others => '0');

    -- Período do Clock (50 MHz)
    constant CLK_PERIOD : time := 20 ns;

begin

    -- Geração do Clock
    process
    begin
        clk_tb <= '0'; 
        wait for CLK_PERIOD/2;
        clk_tb <= '1'; 
        wait for CLK_PERIOD/2;
    end process;

    -- Processo de Estímulos (Gera os sinais de teste)
    process
    begin
        -- Estado Inicial / Reset
        rst_tb  <= '1';
        en_tb   <= '0'; 
        rci_tb  <= '0'; 
        load_tb <= '0';
        wait for CLK_PERIOD * 2;
        
        -- Libera o Reset para começar a contar
        rst_tb <= '0';
        wait for CLK_PERIOD * 120;

        -- Teste de LOAD (Forçando o número 42)
        d_uni_tb <= "0010"; -- 2
        d_dez_tb <= "0100"; -- 4
        load_tb  <= '1';
        wait for CLK_PERIOD;
        load_tb  <= '0';
        
        wait for CLK_PERIOD * 20;
        wait; -- Para a simulação aqui
    end process;

    -- Atribuição das saídas para conectar com o seu Top Module
    clk_out   <= clk_tb;
    rst_out   <= rst_tb;
    en_out    <= en_tb;
    rci_out   <= rci_tb;
    load_out  <= load_tb;
    d_uni_out <= d_uni_tb;
    d_dez_out <= d_dez_tb;

end BEHAVIORAL;
