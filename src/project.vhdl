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
		clk		: in std_logic;
		rst		: in std_logic;
		q		: out std_logic
	);
end component;
begin
	register_bit_inst: register_bit
	port map (
	  v   => ui_in(0),
	  clk => clk,
	  rst => rst_n,
	  q   => uo_out(0)
	);

	uio_out <= "00000000";
	uio_oe <= "00000000";

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_bit is
	port (
		v       : in std_logic;
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
			else
				q <= v;
			end if;
		end if;
	end process;
	
end Behavioral;
