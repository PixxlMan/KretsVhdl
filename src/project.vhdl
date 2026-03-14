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
component register_8bit is
	port (
		values  : in std_logic_vector(7 downto 0);
		w		: in std_logic;
		clk		: in std_logic;
		rst		: in std_logic;
		o_values: out std_logic_vector(7 downto 0)
	);
end component;
component control_unit is
	port (
		w					: in std_logic;
		addr				: in std_logic;
		clk_reg_0			: out std_logic;
		clk_reg_1			: out std_logic;
		w_reg_0				: out std_logic;
		w_reg_1				: out std_logic
	);
end component;
signal clk_0: std_logic;
signal clk_1: std_logic;
signal w_0: std_logic;
signal w_1: std_logic;
begin
	
	uio_out <= "00000000";
	uio_oe <= "00000000";
	
	control_unit_inst: control_unit
	port map (
	  w         => uio_in(0),
	  addr      => uio_in(1),
	  clk_reg_0 => clk_0,
	  clk_reg_1 => clk_1,
	  w_reg_0   => w_0,
	  w_reg_1   => w_1
	);
	
	register_0: register_8bit
	port map (
	  values   => ui_in,
	  w        => w_0,
	  clk      => clk_0,
	  rst      => rst_n,
	  o_values => uo_out
	);

	register_1: register_8bit
	port map (
	  values   => ui_in,
	  w        => w_1,
	  clk      => clk_1,
	  rst      => rst_n,
	  o_values => uo_out
	);

end Behavioral;

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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_8bit is
	port (
		values  : in std_logic_vector(7 downto 0);
		w		: in std_logic;
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
		rst		: in std_logic;
		q		: out std_logic
	);
end component;
signal output_buffer:	std_logic_vector(7 downto 0);
signal write:			std_logic;
begin
	write <= clk and w;

	bit_0: register_bit
	port map (
	  v   => values(0),
	  w   => write,
	  rst => rst,
	  q   => output_buffer(0)
	);
	o_values(0) <= output_buffer(0) when (clk and (not w));

	bit_1: register_bit
	port map (
	  v   => values(1),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(1)
	);
	o_values(1) <= output_buffer(1) when (clk and (not w));

	bit_2: register_bit
	port map (
	  v   => values(2),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(2)
	);
	o_values(2) <= output_buffer(2) when (clk and (not w));

	bit_3: register_bit
	port map (
	  v   => values(3),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(3)
	);
	o_values(3) <= output_buffer(3) when (clk and (not w));

	bit_4: register_bit
	port map (
	  v   => values(4),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(4)
	);
	o_values(4) <= output_buffer(4) when (clk and (not w));

	bit_5: register_bit
	port map (
	  v   => values(5),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(5)
	);
	o_values(5) <= output_buffer(5) when (clk and (not w));
	
	bit_6: register_bit
	port map (
	  v   => values(6),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(6)
	);
	o_values(6) <= output_buffer(6) when (clk and (not w));

	bit_7: register_bit
	port map (
	  v   => values(7),
	  w   => clk and w,
	  rst => rst,
	  q   => output_buffer(7)
	);
	o_values(7) <= output_buffer(7) when (clk and (not w));

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
	port (
		w					: in std_logic;
		addr				: in std_logic;
		clk_reg_0			: out std_logic;
		clk_reg_1			: out std_logic;
		w_reg_0				: out std_logic;
		w_reg_1				: out std_logic
	);
end control_unit;

architecture Behavioral of control_unit is
begin

	clk_reg_0 <= (not addr);
	w_reg_0 <= w and (not addr);

	clk_reg_1 <= (addr);
	w_reg_1 <= w and (addr);
	
end Behavioral;