-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
-- Test Bench has no ports
entity tb_buzzer is
end entity tb_buzzer;

architecture tb of tb_buzzer is
	-- declare signals to be used for connecting to UUT (Unit Under Test)
	signal boggisIn, boggisOut, bunceIn, bunceOut, beanIn, beanOut:  std_logic; 		-- inputs
	signal output: std_logic;				-- output
	
	-- Component Declaration
	-- Component buzzer entity
	component buzzer is 
		port (
			output: out std_logic;
			boggisIn: in std_logic;
			boggisOut: in std_logic;
			bunceIn: in std_logic;
			bunceOut: in std_logic;
			beanIn: in std_logic;
			beanOut: in std_logic
		);						--ix (0 <= x <= 3) indicates decimal value x;
	end component buzzer;	

	begin
		-- make connections to the unit under test (uut)
		UUT: component buzzer port map(output, boggisIn, boggisOut, bunceIn, bunceOut, beanIn, beanOut);


		main: process is
			variable error_count: integer := 0;
			variable expected_output: std_logic;
			variable temp: unsigned(5 downto 0);	--used in calculations

		begin
			report "Start Simulation. ";

			for count in 0 to 63 loop								-- similar to "for(int count=0;count<=63;count++"
				temp := TO_UNSIGNED(count,6);
				beanOut <= std_logic(temp(5));						--6th bit
				beanIn <= std_logic(temp(4));						--5th bit
				bunceOut <= std_logic(temp(3)); 					--4th bit
				bunceIn <= std_logic(temp(2)); 						--3rd bit
				boggisOut <= std_logic(temp(1));					--2nd bit
				boggisIn <= std_logic(temp(0));						--1st bit
				
				-- generate expected result with this conditions
				if(count=0) then
					expected_output := 'U';
				elsif(boggisIn='1' and (boggisOut='1' or bunceOut='1' or beanOut='1' )) then 
					expected_output := '1';
				elsif(boggisOut='1' and (bunceIn='1' or beanIn='1')) then
					expected_output := '1';
				elsif(bunceIn='1' and (bunceOut='1' or beanOut='1')) then
					expected_output := '1';
				elsif(bunceOut='1' and (beanIn='1')) then
					expected_output := '1';	
				elsif(beanIn='1' and beanOut='1') then
					expected_output := '1';
				else
					expected_output := '0';
				end if;
				
				-- check if expected result is the same result generated
				assert(expected_output = output)
						report "ERROR: Expected valid " &
							std_logic'image(expected_output) & integer'image(count) & std_logic'image(output);
						
					-- increment number of errors		
					if (expected_output /= output) then
						error_count := error_count + 1;
					end if;
			
				wait for 10 ns;
			end loop;
			
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & " errors!";
					
			if(error_count = 0) then
				 report "Simulation completed with NO errors.";
			end if;

			wait;	-- wait forever		
		end process;
end architecture tb;
