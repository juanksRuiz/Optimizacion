
//##############################################################################
function y = f1(x)
    y1 = (x(1)+1.5)*(x(1)+0.5)*(x(1)-0.5)
    y2 = (x(2)-0.5)*(x(2)-1.5)*(x(2)-2.5)
    y3 = 0.3*x(1)*x(2) + 0.01*(x(1)-3)^4 + 0.01*(x(2)-4)^4
    y = y1 + y2 + y3
endfunction

function grf = f1p(x)
    fp11 = (x(1)+0.5)*(x(1)-0.5);
    fp12 = (x(1)+1.5)*(x(1)-0.5);
    fp13 = (x(1)+1.5)*(x(1)+0.5) + 0.3*x(2) + 0.04*(x(1)-3)^3;
    fp21 = (x(2)-1.5)*(x(2)-2.5);
    fp22 = (x(2)-0.5)*(x(2)-2.5);
    fp23 = (x(2)-0.5)*(x(2)-1.5) + 0.3*x(1) + 0.04*(x(2)-4)^3;
    fp1 = fp11 + fp12 + fp13;
    fp2 = fp21 + fp22 + fp23;
    grf = [fp1;fp2]
endfunction

function Hess = Hf1(x)
    a = 6*x(1) + 3 + 0.12*(x(1)-3)^2;
    b = 0.3;
    c = 0.3;
    d = 6*x(2) + 0.12*(x(2)-4)^2 - 9;
    Hess = [a,b;c,d]
endfunction
//Con el metodo de Newton normal no se minimiza, ejemplo a continuacion
function xk =  MN_Normal(x,Hf,fp,f)
    printf("f(x)")
    func = f(x)
    disp(func')
    H = Hf(x)
    printf("Hf")
    disp(H)
    fp = fp(x)
    printf("f prima:")
    disp(fp')
    d = -H\fp
    printf("d")
    disp(d')
    xk = x+d
endfunction


x = [-2.5;1];
for i = 1:5
    printf("----------------------------")
    printf("k:")
    disp(i)
    x = MN_Normal(x,Hf1,f1p,f1)
end



function x_fx = MN_Modificado(x,eps)
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
    fink = 0
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
