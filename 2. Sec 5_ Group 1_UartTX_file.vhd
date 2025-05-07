----------------------------------------------------------------------------------

-- Additional Comments: clock frequancy = 10MHZ
--Baud rate = 50000
--clks per bit = 10MHZ/50000
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity uart_tx is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_out : out  STD_LOGIC;
           busy : out  STD_LOGIC;
           done : out  STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is

signal clk_count : integer range 0 to 199 := 0; 
signal bit_count : integer range 0 to 9 := 0;   

begin


process(clk)

variable  flag     : std_logic :='0';
variable  end_flag : std_logic :='0';
variable  datafull : std_logic_vector(9 downto 0);


begin



   if rising_edge(clk) then
	
	   datafull(0):= '0'; 
	   datafull(9):= '1';
		datafull(8 downto 1):= data_in;
		
		 if end_flag = '0' then
		 
		   if en='1' and flag='0' then
			   data_out <= datafull(0);
            busy<= '1';
            done<='0';
            
            if clk_count < 199 then
                clk_count<= clk_count + 1;
            else
                clk_count <= 0;
                flag := '1';	
            end if;

        elsif flag = '1' then
		  
		       if clk_count < 199 then
                clk_count <= clk_count +1;
            else
                clk_count <= 0;
                data_out<= datafull(bit_count+1);
					   
						if bit_count < 8 then
						    bit_count <= bit_count +1;
                  else
                      bit_count <= 0;
                      end_flag:= '1';
                   end if;
           end if;
			  
       end if;			 


     elsif	end_flag = '1' then
	  
            data_out <= datafull(9);
            busy<= '0';
            done <='1';
				
				if clk_count < 199 then
                clk_count <= clk_count +1;
            else
                clk_count <= 0;
					 flag :='0';
					 end_flag :='0';
			  end if;
     end if;


end if;




end process;
end Behavioral;

