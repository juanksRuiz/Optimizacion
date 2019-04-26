tao = 2
x0 = [0.9;0]

function y = f(x)
    y = x(1) + x(2)
endfunction

//desigualdades
function y=g1(x)
    y = (x(1)^2) + (x(2)^2) - 2;
endfunction

function y= g2(x)
    y = (x(1)-2)^2 + (x(2)^2)-2;
endfunction


// gradiiente de desigualdades
function g = gr_d1(x)
    a = 2*x(1);
    b = 2*x(2);
    g = [a,b]';
endfunction

function g = gr_d2(x)
    a = 2*(x(1)-2);
    b = 2*x(2);
    g = [a,b]';
endfunction

//gradiente de funcion de barrera
function gr = grB(x)
    gr = -(gr_d1(x)/g1(x)) - (gr_d2(x)/g2(x))
endfunction

//hessiano de funcion barrera
function Hess =HB(x)
    H = [2,0;0;2];
    a = (gr_d1(x)*gr_d1(x)')/(g1(x)^2)) + (H/(-g1(x)))
    disp(a)
    b = (gr_d2(x)*gr_d2(x)')/(g2(x)^2) + (H/(-g2(x)))
    disp(a)
    Hess = [a b]
endfunction

gr_f = [1;1.1];
H_f = zeros(2,2);

function y = grad_f_tao(x)
    y = tao*gr_f + grB(x)
endfunction
g1(x0)
g2(x0)

fprim_tao = grad_f_tao(x0);
H_ftao = tao*H_f + HB(x0);
