library IEEE;
use IEEE.std_logic_1164.all;

entity CONTADORBCD100 is
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
end CONTADORBCD100;

architecture CONTADORBCD100_ARCH of CONTADORBCD100 is

    -- Declaração do seu componente fornecido
    component CONTADORBCD10 is
        port (
            clock: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            rci: in std_logic;
            load: in std_logic;
            d: in std_logic_vector(3 downto 0);
            Q: out std_logic_vector(3 downto 0);
            RCO: out std_logic
        );
    end component;

    -- Sinal interno para passar o "vai um" (Ripple Carry) das unidades para as dezenas
    signal uRCO : std_logic;
    signal dRCO : std_logic;

begin

    -- Instância 1: Controla as UNIDADES
    -- Recebe o enable e o rci externos do sistema.
    INT1 : CONTADORBCD10 
        port map(
            clock  => clock, 
            reset  => reset, 
            enable => enable, 
            rci    => rci, 
            load   => load, 
            d      => d_uni, 
            Q      => Q_uni, 
            RCO    => uRCO
        );

    -- Instância 2: Controla as DEZENAS
    -- Só incrementa se o enable geral estiver ativo ('0') E se a unidade chegou em 9 (uRCO = '0').
    INT2 : CONTADORBCD10 
        port map(
            clock  => clock, 
            reset  => reset, 
            enable => enable, 
            rci    => uRCO,  -- O RCO das unidades ativa o rci das dezenas
            load   => load, 
            d      => d_dez, 
            Q      => Q_dez, 
            RCO    => dRCO
        );

    -- O RCO do sistema de 100 bits será ativo em '0' quando ambos chegarem em 99
    RCO <= uRCO or dRCO;

end CONTADORBCD100_ARCH;
