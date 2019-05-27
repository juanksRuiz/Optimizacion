//Autor: Juan Camilo Ruiz

function tmin = argmin(x,f,fp,d)
    maxit = 100;
    //Retroceso (backtracking)
    // x: punto inicial
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

function lam = newLambda(M)
    // Metodo que calcula un lambda maximo dada la matriz M 
    // para que no se vuelva demasiado lento
    vecSigma = [];
    for i = 1:size(M,1)
        s = 0;
        for j = 1:size(M,2)
             if i~=j
                 s = s + abs(M(i,j))
             end
        end
        vecSigma(i) = s;
    end
    sigma = max(vecSigma - diag(M));
    lam = max(sigma,0);
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
//==============================================================================
function y = f2(x)
    a = x(1)^4 - 11*x(1)^3+41*x(1)^2;
    b = -61*x(1) + 30 +(x(1) - x(2))^2 + (x(2) + x(3)-1)^2;
    y = a+b;
endfunction

function grf2 = f2p(x)
    a = 4*x(1)^3 + 82*x(1)-61-33*x(1)^2 + 2*(x(1)-x(2));
    b = -2*(x(1)-x(2)) + 2*(x(2)+x(3)-1);
    c = 2*(x(2)+x(3)-1);
    grf2 = [a;b;c];
endfunction

function H = Hf2(x)
    h1 = 12*x(1)^2 + 82 - 66*x(1) + 2;
    H = [h1,-2,0;-2,4,2;0,2,2];
endfunction


//==============================================================================
function y = f3(x)
    a = (x(1)-2)^2 + 3*(x(1)^2-x(2))^2
    y = a;
endfunction

function grf3 = f3p(x)
    a = 2*(x(1)-2) + 12*(x(1)^2-x(2))*x(1);
    b = -6*(x(1)^2-x(2))
    grf3 = [a;b];
endfunction

function H = Hf3(x)
    h1 = 2 + 12*(3*x(1)^2 - x(2))
    h2 = -12*x(1)
    h3 = h2
    h4 = 6
    H = [h1,h2;h3,h4];
endfunction

//==============================================================================

function y = f4(x)
    a = (x(1)-x(2))^2 - (x(2)+x(3)-1)^2
    y = a;
endfunction

function grf4 = f4p(x)
    a = 2*(x(1)-x(2))
    b = -2*(x(1)-x(2)) - 2*(x(2)+x(3)-1)
    c = -2*(x(2)+x(3)-1)
    grf4 = [a;b;c];
endfunction

function H = Hf4(x)
    H = [2,-2,0;-2,0,-2;0,-2,-2];
endfunction

//==============================================================================

function y = f5(x)
    a = (x(1)-2)^2 + (x(2)-3)^3
    y = a;
endfunction

function grf5 = f5p(x)
    a = 2*(x(1)-2)
    b = 3*(x(2)-3)^2
    grf5 = [a;b];
endfunction

function H = Hf5(x)
    a = 6*(x(2)-3)
    H = [2,0;0,a];
endfunction

//#############################################################################
function x_fx = MN_Modificado(x,f,fp,Hf,eps, maxit)
    // x: punto inicial
    // f: funcion objetivo
    // fp: gradiente de función objetivo
    // Hf: Hessiana de funcion objetivo
    // eps: cota para ver si la derivada es cercana a 0
    // maxit: Numero maximo de iteraciones del método
    for k = 1:maxit
        disp("###############################################################")
        disp("Nueva iteracion")
        disp(k,"k");
        disp(x,"x")
        disp(norm(fp(x)),"||fp(x)||");
        if(norm(fp(x)) <= eps) then
            disp("x:");
            disp(x');
            disp("fmin");
            disp(f(x)');
            x_fx = return(f(x));
        end
        topLambda = newLambda(Hf(x));
        lambda = 0;
        fink = 0;
        while fink == 0
            M = Hf(x) + lambda*eye(Hf(x));
            disp(det(M),"det(M)")
            if det(M) == 0 then
                disp("M NO ES INVERTIBLE")
                x_fx = return(-1);
            end
            d = -M\fp(x);
            disp("-----------------------------------------------------------");
            disp(lambda,"lambda");
            disp(M,"M");
            disp(d,"d");
            disp((x+d)',"x + d");
            disp(f(x+d),"f(x + d)")
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
                // El aumento de lambda NO es arbitrario
                lambda = lambda + topLambda/3; 
            end
    end
end
disp("NUMERO MAXIMO DE ITERACIONES ALCANZADO")
endfunction


//-------------------------------------------------------
// Pruebas
// Ejemplo con apuntes adicionales


x1 = [-2.5;1]
x_fx1 = MN_Modificado(x1,f1,f1p,Hf1,0.01,100)


//Nuevas funciones

/*
x2 = [-1;2;1];
x_fx2 = MN_Modificado(x2,f2,f2p,Hf2,0.01,100)
//(x,f,fp,Hf,eps, maxit)
*/


/*
x3 = [-1;2];
x_fx3 = MN_Modificado(x3,f3,f3p,Hf3,0.01,1000)
//(x,f,fp,Hf,eps, maxit)
*/


/*
x4 = [-1;2;1];
x_fx4 = MN_Modificado(x4,f4,f4p,Hf4,0.01,100)
//(x,f,fp,Hf,eps, maxit)
*/

/*
x5 = [-1;2];
x_fx5 = MN_Modificado(x5,f5,f5p,Hf5,0.01,100)
//(x,f,fp,Hf,eps, maxit)
*/

// NUMERO MAX DE ITERACIONES ALCANZADO
