// Se resuelve agregando una variable más

function y = f(x)
    y = x(1) + x(2);
endfunction

//Desigualdades
function G = g(x)
    g1 = x(1)^2 + x(2)^2 - 2;
    g2 = (x(1)-2)^2 + x(2)^2 - 2; 
    G = [g1;g2];
endfunction

//Gradiente de desigualdades
function gprim = gp(x)
    g1 = 2*x(1);
    g2 = 2*(x(1)-2);
    g3 = 2*x(2);
    g4 = 2*x(2);
    gprim = [g1,g2;g3,g4];
endfunction

// Gradiente desigualdades modificadas
function Gpm = gm(x)
    g = gp(x);
    Gm = g;
    Gpm = [Gm; -ones(1,size(g,2))];
endfunction

//#############################################################################



x0 = [2;-1];


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

//ese punto si es factible

// Para el problema de KKT arrancamos de 0
xmv0 = [2;-1;3.1;0];
