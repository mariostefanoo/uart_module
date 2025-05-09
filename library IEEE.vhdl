LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench_tx IS
END testbench_tx;
 
ARCHITECTURE behavior OF testbench_tx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_TX
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic;
         done : OUT  std_logic;
         busy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic;
   signal done : std_logic;
   signal busy : std_logic;

   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_TX PORT MAP (
          clk => clk,
          en => en,
          data_in => data_in,
          data_out => data_out,
          done => done,
          busy => busy
        );

   process

begin

clk <='1';
wait for 50 ns;
clk <= '0';
wait for 50 ns;


end process;


process

begin
en <='1';
wait ;

end process;


process

begin

data_in <=X"ab";
wait ;
end process;



END;
