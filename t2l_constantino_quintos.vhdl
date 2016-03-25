-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;	

-- Entity Definition
entity buzzer is
	--boggisIn and boggisOut is for boggis
	--bunceIn and bunceOut is for bunce
	--beanIn and beanOut is for bean
						
	port (
		output: out std_logic;
		boggisIn: in std_logic;
		boggisOut: in std_logic;
		bunceIn: in std_logic;
		bunceOut: in std_logic;
		beanIn: in std_logic;
		beanOut: in std_logic
	);			
end entity buzzer;

-- Behavorial structure of buzzer
architecture buzzer of buzzer is
begin
	-- This buzzer architecture contains one assignment.
		output<= (boggisIn or bunceIn or beanIn) and (boggisOut or bunceOut or beanOut);
end architecture buzzer;
