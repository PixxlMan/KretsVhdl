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
        s       : in std_logic;
        r       : in std_logic;
        o       : out std_logic;
        o_n     : out std_logic
    );
end component;
begin
    bit_1: register_bit
    port map (
        s   => ui_in(0),
        r   => ui_in(1),
        o   => uo_out(0)
    );

    --uo_out <= std_logic_vector(unsigned(ui_in) + unsigned(uio_in));
    uio_out <= "00000000";
    uio_oe <= "00000000";

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_bit is
    port (
        s       : in std_logic;
        r       : in std_logic;
        o       : out std_logic;
        o_n     : out std_logic
    );
end register_bit;

architecture Behavioral of register_bit is
    signal top_right: std_logic := 0;
    signal bottom_right: std_logic := 1;
begin

    top_right <= s nand bottom_right;
    bottom_right <= r nand top_right;
    o <= top_right;
    o_n <= bottom_right;

end Behavioral;
