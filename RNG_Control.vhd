library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RNG_Control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           lfsr_output : out STD_LOGIC_VECTOR(7 downto 0);
           key : in STD_LOGIC_VECTOR(7 downto 0);
           random_secure : out STD_LOGIC_VECTOR(7 downto 0));
end RNG_Control;

architecture Behavioral of RNG_Control is
    component LFSR is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               random_out : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

component PostProcessing is
        Port ( lfsr_output : in STD_LOGIC_VECTOR(7 downto 0);
               key : in STD_LOGIC_VECTOR(7 downto 0);
               random_secure : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal lfsr_out : STD_LOGIC_VECTOR(7 downto 0);

begin
    U1: LFSR port map (clk => clk, reset => reset, random_out => lfsr_out);
    U2: PostProcessing port map (lfsr_output => lfsr_out, key => key, random_secure => random_secure);
end Behavioral;

component PostProcessing is
        Port (
            lfsr_output : in STD_LOGIC_VECTOR(7 downto 0);
            key : in STD_LOGIC_VECTOR(7 downto 0);
            random_secure : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

signal lfsr_out : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Instantiate LFSR component
    U1: LFSR
        port map (
            clk => clk,
            reset => reset,
            random_out => lfsr_out
        );

    -- Instantiate PostProcessing component
    U2: PostProcessing
        port map (
            lfsr_output => lfsr_out,
            key => key,
            random_secure => random_secure
        );
    -- Map the internal LFSR output to the entity's output port
    lfsr_output <= lfsr_out;
end Behavioral;
