function y = f(x)
    a = (x(1) + 2*x(2) -10)^2
    b = (x(1) + x(2)+ x(3) - 15)^2
    y = a+b
endfunction

function deriv = fp(x)
    a = 4*(x(1)+2*x(2) - 10) + (x(1) + x(2)+ x(3) - 15)
    b = 8*(x(1)+2*x(2)-10)^3 + (x(1) + x(2)+ x(3) - 15)
    c = (x(1) + x(2)+ x(3) - 15)
    deriv = [a;b;c]
endfunction

x = [1;1;1];

fp(x)

sist = []
