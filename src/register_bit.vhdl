library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_bit is
	port (
		v       : in std_logic;
		w		: in std_logic;
		clk		: in std_logic;
		rst		: in std_logic;
		q		: out std_logic
	);
end register_bit;

architecture Behavioral of register_bit is
begin

	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				q <= '0';
			elsif w = '1' then
				q <= v;
			end if;
		end if;
	end process;
	
end Behavioral;