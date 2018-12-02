----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    mem - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use WORK.DEFINES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is 
	Port (
		--æä»¤çç±»å
		op_type_in : in STD_LOGIC_VECTOR (2 downto 0);
		--åä½¿è
		reg_write_in : in STD_LOGIC;
		reg_addr_in : in STD_LOGIC_VECTOR(3 downto 0);
		--åå¥å¯å­å¨çæ°æ®
		reg_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		--è¯åçåå­å°å
		mem_addr_in : in STD_LOGIC_VECTOR(15 downto 0);
		--åå¥åå­çæ°æ
		mem_write_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		mem_read_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		rst : in STD_LOGIC;

		reg_write_out : out STD_LOGIC;
		reg_addr_out : out STD_LOGIC_VECTOR(3 downto 0);
		reg_data_out : out STD_LOGIC_VECTOR(15 downto 0);

		--è¯ååå­å°å
		mem_addr_out : out STD_LOGIC_VECTOR(15 downto 0);
		--åå¥åå­çæ°æ
		mem_data_out : out STD_LOGIC_VECTOR(15 downto 0);
		--æä½ram1è¯»åçä¸¤ä¸ªä½¿è½ç«¯å
		mem_read_out : out STD_LOGIC;
		mem_write_out : out STD_LOGIC);
end MEM;

architecture Behavioral of MEM is
begin
	process(rst,mem_write_data_in,mem_addr_in,op_type_in,mem_read_data_in, reg_write_in, reg_addr_in, reg_data_in)
	begin
		if(rst = RstEnable) then
			reg_write_out <= WriteDisable;
			reg_data_out <= ZeroWord;
			reg_addr_out <= NULL_REGISTER;
			mem_addr_out <= ZeroWord;
			mem_data_out <= ZeroWord;
			mem_read_out <= '0'; -- =1 when ram_ce=RamEnable=0 and ram_we=Read
			mem_write_out <= '0';		-- =1 when ram_ce=RamEnable=0 and ram_we=Write
		else 
			--åºå®ä¼ åºå
			reg_write_out <= reg_write_in;
			reg_addr_out <= reg_addr_in;
			case op_type_in is
				--Load æä»¤
				when "101" =>
					mem_addr_out <= mem_addr_in;
					mem_data_out <= ZeroWord;
					mem_read_out <= '1';
					mem_write_out <= '0';
					reg_data_out <= mem_read_data_in;
				--store æä»¤
				when "111" =>
					mem_addr_out <= mem_addr_in;
					mem_data_out <= mem_write_data_in;
					reg_data_out <= reg_data_in;
					mem_read_out <= '0';
					mem_write_out <= '1';
				-- ä¸éè¦è®¿é®åä¿®æ¹åå­çæä»
				when others => 
					reg_data_out <= reg_data_in;
					mem_addr_out <= ZeroWord;
					mem_data_out <= ZeroWord;
					mem_read_out <= '0';
					mem_write_out <= '0';
			end case;
		end if;
	end process;
end Behavioral;


