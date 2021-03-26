library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
USE work.aux_package.FA;

ENTITY AdderSub IS
    GENERIC (n: INTEGER := 8);
    port(   y,x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            subctl: IN STD_LOGIC;
            res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            cout: OUT STD_LOGIC);
END AdderSub;

architecture AddSub of AdderSub is
    subtype vec is STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    signal carries: vec;
    signal newx: vec;
begin
    ---- when subctl is 1 we subtract
    ---- generate the new x with x xor subctl as seen in figure 2
    g1: FOR i IN 0 TO (n-1) GENERATE
        newx(i) <= x(i) xor subctl;
    END GENERATE;

    ---- connect the relevant signal to the full adder
    ---- notice c in is subctl, needed because of 2's complement.
    first: FA PORT MAP(
            xi => newx(0),
            yi => y(0),
            cin => subctl,
            s => res(0),
            cout => carries(0)
        );

    ---- chain the rest of the full adders as seen in figure 2
    rest: for i in 1 to (n-1) GENERATE
        chain: FA PORT MAP(
            xi => newx(i),
            yi => y(i),
            cin => carries(i-1),
            s => res(i),
            cout => carries(i)
        );
    end GENERATE;

    ---- cout is the output carry of the last full adder
    cout <= carries(n-1);
    
    
end AddSub;
