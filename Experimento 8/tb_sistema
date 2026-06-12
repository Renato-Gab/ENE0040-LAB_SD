library IEEE;
use IEEE.std_logic_1164.all;

entity sistema_tempo_tb is
-- Testbench não possui portas externas
end sistema_tempo_tb;

architecture sim of sistema_tempo_tb is

    -- Componente 1: Contador BCD 100
    component CONTADORBCD100 is
        port (
            clock  : in  std_logic;
            reset  : in  std_logic;
            enable : in  std_logic;
            rci    : in  std_logic;
            load   : in  std_logic;
            d_uni  : in  std_logic_vector(3 downto 0);
            d_dez  : in  std_logic_vector(3 downto 0);
            Q_uni  : out std_logic_vector(3 downto 0);
            Q_dez  : out std_logic_vector(3 downto 0);
            RCO    : out std_logic
        );
    end component;

    -- Componente 2: Timeflags
    component timeflags is
        port (
            dezena  : in  std_logic_vector(3 downto 0);
            unidade : in  std_logic_vector(3 downto 0);
            T5      : out std_logic;
            T6      : out std_logic;
            T20     : out std_logic;
            T60     : out std_logic
        );
    end component;

    -- Sinais de teste (Testbench)
    signal clk_tb   : std_logic := '0';
    signal rst_tb   : std_logic := '0';
    signal q_uni_tb : std_logic_vector(3 downto 0);
    signal q_dez_tb : std_logic_vector(3 downto 0);
    signal dummy_rco: std_logic;

    -- Saídas dos sinalizadores de tempo que queremos observar
    signal T5_tb    : std_logic;
    signal T6_tb    : std_logic;
    signal T20_tb   : std_logic;
    signal T60_tb   : std_logic;

    -- 1 ciclo de clock = 10 ns (representando 1 segundo na simulação)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciação do Contador Módulo 100
    U1_Contador: CONTADORBCD100
        port map (
            clock  => clk_tb,
            reset  => rst_tb,
            enable => '0',         -- Ativo em baixo: Garante contagem contínua
            rci    => '0',         -- Ativo em baixo: Garante contagem contínua
            load   => '0',         -- Desativado
            d_uni  => "0000",      
            d_dez  => "0000",
            Q_uni  => q_uni_tb,   
            Q_dez  => q_dez_tb,     
            RCO    => dummy_rco
        );

    -- Instanciação do Bloco de Flags conectado nas saídas do contador
    U2_Timeflags: timeflags
        port map (
            dezena  => q_dez_tb,
            unidade => q_uni_tb,
            T5      => T5_tb,
            T6      => T6_tb,
            T20     => T20_tb,
            T60     => T60_tb
        );

    -- Processo Gerador de Clock
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Processo de Estímulo
    stim_process : process
    begin
        -- Dá um pulso inicial de Reset para zerar o contador
        rst_tb <= '1';
        wait for CLK_PERIOD * 1.5;
        rst_tb <= '0';
        
        -- Agora deixamos o contador rodar livremente por 65 ciclos de clock
        -- para dar tempo de passar por todas as metas (5s, 6s, 20s e 60s).
        wait for CLK_PERIOD * 65;

        -- Finaliza a simulação
        wait;
    end process;

end sim;
