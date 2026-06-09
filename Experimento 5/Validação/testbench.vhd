library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_driver is
    Port ( 
        -- O testbench envia os estímulos
        A_stim        : out STD_LOGIC_VECTOR(3 downto 0);
        -- O testbench recebe as respostas para comparar
        out_dut_bits  : in  STD_LOGIC;
        out_gm_bits   : in  STD_LOGIC;
        out_subtracao : out STD_LOGIC
    );
end testbench_driver;

architecture Behavioral of testbench_driver is
begin

    process
    begin
        report "Testbench Driver iniciado com monitoramento de onda..." severity note;

        for i in 0 to 15 loop
            -- Envia o estímulo atual
            A_stim <= std_logic_vector(to_unsigned(i, 4));
            
            wait for 1 ns;
            
            out_subtracao <= out_dut_bits xor out_gm_bits;
            
            wait for 9 ns; 
  
            assert ((out_dut_bits xor out_gm_bits) = '0')
                report "ERRO! Divergencia encontrada na entrada: " & integer'image(i)
                severity failure;
                
        end loop;

        report "SUCESSO! DUT e GM sao identicos em todas as ondas." severity note;
        wait; 
    end process;

end Behavioral;
