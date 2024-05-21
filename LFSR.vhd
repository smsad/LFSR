library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LFSR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           random_out : out STD_LOGIC_VECTOR (7 downto 0));
end LFSR;

architecture Behavioral of LFSR is
    signal lfsr_reg : STD_LOGIC_VECTOR(7 downto 0) := "10101010"; -- Initial seed
    signal feedback : STD_LOGIC;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            lfsr_reg <= "10101010"; -- Reset seed value
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(7) xor lfsr_reg(5) xor lfsr_reg(4) xor lfsr_reg(3); -- Feedback polynomial
            lfsr_reg <= feedback & lfsr_reg(7 downto 1); -- Shift and insert feedback
        end if;
    end process;
    random_out <= lfsr_reg;
end Behavioral;