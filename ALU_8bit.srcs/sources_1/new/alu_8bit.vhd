----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.11.2026 15:23:52
-- Design Name: 
-- Module Name: alu_8bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_8bit is
--  Port ( );
     Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);
        B       : in  STD_LOGIC_VECTOR(7 downto 0);
        opcode  : in  STD_LOGIC_VECTOR(2 downto 0);
        result  : out STD_LOGIC_VECTOR(7 downto 0);
        carry   : out STD_LOGIC;
        zero    : out STD_LOGIC
    );
end alu_8bit;

architecture Behavioral of alu_8bit is
     
begin   
     process(A, B, opcode)
        variable temp : unsigned(8 downto 0);
        variable result_temp : STD_LOGIC_VECTOR(7 downto 0);
    begin

        temp := (others => '0');
        result_temp := (others => '0');
        carry <= '0';

        case opcode is

            when "000" =>
                temp := ('0' & unsigned(A)) + ('0' & unsigned(B));
                result_temp := std_logic_vector(temp(7 downto 0));
                carry <= temp(8);

            when "001" =>
                temp := ('0' & unsigned(A)) - ('0' & unsigned(B));
                result_temp := std_logic_vector(temp(7 downto 0));
                carry <= temp(8);

            when "010" =>
                result_temp := A and B;

            when "011" =>
                result_temp := A or B;

            when "100" =>
                result_temp := A xor B;

            when "101" =>
                result_temp := not A;

            when "110" =>
                result_temp := std_logic_vector(shift_left(unsigned(A), 1));
                carry <= A(7);

            when "111" =>
                result_temp := std_logic_vector(shift_right(unsigned(A), 1));
                carry <= A(0);

            when others =>
                result_temp := (others => '0');

        end case;

        result <= result_temp;

        if result_temp = "00000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;

    end process;

end Behavioral;
