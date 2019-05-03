function y = g1(x)
    y = x(1)^2 + x(2)^2 - 2
endfunction

function y = g2(x)
    y = (x(1)-2)^2 + x(2)^2 - 2
endfunction

x0 = [2;-1];

g1(x0)
g2(x0)

// x0m = [2;-1;3.1]

function y = g1m(x)
    y = x(1)^2 + x(2)^2 - 2 - x(3)
endfunction


function y = g2m(x)
    y = (x(1)-2)^2 + x(2)^2 - 2 - x(3)
endfunction

x0m = [2;-1;3.1;]
g1m(x0m)
g2m(x0m)

ese punto si es factible

// Para el problema de KKT arrancamos de 0
xmv0 = [2;-1;3.1;0];