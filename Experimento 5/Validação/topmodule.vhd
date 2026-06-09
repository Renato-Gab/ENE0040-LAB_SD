library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
end top_module;

architecture Structural of top_module is

    -- Declaração do componente TESTBENCH (Atualizado)
    component testbench_driver is
        Port ( 
            A_stim        : out STD_LOGIC_VECTOR(3 downto 0);
            out_dut_bits  : in  STD_LOGIC;
            out_gm_bits   : in  STD_LOGIC;
            out_subtracao : out STD_LOGIC
        );
    end component;

    -- Declaração do componente DUT
    component xor_dut is
        Port ( A : in STD_LOGIC_VECTOR(3 downto 0); Ydut : out STD_LOGIC );
    end component;

    -- Declaração do componente GM
    component xor_gm is
        Port ( A : in STD_LOGIC_VECTOR(3 downto 0); Ygm : out STD_LOGIC );
    end component;

    -- Sinais internos (fios de conexão)
    signal w_test_vector       : STD_LOGIC_VECTOR(3 downto 0);
    signal w_res_dut           : STD_LOGIC;
    signal w_res_gm            : STD_LOGIC;
    signal w_subtracao_onda    : STD_LOGIC;

begin

    -- Instancia o TESTBENCH conectando o pino de subtração no nosso fio interno
    inst_TESTBENCH: testbench_driver
        port map (
            A_stim        => w_test_vector,
            out_dut_bits  => w_res_dut,
            out_gm_bits   => w_res_gm,
            out_subtracao => w_subtracao_onda
        );

    -- Instancia o DUT
    inst_DUT: xor_dut 
        port map (
            A => w_test_vector,
            Ydut => w_res_dut
        );

    -- Instancia o GM
    inst_GM: xor_gm 
        port map (
            A => w_test_vector,
            Ygm => w_res_gm
        );

end Structural;
