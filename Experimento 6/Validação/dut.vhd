library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_jk_dut is
    Port ( clk, rst : in STD_LOGIC; J, K : in STD_LOGIC; Q : out STD_LOGIC );
end ff_jk_dut;

architecture Behavioral of ff_jk_dut is
    signal q_state : STD_LOGIC := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            q_state <= '0';
        elsif rising_edge(clk) then
            if (J = '0' and K = '0') then
                q_state <= q_state;         -- Mantém estado
            elsif (J = '0' and K = '1') then
                q_state <= '0';             -- Reset (grava 0)
            elsif (J = '1' and K = '0') then
                q_state <= '1';             -- Set (grava 1)
            elsif (J = '1' and K = '1') then
                q_state <= not q_state;     -- Alterna (Toggle)
            end if;
        end if;
    end process;
    Q <= q_state;
end Behavioral;
