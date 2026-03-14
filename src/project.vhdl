-------------------

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
		addr				: in unsigned(1 downto 0);
		clk_reg				: out std_logic_vector(3 downto 0)
	);
end component;
component register_mux is
	port (
		register_0	: in std_logic_vector(7 downto 0);
		register_1	: in std_logic_vector(7 downto 0);
		register_2	: in std_logic_vector(7 downto 0);
		register_3	: in std_logic_vector(7 downto 0);
		selector	: in unsigned(1 downto 0);
		output		: out std_logic_vector(7 downto 0)
	);
end component;
signal reg_clks: std_logic_vector(3 downto 0);
signal register_0_buffer: std_logic_vector(7 downto 0);
signal register_1_buffer: std_logic_vector(7 downto 0);
signal register_2_buffer: std_logic_vector(7 downto 0);
signal register_3_buffer: std_logic_vector(7 downto 0);
signal write: std_logic;
signal addr_input: unsigned(1 downto 0);
begin

	write <=uio_in(0);
	addr_input <= unsigned(ui_in(2 downto 1));
	
	uio_out <= "00000000";
	uio_oe <= "00000000";
	
	control_unit_inst: control_unit
	port map (
	  addr    => addr_input,
	  clk_reg => reg_clks
	);

	mux: register_mux
	port map (
	  register_0 => register_0_buffer,
	  register_1 => register_1_buffer,
	  register_2 => register_2_buffer,
	  register_3 => register_3_buffer,
	  selector   => addr_input,
	  output     => uo_out
	);
	
	register_0: register_8bit
	port map (
	  values   => ui_in,
	  w        => write,
	  clk      => reg_clks(0),
	  rst      => rst_n,
	  o_values => register_0_buffer
	);

	register_1: register_8bit
	port map (
	  values   => ui_in,
	  w        => write,
	  clk      => reg_clks(1),
	  rst      => rst_n,
	  o_values => register_1_buffer
	);

	register_2: register_8bit
	port map (
	  values   => ui_in,
	  w        => write,
	  clk      => reg_clks(2),
	  rst      => rst_n,
	  o_values => register_2_buffer
	);

	register_3: register_8bit
	port map (
	  values   => ui_in,
	  w        => write,
	  clk      => reg_clks(3),
	  rst      => rst_n,
	  o_values => register_3_buffer
	);

end Behavioral;

-------------------

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

-------------------

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
signal write:			std_logic;
begin
	write <= clk and w;

	bit_0: register_bit
	port map (
	  v   => values(0),
	  w   => write,
	  rst => rst,
	  q   => o_values(0)
	);

	bit_1: register_bit
	port map (
	  v   => values(1),
	  w   => write,
	  rst => rst,
	  q   => o_values(1)
	);

	bit_2: register_bit
	port map (
	  v   => values(2),
	  w   => write,
	  rst => rst,
	  q   => o_values(2)
	);

	bit_3: register_bit
	port map (
	  v   => values(3),
	  w   => write,
	  rst => rst,
	  q   => o_values(3)
	);

	bit_4: register_bit
	port map (
	  v   => values(4),
	  w   => write,
	  rst => rst,
	  q   => o_values(4)
	);

	bit_5: register_bit
	port map (
	  v   => values(5),
	  w   => write,
	  rst => rst,
	  q   => o_values(5)
	);
	
	bit_6: register_bit
	port map (
	  v   => values(6),
	  w   => write,
	  rst => rst,
	  q   => o_values(6)
	);

	bit_7: register_bit
	port map (
	  v   => values(7),
	  w   => write,
	  rst => rst,
	  q   => o_values(7)
	);

end Behavioral;

-------------------

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

-------------------

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