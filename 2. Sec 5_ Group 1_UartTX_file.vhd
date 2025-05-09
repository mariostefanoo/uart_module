----------------------------------------------------------------------------------

-- Additional Comments: clock frequancy = 10MHZ
--Baud rate = 50000
--clks per bit = 10MHZ/50000
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UART_TX is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC;
           done : out  STD_LOGIC;
           busy : out  STD_LOGIC);
end UART_TX;

architecture Behavioral of UART_TX is

signal clk_count : unsigned(7 downto 0) := (others => '0');  
signal bit_count : unsigned(3 downto 0) := (others => '0');
signal flag      : std_logic := '0';
signal end_flag  : std_logic := '0';
signal datafull  : std_ulogic_vector(9 downto 0) := (others => '0');



begin


process (clk)

begin


if rising_edge(clk) then

		  if end_flag = '0' then

            if en = '1' and flag = '0' then
				
				    
            datafull(0) <= '0';  
            datafull(9) <= '1';  
            datafull(8 downto 1) <= std_ulogic_vector((data_in));

		 
                data_out <= datafull(0);  
                busy <= '1';
                done <= '0';
					 
					  if clk_count < to_unsigned(199, 8) then
                    clk_count <= clk_count + 1;
                else
                    clk_count <= (others => '0');
                    flag <= '1';  
                end if;
					 
					 elsif flag = '1' then

                if clk_count < to_unsigned(199, 8) then
                    clk_count <= clk_count + 1;
                else
                    clk_count <= (others => '0');
                    
                    data_out <= datafull(to_integer(bit_count) + 1);
						  
						  
						  if bit_count < to_unsigned(8,4)  then
                        bit_count <= bit_count + 1;  -- Increment bit_count
                    else
                        bit_count <= (others => '0');  -- Reset bit_count after 8 bits
                        end_flag <= '1';  -- End of transmission
                    end if;
                end if;
            end if;


elsif end_flag = '1' then
            data_out <= datafull(9);  -- Send stop bit
            busy <= '0';
            done <= '1';
				
				
				if clk_count < to_unsigned(199, 8) then
                clk_count <= clk_count + 1;
            else
                clk_count <= (others => '0');
                flag <= '0';  -- Reset flag
                end_flag <= '0';  -- Reset end_flag
            end if;
        end if;

    end if;
	 
	 
	 end process;





end Behavioral;

