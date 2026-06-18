library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CONTADORBCD100_GM is
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
end CONTADORBCD100_GM;

architecture BEHAVIORAL of CONTADORBCD100_GM is
    signal r_uni : unsigned(3 downto 0) := (others => '0');
    signal r_dez : unsigned(3 downto 0) := (others => '0');
    
    signal c_uni_rco : std_logic;
    signal c_dez_rco : std_logic;
begin

    process(clock, reset)
    begin
        if reset = '1' then
            r_uni <= (others => '0');
            r_dez <= (others => '0');
        elsif rising_edge(clock) then
            if enable = '0' then -- Mantendo a lógica de enable ativo em '0' ou '1' conforme seu projeto
                if load = '1' then -- Se o load for síncrono e ativo em '1'
                    r_uni <= unsigned(d_uni);
                    r_dez <= unsigned(d_dez);
                elsif rci = '0' then -- Só conta se o Ripple Carry Input permitir (ativo em '0')
                    
                    -- Lógica das Unidades usando "+"
                    if r_uni = 9 then
                        r_uni <= (others => '0');
                        
                        -- Lógica das Dezenas usando "+" (só incrementa se a unidade estourar)
                        if r_dez = 9 then
                            r_dez <= (others => '0');
                        else
                            r_dez <= r_dez + 1;
                        end if;
                        
                    else
                        r_uni <= r_uni + 1;
                    end if;
                    
                end if;
            end if;
        end if;
    end process;

    Q_uni <= std_logic_vector(r_uni);
    Q_dez <= std_logic_vector(r_dez);

    -- Lógica combinacional para o RCO (Gera '0' quando atinge 9 nas unidades/dezenas e rci é '0')
    c_uni_rco <= '0' when (r_uni = 9 and rci = '0') else '1';
    c_dez_rco <= '0' when (r_dez = 9 and c_uni_rco = '0') else '1';
  
    RCO <= c_uni_rco or c_dez_rco;

end BEHAVIORAL;
