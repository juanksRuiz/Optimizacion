function y = f1(x)
    y1 = (x(1)+1.5)*(x(1)+0.5)*(x(1)-0.5)
    y2 = (x(2)-0.5)*(x(2)-1.5)*(x(2)-2.5)
    y3 = 0.3*x(1)*x(2) + 0.01*(x(1)-3)^4 + 0.01*(x(2)-4)^4
    y = y1 + y2 + y3
endfunction

/*
x0 = [-2.5;1];
xf = 0;
fxf = 0;
deriv_xf = 0;
deriv2_xf = 0;
*/
/*
function x_fx = MNMod(f,x0,eps,maxit)
    xk = x0
    [gr,H] = numderivative(f,xk,[],[],'blockmat')
    if norm(gr) <= eps then
        x_fx = [xk,f(xk)]
    end
    lambda = 0
    fink = p
    while fink == 0
        M = H+ lambda*eye(size(H)(0),size(H)(0))
        dk = M\-gr'
        if f(xk + df) < f(xk) then
            xk = xk + dk
            fink = 1
        elseif gr'*dk < 0 then
            // Crear funcion de argumento t que minimiza f(xk + tdk))
            T = -100:0.1:100
            
        end 
    end
endfunction
*/
/*
[gr,H] = numderivative(f1,x0,[],[],'blockmat')
r = MNMod(f1,x0,0.01,2)
*/
