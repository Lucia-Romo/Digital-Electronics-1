----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:41:55 04/30/2020 
-- Design Name: 
-- Module Name:    encoder_ky040 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encoder_ky040 is
generic (
    g_NBIT : positive := 4      -- Number of bits
);
    port (	srst_n_i : in STD_LOGIC; -- Synchronous reset
				clk_i : in STD_LOGIC; --clock
				
				inA   : in  STD_LOGIC; --pin A
				inB   : in  STD_LOGIC; --pin B
				enc_sw : in std_logic; -- Switch of the encoder
				
				final_pos : out  STD_LOGIC_VECTOR (g_NBIT-1 downto 0)
				);
end encoder_ky040;

architecture Behavioral of encoder_ky040 is

	 signal counter_e : std_logic_vector(g_NBIT-1 downto 0):= B"0000"; -- encoder
    signal previousstateA : std_logic := '0';
    signal stateA: std_logic;
    signal stateB: std_logic;
		  
    begin 
	 
    stateA <= inA;
    stateB <= inB;
	 
	 --------------------------------------------------------------------
	 -- PROCESS OF CALCULATION OF THE ENCODER POSITION
	 --
	 --------------------------------------------------------------------
    	encoder_process : process(clk_i)
      begin
       if rising_edge(clk_i) then
			if srst_n_i='0' then   
					counter_e <= (others => '0');   -- Clear all bits
			elsif enc_sw = '1' then
				if stateA /= previousstateA then
						if stateB /= stateA then 
								counter_e <= counter_e + 1;	
						else
								counter_e <= counter_e - 1; 
						end if;
					previousstateA <= stateA;
					end if;
				end if;
		   end if;	 
			
end process encoder_process;

final_pos <= std_logic_vector(counter_e);
end Behavioral;

