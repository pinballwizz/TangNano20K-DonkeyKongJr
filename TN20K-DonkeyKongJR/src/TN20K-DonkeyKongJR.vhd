---------------------------------------------------------------------------------
--                         Donkey Kong Jr - Tang Nano 20K
--                          Code from Katsumi Degawa
--
--                        Modified for Tang Nano 20K 
--                            by pinballwiz.org 
--                               28/12/2025
---------------------------------------------------------------------------------
-- Keyboard inputs :
--   5 : Add coin
--   2 : Start 2 players
--   1 : Start 1 player
--   LEFT Ctrl : Jump
--   RIGHT arrow : Move Right
--   LEFT arrow  : Move Left
--   UP arrow : Move Up
--   DOWN arrow  : Move Down
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
---------------------------------------------------------------------------------
entity dkongjr_tn20k is
port(
	Clock_48    : in std_logic;
   	I_RESET     : in std_logic;
	O_VIDEO_R	: out std_logic_vector(2 downto 0); 
	O_VIDEO_G	: out std_logic_vector(2 downto 0);
	O_VIDEO_B	: out std_logic_vector(1 downto 0);
	O_HSYNC		: out std_logic;
	O_VSYNC		: out std_logic;
	O_AUDIO_L 	: out std_logic;
	O_AUDIO_R 	: out std_logic;
   	ps2_clk     : in std_logic;
	ps2_dat     : inout std_logic;
 	led         : out std_logic_vector(5 downto 0)
 );
end dkongjr_tn20k;
------------------------------------------------------------------------------
architecture struct of dkongjr_tn20k is

 signal clock_100       : std_logic;
 signal clock_25        : std_logic;
 signal clock_12        : std_logic;
 --
 signal video_r         : std_logic_vector(5 downto 0);
 signal video_g         : std_logic_vector(5 downto 0);
 signal video_b         : std_logic_vector(5 downto 0);
 --
 signal M_VIDEO_R		: std_logic_vector(2 downto 0);
 signal M_VIDEO_G		: std_logic_vector(2 downto 0);
 signal M_VIDEO_B		: std_logic_vector(2 downto 0);
 --
 signal M_HSYNC			: std_logic;
 signal M_VSYNC			: std_logic;
 --	
 signal video_r_x2		: std_logic_vector(5 downto 0);
 signal video_g_x2		: std_logic_vector(5 downto 0);
 signal video_b_x2		: std_logic_vector(5 downto 0);
 --
 signal hsync_x2		: std_logic;
 signal vsync_x2		: std_logic;
 --
 signal h_blank			: std_logic;
 signal v_blank			: std_logic;
 --	
 signal audio			: std_logic_vector( 7 downto 0);
 signal M_AUDIO			: std_logic;
 --
 signal reset           : std_logic;
 --
 signal kbd_intr        : std_logic;
 signal kbd_scancode    : std_logic_vector(7 downto 0);
 signal joy_BBBBFRLDU   : std_logic_vector(8 downto 0);
 --
 constant CLOCK_FREQ    : integer := 27E6;
 signal counter_clk     : std_logic_vector(25 downto 0);
 signal clock_4hz       : std_logic;
 signal AD              : std_logic_vector(15 downto 0);
---------------------------------------------------------------------------
begin

 reset <= I_RESET;

---------------------------------------------------------------------------
-- Clock
Clock1: entity work.Gowin_rPLL
    port map (
        clkout  => Clock_100,
        clkoutd => Clock_25,
        clkin   => Clock_48
    );
---------------------------------------------------------------------------
process(clock_25)
begin
	if rising_edge(clock_25) then
		clock_12 <= not clock_12;
	end if;
end process;
---------------------------------------------------------------------------
dkongjr : entity work.dkongjr_main
	port map (
 I_CLK_24576M   => clock_25,
 I_RESETn       => not reset,
 I_U1		    => not joy_BBBBFRLDU(0),    -- P1 up
 I_D1		    => not joy_BBBBFRLDU(1),    -- P1 down
 I_L1		    => not joy_BBBBFRLDU(2),    -- P1 left
 I_R1		    => not joy_BBBBFRLDU(3),    -- P1 right
 I_J1		    => not joy_BBBBFRLDU(4),    -- P1 jump
 I_S1		    => not joy_BBBBFRLDU(5),    -- P1 start
 I_U2		    => not joy_BBBBFRLDU(0),    -- P2 up
 I_D2		    => not joy_BBBBFRLDU(1),    -- P2 down
 I_L2		    => not joy_BBBBFRLDU(2),    -- P2 left
 I_R2		    => not joy_BBBBFRLDU(3),    -- P2 right
 I_J2		    => not joy_BBBBFRLDU(4),    -- P2 jump
 I_S2		    => not joy_BBBBFRLDU(6),    -- P2 start
 I_C1		    => joy_BBBBFRLDU(7),        -- Coin
 I_DIP_SW		=> "10000000",
 O_VGA_R		=> M_VIDEO_R,
 O_VGA_G		=> M_VIDEO_G,
 O_VGA_B		=> M_VIDEO_B,
 O_VGA_H_SYNCn	=> M_HSYNC,
 O_VGA_V_SYNCn	=> M_VSYNC,
 O_H_BLANK		=> h_blank,
 O_V_BLANK		=> v_blank,
 O_SOUND_DAT	=> audio,
 AD             => AD
	);
-----------------------------------------------------------------
-- vga inputs
video_r <= M_VIDEO_R & M_VIDEO_R when h_blank = '0' and v_blank = '0' else "000000";
video_g <= M_VIDEO_G & M_VIDEO_G when h_blank = '0' and v_blank = '0' else "000000";
video_b <= M_VIDEO_B & M_VIDEO_B when h_blank = '0' and v_blank = '0' else "000000";
-----------------------------------------------------------------
-- scan doubler

dblscan: entity work.scandoubler
	port map(
		clk_sys => clock_25,
		scanlines => "00",
		r_in   => video_r,
		g_in   => video_g,
		b_in   => video_b,
		hs_in  => M_HSYNC,
		vs_in  => M_VSYNC,
		r_out  => video_r_x2,
		g_out  => video_g_x2,
		b_out  => video_b_x2,
		hs_out => hsync_x2,
		vs_out => vsync_x2
	);
-----------------------------------------------------------------
-- vga outputs

	O_VIDEO_R 	<= video_r_x2(5 downto 3);
	O_VIDEO_G 	<= video_g_x2(5 downto 3);
	O_VIDEO_B 	<= video_b_x2(5 downto 4);
	O_HSYNC     <= hsync_x2;
	O_VSYNC     <= vsync_x2;
-----------------------------------------------------------------
  dac: entity work.dac
  port map (
     clk_i   => clock_12,
	 res_n_i => not reset,
	 dac_i	 => audio,
	 dac_o	 => M_AUDIO
	 );
	 
	O_AUDIO_L <= M_AUDIO;	
	O_AUDIO_R <= M_AUDIO;
-----------------------------------------------------------------
-- get scancode from keyboard

keyboard : entity work.io_ps2_keyboard
port map (
  clk       => clock_12,
  kbd_clk   => ps2_clk,
  kbd_dat   => ps2_dat,
  interrupt => kbd_intr,
  scancode  => kbd_scancode
);
-----------------------------------------------------------------
-- translate scancode to joystick

joystick : entity work.kbd_joystick
port map (
  clk           => clock_12,
  kbdint        => kbd_intr,
  kbdscancode   => std_logic_vector(kbd_scancode), 
  joy_BBBBFRLDU => joy_BBBBFRLDU 
);
-----------------------------------------------------------------
-- debug

process(reset, clock_25)
begin
  if reset = '1' then
    clock_4hz <= '0';
    counter_clk <= (others => '0');
  else
    if rising_edge(clock_25) then
      if counter_clk = CLOCK_FREQ/8 then
        counter_clk <= (others => '0');
        clock_4hz <= not clock_4hz;
        led(5 downto 0) <= not AD(9 downto 4);
      else
        counter_clk <= counter_clk + 1;
      end if;
    end if;
  end if;
end process;
------------------------------------------------------------------------
end struct;