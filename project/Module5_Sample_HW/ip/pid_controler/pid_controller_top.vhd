library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pid_controller_top is
    port (
        clk : in std_logic;
        rst : in std_logic;
        we  : in std_logic;
        data_i:in std_logic_vector(95 downto 0);
        data_o:out std_logic_vector(31 downto 0)
    );
end pid_controller_top;

architecture rtl of pid_controller_top is
signal sdata_i:     std_logic_vector(95 downto 0);
signal sdata_o:     std_logic_vector(31 downto 0);
    component pid_controller
        generic
           (
                 -- size of input and output data --
                 iDataWidith    : integer range 8 to 32 := 32;
                 -- proportionally gain --
                 iKP            : integer range 0 to 7  := 3;  -- 0 - /2, 1 - /4, 2 - /8, 3 - /16, 4 - /32, 5 - /64, 6 - /128, 7 - /256
                 -- integral gain --
                 iKI            : integer range 0 to 7  := 2;  -- 0 - /2, 1 - /4, 2 - /8, 3 - /16, 4 - /32, 5 - /64, 6 - /128, 7 - /256
                 -- differential gain --
                 iKD            : integer range 0 to 7  := 2;  -- 0 - /2, 1 - /4, 2 - /8, 3 - /16, 4 - /32, 5 - /64, 6 - /128, 7 - /256
                 -- master gain --
                 iKM            : integer range 0 to 7  := 1;  -- 0 - /1, 1 - /2, 2 - /4, 3 - /8 , 4 - /16, 5 - /32, 6 - /64 , 7 - /128
                 -- delay between samples of error --
                 iDelayD        : integer range 1 to 16 := 10;
                 -- 0 - controller use derivative of PATERN_I and PATERN_ESTIMATION_I, 1 - controller use error to work --
                 iWork          : integer range 0 to 1  := 1   
                 );
     
        port
           (
                 CLK_I               : in  std_logic;
                 RESET_I             : in  std_logic;
                 -- error  --
                 ERROR_I             : in  std_logic_vector(iDataWidith - 1 downto 0);
                 -- threshold --
                 PATERN_I            : in  std_logic_vector(iDataWidith - 1 downto 0);
                 -- current sample --
                 PATERN_ESTIMATION_I : in  std_logic_vector(iDataWidith - 1 downto 0);
                 -- correction --
                 CORRECT_O           : out std_logic_vector(iDataWidith - 1 downto 0)
                 );
        
     end component;

begin
    inst_pid: pid_controller generic map(
        iDataWidith    => 32,
        iKP            => 3,
        iKI            => 2,
        iKD            => 2, 
        iKM            => 1,
        iDelayD        => 10,
        iWork          => 1   
    )port map(
        CLK_I  => clk,
        RESET_I => rst,
        ERROR_I => sdata_i(95 downto 64),
        PATERN_I => sdata_i(63 downto 32),
        PATERN_ESTIMATION_I => sdata_i(31 downto 0),
        CORRECT_O => sdata_o
    );

    sdata_i <= data_i;
end architecture;