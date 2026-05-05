library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity topmodel is
end topmodel;

architecture topmodel_arch of topmodel is

    component testbench is
        port (
            S_out : out std_logic_vector(2 downto 0);
            D_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component dut_mux is
        port (
            selector: in std_logic_vector(2 downto 0);
            input:    in std_logic_vector(7 downto 0);
            output:   out std_logic
        );
    end component;

    component mux is
        port (
            S: in std_logic_vector(2 downto 0);
            D: in std_logic_vector(7 downto 0);
            Y: out std_logic
        );
    end component;

    signal s_sel  : std_logic_vector(2 downto 0) := (others => '0');
    signal s_data : std_logic_vector(7 downto 0) := (others => '0');
    signal y_dut  : std_logic := '0';
    signal y_gm   : std_logic := '0';
    signal erro   : std_logic;

begin

    inst_tb: testbench 
        port map (S_out => s_sel, D_out => s_data);

    inst_dut: dut_mux 
        port map (selector => s_sel, input => s_data, output => y_dut);

    inst_gm: mux 
        port map (S => s_sel, D => s_data, Y => y_gm);

    erro <= y_dut xor y_gm;

end topmodel_arch;
