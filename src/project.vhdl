library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_example is
	port (
		ui_in   : in  std_logic_vector(7 downto 0);
		uo_out  : out std_logic_vector(7 downto 0);
		uio_in  : in  std_logic_vector(7 downto 0);
		uio_out : out std_logic_vector(7 downto 0);
		uio_oe  : out std_logic_vector(7 downto 0);
		ena     : in  std_logic;
		clk     : in  std_logic;
		rst_n   : in  std_logic
	);
end tt_um_example;

architecture Behavioral of tt_um_example is
component register_bit is
	port (
		v       : in std_logic;
		u       : in std_logic;
		o       : buffer std_logic;
		o_n     : buffer std_logic
	);
end component;
signal value: std_logic := "0";
begin
	bit_1: register_bit
	port map (
		v   => ui_in(0),
		u   => clk,
		o   => value
	);

	uo_out(0) <= value;

	uio_out <= "00000000";
	uio_oe <= "00000000";

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_bit is
	port (
		v       : in std_logic;
		u       : in std_logic;
		o       : buffer std_logic := "0";
		o_n     : buffer std_logic := "1"
	);
end register_bit;

architecture Behavioral of register_bit is
	signal s: std_logic := "0";
	signal r: std_logic := "0";
begin

	s <= v and u;
	r <= not(v) and u;
	o <= s nand o_n;
	o_n <= r nand o;
	
end Behavioral;
