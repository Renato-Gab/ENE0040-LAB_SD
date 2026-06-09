library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
end top_module;

architecture Structural of top_module is

    component testbench_driver is
        Port ( 
            clk_out       : out STD_LOGIC;
            rst_out       : out STD_LOGIC;
            D_stim        : out STD_LOGIC;
            out_dut_q     : in  STD_LOGIC;
            out_gm_q      : in  STD_LOGIC;
            out_subtracao : out STD_LOGIC
        );
    end component;

    component ff_jk_as_d_dut is
        Port ( 
            clk, rst : in  STD_LOGIC;
            D        : in  STD_LOGIC;
            Q        : out STD_LOGIC
        );
    end component;

    component ff_d_gm is
        Port ( 
            clk, rst : in  STD_LOGIC;
            D        : in  STD_LOGIC;
            Q        : out STD_LOGIC
        );
    end component;

    -- Sinais internos (fios de ligação)
    signal w_clk            : STD_LOGIC;
    signal w_rst            : STD_LOGIC;
    signal w_d              : STD_LOGIC;
    signal w_q_dut          : STD_LOGIC;
    signal w_q_gm           : STD_LOGIC;
    signal w_subtracao_onda : STD_LOGIC;

begin

    -- Instanciação do Testbench
    inst_TB: testbench_driver
        port map (
            clk_out       => w_clk,
            rst_out       => w_rst,
            D_stim        => w_d,
            out_dut_q     => w_q_dut,
            out_gm_q      => w_q_gm,
            out_subtracao => w_subtracao_onda
        );

    -- Instanciação do DUT
    inst_DUT: ff_jk_as_d_dut
        port map (
            clk => w_clk,
            rst => w_rst,
            D   => w_d,
            Q   => w_q_dut
        );

    -- Instanciação do GM
    inst_GM: ff_d_gm
        port map (
            clk => w_clk,
            rst => w_rst,
            D   => w_d,
            Q   => w_q_gm
        );

end Structural;
