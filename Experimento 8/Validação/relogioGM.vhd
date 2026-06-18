library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity relogio_gm is
    Port ( 
        clock   : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        horas_d : out STD_LOGIC_VECTOR (3 downto 0);
        horas_u : out STD_LOGIC_VECTOR (3 downto 0);
        min_d   : out STD_LOGIC_VECTOR (3 downto 0);
        min_u   : out STD_LOGIC_VECTOR (3 downto 0);
        seg_d   : out STD_LOGIC_VECTOR (3 downto 0);
        seg_u   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end relogio_gm;

architecture Comportamental of relogio_gm is
begin

    process(clock)
        -- Limites estritos mantidos
        variable v_horas    : integer range 0 to 23 := 0;
        variable v_minutos  : integer range 0 to 59 := 0;
        variable v_segundos : integer range 0 to 59 := 0;
    begin
        if rising_edge(clock) then
            if reset = '1' then
                v_horas    := 0;
                v_minutos  := 0;
                v_segundos := 0;
            else
                
                -- Verifica ANTES de somar
                if v_segundos = 59 then
                    v_segundos := 0; -- Zera os segundos
                    
                    if v_minutos = 59 then
                        v_minutos := 0; -- Zera os minutos
                        
                        if v_horas = 23 then
                            v_horas := 0; -- Zera as horas (bateu 24h)
                        else
                            v_horas := v_horas + 1;
                        end if;
                        
                    else
                        v_minutos := v_minutos + 1;
                    end if;
                    
                else
                    -- Contagem normal dos segundos
                    v_segundos := v_segundos + 1;
                end if;
                
            end if;

            -- Converte para BCD para comparar com o DUT
            horas_d <= std_logic_vector(to_unsigned(v_horas / 10, 4));
            horas_u <= std_logic_vector(to_unsigned(v_horas mod 10, 4));
            min_d   <= std_logic_vector(to_unsigned(v_minutos / 10, 4));
            min_u   <= std_logic_vector(to_unsigned(v_minutos mod 10, 4));
            seg_d   <= std_logic_vector(to_unsigned(v_segundos / 10, 4));
            seg_u   <= std_logic_vector(to_unsigned(v_segundos mod 10, 4));
            
        end if;
    end process;

end Comportamental;