--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:00:04 04/27/2020
-- Design Name:   
-- Module Name:   C:/Users/fran/Desktop/UPM/ERASMUS/CUATRIMESTRE 2/CICT - Digital Electronics 1/COUNTDOWNPROJECT_FINAL/tb_countdown.vhd
-- Project Name:  COUNTDOWNPROJECT_FINAL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_c
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_countdown IS
END tb_countdown;
 
ARCHITECTURE behavior OF tb_countdown IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_c
    PORT(
         clk_i : IN  std_logic;
         BTN0 : IN  std_logic;
         inA : IN  std_logic;
         inB : IN  std_logic;
			SWITCH_ENCODER: IN std_logic;
			en_i : IN  std_logic;
         outD : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal BTN0 : std_logic := '0';
   signal inA : std_logic := '0';
   signal inB : std_logic := '0';
	signal SWITCH_ENCODER : std_logic := '0';
	signal en_i : std_logic := '0';

	--BiDirs
   signal outD : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_c PORT MAP (
          clk_i => clk_i,
          BTN0 => BTN0,
          inA => inA,
          inB => inB,
			 en_i => en_i,
			 SWITCH_ENCODER => SWITCH_ENCODER,
          outD => outD
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   
      -- Stimulus process
    stim_proc: process
    begin
	   -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;
		    -- Reset activation
        BTN0 <= '0'; wait for clk_i_period;
        BTN0 <= '1';
		
	 -- hold reset state for 100 ns.
    FOR i IN 0 TO 5 LOOP 
			en_i <= '1'; wait for clk_i_period;
			inA <= '0';
			inB <= '0';
			wait for 5 ns;
			inA <= '1';	
			SWITCH_ENCODER <= '1';
  			wait for 5 ns;
			inB <= '1';
			wait for 50 ns;
			inA <= '0';
			wait for 50 ns;
			inB <= '0';
			wait for 50 ns;
		END LOOP;

        wait;
end process;

END;
