library IEEE;
use IEEE.std_logic_1164.all;

entity exp8visto3_tb is
-- Testbench não possui portas externas
end exp8visto3_tb;

architecture sim of exp8visto3_tb is

    -- Declaração do Componente do Sistema Completo (UUT)
    component exp8visto3 is
        port (
            clock          : in  std_logic;
            reset          : in  std_logic;
            ligadesliga    : in  std_logic;
            sensorA        : in  std_logic;
            sensorB        : in  std_logic;
            semaforoA      : out std_logic_vector(2 downto 0);
            semaforoB      : out std_logic_vector(2 downto 0);
            contador_uni   : out std_logic_vector(3 downto 0);
            contador_dez   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Sinais para conectar na UUT
    signal clk_tb         : std_logic := '0';
    signal rst_tb         : std_logic := '0';
    signal ligadesliga_tb : std_logic := '1'; -- Começa ligado (funcionamento normal)
    signal sensorA_tb     : std_logic := '0';
    signal sensorB_tb     : std_logic := '0';
    signal semaforoA_tb   : std_logic_vector(2 downto 0);
    signal semaforoB_tb   : std_logic_vector(2 downto 0);
    signal uni_tb         : std_logic_vector(3 downto 0);
    signal dez_tb         : std_logic_vector(3 downto 0);

    -- 1 ciclo de clock = 10 ns (representando 1 segundo do mundo real)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instanciação do Sistema Completo
    UUT: exp8visto3
        port map (
            clock          => clk_tb,
            reset          => rst_tb,
            ligadesliga    => ligadesliga_tb,
            sensorA        => sensorA_tb,
            sensorB        => sensorB_tb,
            semaforoA      => semaforoA_tb,
            semaforoB      => semaforoB_tb,
            contador_uni   => uni_tb,
            contador_dez   => dez_tb
        );

    -- Gerador de Clock (1Hz simulado em passos de 10ns)
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Processo de Estímulos (Cenários de Teste)
    stim_process : process
    begin
        ----------------------------------------------------------------
        -- Passo 1: Reset Inicial do Sistema
        ----------------------------------------------------------------
        rst_tb <= '1';
        wait for CLK_PERIOD * 2;
        rst_tb <= '0';
        
        -- Estado inicial esperado: 
        -- SemaforoA = Verde ("001"), SemaforoB = Vermelho ("100")
        -- O contador começa a subir a partir de 00.
        
        ----------------------------------------------------------------
        -- Passo 2: Testar a exceção de corte aos 20s (Carro em B esperando)
        ----------------------------------------------------------------
        -- Deixa o tempo passar até chegar em 25 segundos (25 ciclos de clock)
        wait for CLK_PERIOD * 25;
        
        -- Passou de 20s. Ativamos o sensorB (carro esperando na pista oposta)
        sensorB_tb <= '1';
        sensorA_tb <= '0';
        wait for CLK_PERIOD; 
        
        -- Como a condição foi atendida, a FSM deve mudar na hora para AMARELO em A ("010")
        -- e o contador interno deve resetar para "00" para contar os 6s do amarelo.
        sensorB_tb <= '0'; -- Carro passou, limpa o sensor
        
        -- Espera os 6s do Amarelo + 5s do Vermelho Ambos (Total: 11 ciclos de clock)
        wait for CLK_PERIOD * 11;
        
        -- Agora o SemaforoB abriu (Verde "001") e o SemaforoA fechou (Vermelho "100")
        -- O contador resetou e começou a contar o tempo da pista B aberta.

        ----------------------------------------------------------------
        -- Passo 3: Testar o tempo limite regulamentar de 60 segundos
        ----------------------------------------------------------------
        -- Deixamos o semáforo B aberto sem nenhum sensor ativo. Ele deve estourar por tempo.
        wait for CLK_PERIOD * 61;
        
        -- Após os 60s, ele vai sozinho para o Amarelo em B (6s) -> Vermelho Ambos (5s) -> Abre A de novo.
        wait for CLK_PERIOD * 11;

        ----------------------------------------------------------------
        -- Passo 4: Testar o Modo Intermitente (Chave Liga/Desliga)
        ----------------------------------------------------------------
        ligadesliga_tb <= '0'; -- Desliga o sistema
        
        -- Espera 5 ciclos para ver o amarelo piscando (Luz "010" -> "000" -> "010" a cada ciclo)
        wait for CLK_PERIOD * 5;
        
        ligadesliga_tb <= '1'; -- Religa o sistema (deve voltar ao fluxo normal)
        wait for CLK_PERIOD * 10;

        -- Finaliza a simulação
        wait;
    end process;

end sim;
