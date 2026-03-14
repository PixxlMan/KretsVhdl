library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_registers_circ is
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
end tt_um_registers_circ;

architecture Behavioral of tt_um_registers_circ is
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

	write <= uio_in(0);
	addr_input <= unsigned(uio_in(2 downto 1));
	
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