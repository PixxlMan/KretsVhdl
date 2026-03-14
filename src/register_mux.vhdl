library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_mux is
	port (
		register_0	: in std_logic_vector(7 downto 0);
		register_1	: in std_logic_vector(7 downto 0);
		register_2	: in std_logic_vector(7 downto 0);
		register_3	: in std_logic_vector(7 downto 0);
		selector	: in unsigned(1 downto 0);
		output		: out std_logic_vector(7 downto 0)
	);
end register_mux;

architecture Behavioral of register_mux is
begin

	output <=
		register_0 when (selector = 0) else
		register_1 when (selector = 1) else
		register_2 when (selector = 2) else
		register_3;

end Behavioral;