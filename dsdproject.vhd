library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity dsdproject is
port (smokein,flamein,irin, clk1:in std_logic;
 buzzer,ledyellow,ledgreen,ledred,motor: out std_logic;
 sevensegment1,sevensegment2: out Std_logic_vector (6 downto 0) );

END dsdproject;



Architecture dsdprojectfunc of dsdproject is
		signal count : integer :=1;
		signal clk : std_logic :='0';
		signal dangerlevel : integer :=0;
		signal d2: Std_logic_vector (3 downto 0); 



BEGIN

		process(clk1) 
		begin
		if(clk1'event and clk1='1') then
		count <=count+1;
			if(count = 25000000) then
			clk<= not clk;
			count <=1;
			end if;
		end if;
		end process;
	
	
	
	PROCESS (smokein,flamein,irin,clk)
	BEGIN
	
	
	IF (clk'EVENT) AND (clk = '1') THEN
			
			--Smoke off , flame off
			IF (smokein='1' AND flamein='0') THEN buzzer <= '0' ; ledyellow<='0';ledred<='0';ledgreen<='1' ; motor<='0';dangerlevel<=0;
			--Smoke on , flame off
			ELSIF (smokein='0' AND fla mein='0') THEN buzzer <= '1' ; ledyellow<='1';ledred<='0';ledgreen<='0' ; motor<='1';dangerlevel<=1;
			--Smoke off , flame on
			ELSIF (smokein='1' AND flamein='1') THEN buzzer <= '1' ; ledyellow<='0';ledred<='1';ledgreen<='0' ; motor<='0';dangerlevel<=2;	
			--Smoke on , flame on
			ELSIF (smokein='0' AND flamein='1') THEN buzzer <= '1' ; ledyellow<='0';ledred<='1';ledgreen<='0' ; motor<='0';dangerlevel<=3;
			
			END IF;
			--IR off
			IF (irin='1') THEN buzzer<='0';
			END IF;		

			
			END IF;

	
	END PROCESS;
	
	
	d2 <= std_logic_vector(to_unsigned((dangerlevel), 4));
				
	process(d2)
	begin
	 
	case d2 is
	when "0000" =>
	sevensegment1 <= "0000001"; ---0
	when "0001" =>
	sevensegment1 <= "1001111"; ---1
	when "0010" =>
	sevensegment1 <= "0010010"; ---2
	when "0011" =>
	sevensegment1 <= "0000110"; ---3
	when others =>
	sevensegment1 <= "1111111"; ---null
	end case;
	 
	end process;
	
		process(d2)
	begin
	 
	case d2 is
	when "0000" =>
	sevensegment2 <= "0000001"; ---0
	when "0001" =>
	sevensegment2 <= "1001111"; ---1
	when "0010" =>
	sevensegment2 <= "0010010"; ---2
	when "0011" =>
	sevensegment2 <= "0000110"; ---3
	when others =>
	sevensegment2 <= "1111111"; ---null
	end case;
	 
	end process;

	
END dsdprojectfunc;