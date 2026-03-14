library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_bit is
	port (
		v       : in std_logic;
		w		: in std_logic;
		rst		: in std_logic;
		q		: out std_logic
	);
end register_bit;

architecture Behavioral of register_bit is
begin

	process(w)
	begin
		if rising_edge(w) then
			if rst = '1' then
				q <= '0';
			else
				q <= v;
			end if;
		end if;
	end process;
	
end Behavioral;