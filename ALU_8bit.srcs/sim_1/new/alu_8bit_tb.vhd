----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.11.2026 15:57:25
-- Design Name: 
-- Module Name: alu_8bit_tb - Behavioral
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

entity alu_8bit_tb is
--  Port ( );
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is
signal A      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal opcode : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

    signal result : STD_LOGIC_VECTOR(7 downto 0);
    signal carry  : STD_LOGIC;
    signal zero   : STD_LOGIC;
begin
 uut: entity work.alu_8bit
        port map (
            A      => A,
            B      => B,
            opcode => opcode,
            result => result,
            carry  => carry,
            zero   => zero
        );

    stimulus: process
    begin

        -- ADD: 10 + 5 = 15
        A <= x"0A";
        B <= x"05";
        opcode <= "000";
        wait for 10 ns;

        assert result = x"0F"
            report "ADD test failed"
            severity error;

        -- SUB: 10 - 5 = 5
        opcode <= "001";
        wait for 10 ns;

        assert result = x"05"
            report "SUB test failed"
            severity error;

        -- AND: 0F AND 05 = 05
        A <= x"0F";
        B <= x"05";
        opcode <= "010";
        wait for 10 ns;

        assert result = x"05"
            report "AND test failed"
            severity error;

        -- OR: 0F OR 05 = 0F
        opcode <= "011";
        wait for 10 ns;

        assert result = x"0F"
            report "OR test failed"
            severity error;

        -- XOR: 0F XOR 05 = 0A
        opcode <= "100";
        wait for 10 ns;

        assert result = x"0A"
            report "XOR test failed"
            severity error;

        -- NOT A: NOT 0F = F0
        opcode <= "101";
        wait for 10 ns;

        assert result = x"F0"
            report "NOT test failed"
            severity error;

        -- Shift left: 0F << 1 = 1E
        A <= x"0F";
        opcode <= "110";
        wait for 10 ns;

        assert result = x"1E"
            report "SHIFT LEFT test failed"
            severity error;

        -- Shift right: 0F >> 1 = 07
        opcode <= "111";
        wait for 10 ns;

        assert result = x"07"
            report "SHIFT RIGHT test failed"
            severity error;

        -- Zero flag test: 5 - 5 = 0
        A <= x"05";
        B <= x"05";
        opcode <= "001";
        wait for 10 ns;

        assert result = x"00" and zero = '1'
            report "ZERO flag test failed"
            severity error;

        report "All ALU tests completed!" severity note;

        wait;

    end process;

end Behavioral;
