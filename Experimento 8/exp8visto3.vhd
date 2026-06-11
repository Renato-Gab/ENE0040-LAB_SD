library IEEE;
use IEEE.std_logic_1164.all;

entity exp8visto3 is
    port (
        clock          : in  std_logic;
        reset          : in  std_logic;
        ligadesliga    : in  std_logic;
        sensorA        : in  std_logic;
        sensorB        : in  std_logic;
        semaforoA      : out std_logic_vector(2 downto 0);
        semaforoB      : out std_logic_vector(2 downto 0);
        contador_uni   : out std_logic_vector(3 downto 0); -- Unidades do display
        contador_dez   : out std_logic_vector(3 downto 0)  -- Dezenas do display
    );
end exp8visto3;

architecture structural of exp8visto3 is

    -- Componente Contador 100 fornecido
    component CONTADORBCD100 is
        port (
            clock: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            rci: in std_logic;
            load: in std_logic;
            d_uni: in std_logic_vector(3 downto 0);
            d_dez: in std_logic_vector(3 downto 0);
            Q_uni: out std_logic_vector(3 downto 0);
            Q_dez: out std_logic_vector(3 downto 0);
            RCO: out std_logic
        );
    end component;

    -- Componente Timeflags criado na questão 2
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

    -- Componente Máquina de Estados criado nesta questão
    component maqestados is
        port (
            clock        : in  std_logic;
            reset        : in  std_logic;
            ligadesliga  : in  std_logic;
            sensorA      : in  std_logic;
            sensorB      : in  std_logic;
            T5           : in  std_logic;
            T6           : in  std_logic;
            T20          : in  std_logic;
            T60          : in  std_logic;
            semaforoA    : out std_logic_vector(2 downto 0);
            semaforoB    : out std_logic_vector(2 downto 0);
            resetcounter : out std_logic
        );
    end component;

    -- Sinais internos de interconexão
    signal q_unidades, q_dezenas : std_logic_vector(3 downto 0);
    signal w_T5, w_T6, w_T20, w_T60 : std_logic;
    signal w_resetcounter           : std_logic;
    signal combo_reset_contador     : std_logic;
    signal dummy_rco                : std_logic;

begin

    -- O contador deve resetar caso ocorra o Reset Geral OU se a FSM pedir para resetar
    combo_reset_contador <= reset or w_resetcounter;

    -- Envia a contagem atual diretamente para as saídas do sistema do Display
    contador_uni <= q_unidades;
    contador_dez <= q_dezenas;

    -- Instanciação do Contador 100
    U1_Contador: CONTADORBCD100
        port map (
            clock  => clock,
            reset  => combo_reset_contador, -- Reset controlado pelo sistema e FSM
            enable => '1',
            rci    => '1',
            load   => '0',
            d_uni  => "0000",
            d_dez  => "0000",
            Q_uni  => q_unidades,
            Q_dez  => q_dezenas,
            RCO    => dummy_rco
        );

    -- Instanciação dos Timeflags (Identificadores de tempo)
    U2_Timeflags: timeflags
        port map (
            dezena  => q_dezenas,
            unidade => q_unidades,
            T5      => w_T5,
            T6      => w_T6,
            T20     => w_T20,
            T60     => w_T60
        );

    -- Instanciação do Bloco de Controle (Máquina de Estados)
    U3_MaqEstados: maqestados
        port map (
            clock        => clock,
            reset        => reset,
            ligadesliga  => ligadesliga,
            sensorA      => sensorA,
            sensorB      => sensorB,
            T5           => w_T5,
            T6           => w_T6,
            T20          => w_T20,
            T60          => w_T60,
            semaforoA    => semaforoA,
            semaforoB    => semaforoB,
            resetcounter => w_resetcounter
        );

end structural;

