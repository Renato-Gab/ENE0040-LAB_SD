library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity TESTBENCH is
    port (
        DUT_out, GM_out: in std_logic_vector(4 downto 0);
        A, B: out std_logic_vector(3 downto 0)
    );
end TESTBENCH;

architecture TESTBENCH_ARCH of TESTBENCH is
begin
    process
        variable currA : std_logic_vector(3 downto 0);
        variable currB : std_logic_vector(3 downto 0);
    begin
        report "Iniciando teste..." severity NOTE;

        currA := "0000";
        for i in 0 to 15 loop
            A <= currA;
            currB := "0000";
            for j in 0 to 15 loop
                B <= currB;
                wait for 500 ns;

                assert (DUT_out = GM_out) report "Falhou em A = " & integer'image(i) & " e B = " & integer'image(j) severity ERROR;
                
                currB := currB + 1;
            end loop;
            currA := currA + 1;
        end loop;

        report "Teste finalizado." severity NOTE;

        wait;
    end process;
end TESTBENCH_ARCH;
