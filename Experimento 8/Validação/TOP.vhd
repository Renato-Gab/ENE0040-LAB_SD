library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TOP_SISTEMA_COMPLETO is
end TOP_SISTEMA_COMPLETO;

architecture STRUCTURAL of TOP_SISTEMA_COMPLETO is

    component TOP_VERIFICACAO_TB is
        port (
            clk_out   : out std_logic;
            rst_out   : out std_logic;
            en_out    : out std_logic;
            rci_out   : out std_logic;
            load_out  : out std_logic;
            d_uni_out : out std_logic_vector(3 downto 0);
            d_dez_out : out std_logic_vector(3 downto 0)
        );
    end component;

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

    component CONTADORBCD100_GM is
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

    signal clk   : std_logic;
    signal rst   : std_logic;
    signal en    : std_logic;
    signal rci   : std_logic;
    signal load  : std_logic;
    signal d_uni : std_logic_vector(3 downto 0);
    signal d_dez : std_logic_vector(3 downto 0);

    signal Q_uni_dut : std_logic_vector(3 downto 0);
    signal Q_dez_dut : std_logic_vector(3 downto 0);
    signal RCO_dut   : std_logic;

    signal Q_uni_gm  : std_logic_vector(3 downto 0);
    signal Q_dez_gm  : std_logic_vector(3 downto 0);
    signal RCO_gm    : std_logic;

    signal sub_uni   : std_logic_vector(3 downto 0);
    signal sub_dez   : std_logic_vector(3 downto 0);

begin

    INST_TB : TOP_VERIFICACAO_TB
        port map (
            clk_out   => clk,
            rst_out   => rst,
            en_out    => en,
            rci_out   => rci,
            load_out  => load,
            d_uni_out => d_uni,
            d_dez_out => d_dez
        );

    INST_DUT : CONTADORBCD100
        port map (
            clock  => clk,
            reset  => rst,
            enable => en,
            rci    => rci,
            load   => load,
            d_uni  => d_uni,
            d_dez  => d_dez,
            Q_uni  => Q_uni_dut,
            Q_dez  => Q_dez_dut,
            RCO    => RCO_dut
        );

    INST_GM : CONTADORBCD100_GM
        port map (
            clock  => clk,
            reset  => rst,
            enable => en,
            rci    => rci,
            load   => load,
            d_uni  => d_uni,
            d_dez  => d_dez,
            Q_uni  => Q_uni_gm,
            Q_dez  => Q_dez_gm,
            RCO    => RCO_gm
        );

    -- Faz a subtração das saídas dos dois blocos em tempo real
    sub_uni <= std_logic_vector(unsigned(Q_uni_dut) - unsigned(Q_uni_gm));
    sub_dez <= std_logic_vector(unsigned(Q_dez_dut) - unsigned(Q_dez_gm));

end STRUCTURAL;

