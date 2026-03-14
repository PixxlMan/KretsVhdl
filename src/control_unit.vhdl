library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
	port (
		addr				: in unsigned(1 downto 0);
		clk_reg				: out std_logic_vector(3 downto 0)
	);
end control_unit;

architecture Behavioral of control_unit is
begin

	clk_reg(0) <= '1' when (addr = 0) else '0';
	clk_reg(1) <= '1' when (addr = 1) else '0';
	clk_reg(2) <= '1' when (addr = 2) else '0';
	clk_reg(3) <= '1' when (addr = 3) else '0';
	
end Behavioral;