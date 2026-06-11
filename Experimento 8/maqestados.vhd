library IEEE;
use IEEE.std_logic_1164.all;

entity maqestados is
    port (
        clock        : in  std_logic;
        reset        : in  std_logic;
        ligadesliga  : in  std_logic;
        sensorA      : in  std_logic; -- Norte/Sul
        sensorB      : in  std_logic; -- Leste/Oeste
        T5           : in  std_logic;
        T6           : in  std_logic;
        T20          : in  std_logic;
        T60          : in  std_logic;
        semaforoA    : out std_logic_vector(2 downto 0); -- V, A, G
        semaforoB    : out std_logic_vector(2 downto 0); -- V, A, G
        resetcounter : out std_logic
    );
end maqestados;

architecture behavior of maqestados is
    type state_type is (V_NS, A_NS, Red_1, V_LO, A_LO, Red_2, PISCA_ON, PISCA_OFF);
    signal current_state, next_state : state_type;
begin

    -- Processo Síncrono: Transição de Estado
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= V_NS;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process;

    -- Processo Combinacional: Lógica do Próximo Estado e Saída Mealy (resetcounter)
    process(current_state, ligadesliga, sensorA, sensorB, T5, T6, T20, T60)
    begin
        -- Valores padrão por omissão
        next_state <= current_state;
        resetcounter <= '0';

        -- Verificação global da chave liga/desliga
        if ligadesliga = '0' then
            if current_state = PISCA_ON then
                next_state <= PISCA_OFF;
                resetcounter <= '1'; -- Força reset síncrono a cada 1s para alternar
            elsif current_state = PISCA_OFF then
                next_state <= PISCA_ON;
                resetcounter <= '1';
            else
                next_state <= PISCA_ON;
                resetcounter <= '1';
            end if;
        else
            -- Funcionamento Normal do Semáforo
            case current_state is
                when PISCA_ON | PISCA_OFF =>
                    next_state <= V_NS;
                    resetcounter <= '1';

                when V_NS =>
                    -- Muda após 60s OU (após 20s se houver carro em B e nenhum em A)
                    if T60 = '1' or (T20 = '1' and sensorB = '1' and sensorA = '0') then
                        next_state <= A_NS;
                        resetcounter <= '1';
                    end if;

                when A_NS =>
                    if T6 = '1' then
                        next_state <= Red_1;
                        resetcounter <= '1';
                    end if;

                when Red_1 =>
                    if T5 = '1' then
                        next_state <= V_LO;
                        resetcounter <= '1';
                    end if;

                when V_LO =>
                    -- Muda após 60s OU (após 20s se houver carro em A e nenhum em B)
                    if T60 = '1' or (T20 = '1' and sensorA = '1' and sensorB = '0') then
                        next_state <= A_LO;
                        resetcounter <= '1';
                    end if;

                when A_LO =>
                    if T6 = '1' then
                        next_state <= Red_2;
                        resetcounter <= '1';
                    end if;

                when Red_2 =>
                    if T5 = '1' then
                        next_state <= V_NS;
                        resetcounter <= '1';
                    end if;
                
                when others =>
                    next_state <= V_NS;
            end case;
        end if;
    end process;

    -- Saídas Moore: Dependentes apenas do Estado Atual (Luzes Vermelho, Amarelo, Verde)
    process(current_state)
    begin
        case current_state is
            when V_NS =>
                semaforoA <= "001"; -- Verde
                semaforoB <= "100"; -- Vermelho
            when A_NS =>
                semaforoA <= "010"; -- Amarelo
                semaforoB <= "100"; -- Vermelho
            when Red_1 =>
                semaforoA <= "100"; -- Vermelho
                semaforoB <= "100"; -- Vermelho
            when V_LO =>
                semaforoA <= "100"; -- Vermelho
                semaforoB <= "001"; -- Verde
            when A_LO =>
                semaforoA <= "100"; -- Vermelho
                semaforoB <= "010"; -- Amarelo
            when Red_2 =>
                semaforoA <= "100"; -- Vermelho
                semaforoB <= "100"; -- Vermelho
            when PISCA_ON =>
                semaforoA <= "010"; -- Amarelo piscando
                semaforoB <= "010"; -- Amarelo piscando
            when PISCA_OFF =>
                semaforoA <= "000"; -- Apagado
                semaforoB <= "000"; -- Apagado
            when others =>
                semaforoA <= "100";
                semaforoB <= "100";
        end case;
    end process;

end behavior;

