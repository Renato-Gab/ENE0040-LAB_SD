library IEEE;
use IEEE.std_logic_1164.all;

entity sistema_semaforo is
    port (
        clock : in  std_logic;
        reset : in  std_logic;
        T5    : out std_logic;
        T6    : out std_logic;
        T20   : out std_logic;
        T60   : out std_logic
    );
end sistema_semaforo;

architecture arch of sistema_semaforo is
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

    -- Sinais internos para interconectar o Contador ao Timeflags
    signal sig_uni : std_logic_vector(3 downto 0);
    signal sig_dez : std_logic_vector(3 downto 0);
    signal sig_rco : std_logic; 

begin

   
    inst_contador: CONTADORBCD100 
        port map (
            clock  => clock,
            reset  => reset,
            enable => '1',         -- Sempre habilitado para contar
            rci    => '1',         -- Ripple Carry Input ativo
            load   => '0',         -- Desabilita a carga paralela
            d_uni  => "0000",      -- Entradas de dados zeradas
            d_dez  => "0000",
            Q_uni  => sig_uni,     -- Conecta à unidade do timeflags
            Q_dez  => sig_dez,     -- Conecta à dezena do timeflags
            RCO    => sig_rco
        );

    -- Instanciação do bloco de Flags de Tempo
    inst_flags: timeflags 
        port map (
            dezena  => sig_dez,
            unidade => sig_uni,
            T5      => T5,
            T6      => T6,
            T20     => T20,
            T60     => T60
        );

end arch;

