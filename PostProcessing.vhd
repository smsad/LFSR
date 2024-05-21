library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PostProcessing is
    Port ( lfsr_output : in STD_LOGIC_VECTOR(7 downto 0);
           key : in STD_LOGIC_VECTOR(7 downto 0);
           random_secure : out STD_LOGIC_VECTOR(7 downto 0));
end PostProcessing;

architecture Behavioral of PostProcessing is
begin
    process(lfsr_output, key)
    begin
        random_secure <= lfsr_output xor key; -- Simple XOR with key for post-processing
    end process;
end Behavioral;




