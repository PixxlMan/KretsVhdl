library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_8bit is
	port (
		values  : in std_logic_vector(7 downto 0);
		w		: in std_logic;
		write	: in std_logic;
		clk		: in std_logic;
		rst		: in std_logic;
		o_values: out std_logic_vector(7 downto 0)
	);
end register_8bit;

architecture Behavioral of register_8bit is
component register_bit is
	port (
		v       : in std_logic;
		w		: in std_logic;
		clk		: in std_logic;
		rst		: in std_logic;
		q		: out std_logic
	);
end component;
signal write_sig:			std_logic;
begin
	write_sig <= write and w;

	bit_0: register_bit
	port map (
	  v   => values(0),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(0)
	);

	bit_1: register_bit
	port map (
	  v   => values(1),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(1)
	);

	bit_2: register_bit
	port map (
	  v   => values(2),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(2)
	);

	bit_3: register_bit
	port map (
	  v   => values(3),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(3)
	);

	bit_4: register_bit
	port map (
	  v   => values(4),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(4)
	);

	bit_5: register_bit
	port map (
	  v   => values(5),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(5)
	);
	
	bit_6: register_bit
	port map (
	  v   => values(6),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(6)
	);

	bit_7: register_bit
	port map (
	  v   => values(7),
	  w   => write_sig,
	  clk => clk,
	  rst => rst,
	  q   => o_values(7)
	);

end Behavioral;