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
begin
	
	uio_out <= "00000000";
	uio_oe <= "00000000";
	
	register_0: entity work.register_8bit
	port map (
	  values   => ui_in,
	  clk      => clk,
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_8bit is
	port (
		values  : in std_logic_vector(7 downto 0);
		clk		: in std_logic;
		rst		: in std_logic;
		o_values: out std_logic_vector(7 downto 0)
	);
end register_8bit;

architecture Behavioral of register_8bit is
begin

	bit_0: entity work.register_bit
	port map (
	  v   => values(0),
	  clk => clk,
	  rst => rst,
	  q   => o_values(0)
	);

	bit_1: entity work.register_bit
	port map (
	  v   => values(1),
	  clk => clk,
	  rst => rst,
	  q   => o_values(1)
	);

	bit_2: entity work.register_bit
	port map (
	  v   => values(2),
	  clk => clk,
	  rst => rst,
	  q   => o_values(2)
	);

	bit_3: entity work.register_bit
	port map (
	  v   => values(3),
	  clk => clk,
	  rst => rst,
	  q   => o_values(3)
	);

	bit_4: entity work.register_bit
	port map (
	  v   => values(4),
	  clk => clk,
	  rst => rst,
	  q   => o_values(4)
	);

	bit_5: entity work.register_bit
	port map (
	  v   => values(5),
	  clk => clk,
	  rst => rst,
	  q   => o_values(5)
	);
	
	bit_6: entity work.register_bit
	port map (
	  v   => values(6),
	  clk => clk,
	  rst => rst,
	  q   => o_values(6)
	);

	bit_7: entity work.register_bit
	port map (
	  v   => values(7),
	  clk => clk,
	  rst => rst,
	  q   => o_values(7)
	);

end Behavioral;
