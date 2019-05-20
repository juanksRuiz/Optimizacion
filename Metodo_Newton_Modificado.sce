function tmin = argmin(x,f,fp,d)
    maxit = 100;
    //Retroceso (backtracking)
    // f: funcion objetivo
    // fp: greadiente de f
    // d: direccion (suponemos que d ya es de descenso)
    alfa = 0.1; //0 < alfa < 0.5
    Beta = 0.5; //0.1 < Beta < 0.8
    tmin = 1;
    iter = 0;
    while ((f(x + tmin*d) > f(x) + alfa*tmin*fp(x)'*d) & (iter ~= maxit))
        tmin = tmin*Beta;
        iter = iter + 1;
    end
    if tmin == maxit then
        tmin = return(%inf)
    end
endfunction


//##############################################################################
function y = f1(x)
    y1 = (x(1)+1.5)*(x(1)+0.5)*(x(1)-0.5);
    y2 = (x(2)-0.5)*(x(2)-1.5)*(x(2)-2.5);
    y3 = 0.3*x(1)*x(2) + 0.01*(x(1)-3)^4 + 0.01*(x(2)-4)^4;
    y = y1 + y2 + y3;
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
    grf = [fp1;fp2];
endfunction

function Hess = Hf1(x)
    a = 6*x(1) + 3 + 0.12*(x(1)-3)^2;
    b = 0.3;
    c = 0.3;
    d = 6*x(2) + 0.12*(x(2)-4)^2 - 9;
    Hess = [a,b;c,d];
endfunction
//Con el metodo de Newton normal no se minimiza, ejemplo a continuacion
/*
function xk =  MN_Normal(x,Hf,fp,f)
    disp("f(x)")
    func = f(x)
    disp(func')
    H = Hf(x)
    disp("Hf")
    disp(H)
    fp = fp(x)
    disp("fp(x)")
    disp(fp')
    d = -H\fp
    printf("d")
    disp(d')
    xk = x+d;
endfunction

for i = 1:5
    disp("----------------------------");
    disp("k:");
    disp(i);
    x = MN_Normal(x,Hf1,f1p,f1);
    disp("x:")
    disp(x')
end

*/
//###########################

//###########################
function x_fx = MN_Modificado(x,f,fp,Hf,eps, maxit)
    //VER SI M(o H ) NO ES INVERTIBLE, EN ESE CASO PARA  EL METODO
    for k = 1:maxit
        disp("k")
        disp(k);
        disp(x,"x")
        disp("###############################################################")
        norm(fp(x))
        if(norm(fp(x)) <= eps) then
            disp("x:");
            disp(x');
            disp("fmin");
            disp(f(x)');
            x_fx = return(f(x)); /////////
        end
        lambda = 0;
        fink = 0;
        while fink == 0
            M = Hf(x) + lambda*eye(Hf(x));
            d = -M\fp(x);
            disp("-----------------------------------------------------------");
            disp("lambda");
            disp(lambda);
            disp("M");
            disp(M);
            disp("d");
            disp(d');
            disp("x + d");
            disp((x+d)');
            disp("fp(x)^T*d")
            disp(fp(x)'*d)
            if f(x+d) < f(x) then
                x = x + d;
                fink = 1;
            elseif fp(x)'*d < 0 then
                tk = argmin(x,f,fp,d);
                if isinf(tk) then
                    disp("f(x + td)  NO TIENE MINIMIZADOR");
                    x_fx = return(-%inf);
                end
                x = x + tk*d;
                fink = 1;
            else
                // El aumento de lambda es arbitrario
                lambda = lambda + 2.89; 
            end
    end
    end
endfunction
//-------------------------------------------------------
// Pruebas con la funcion
x = [-2.5;1]
x_fx = MN_Modificado(x,f1,f1p,Hf1,0.01,100)

//(x,f,fp,Hf,eps, maxit)
