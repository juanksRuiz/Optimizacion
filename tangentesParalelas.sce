//Métodos de ayuda
function tmin = argmin(x,f,fprim,d)
    maxit = 10000;
    //Retroceso (backtracking)
    // f: funcion objetivo
    // fp: greadiente de f
    // d: direccion (suponemos que d ya es de descenso)
    alfa = 0.1; //0 < alfa < 0.5
    Beta = 0.5; //0.1 < Beta < 0.8
    tmin = 1;
    iter = 0;
    disp(f(x + tmin*d),"(f(x + tmin*d)")
    while ((f(x + tmin*d) > f(x) + alfa*tmin*fprim(x)'*d) & (iter ~= maxit))
        tmin = tmin*Beta;
        iter = iter + 1;
    end
    if tmin == maxit then
        tmin = return(%inf)
    end
endfunction
//==============================================================================
function y = f(x)
    a = 0.1*x(1)^2 + x(2)^2 + 10*x(3)^2 + 100*x(4)^2; 
    b = - 0.2*x(1) - 2*x(2) - 20*x(3) - 200*x(4);
    y = a+b;
endfunction

function fprim = fp(x)
    fp1 = 0.2*x(1) - 0.2;
    fp2 = 2*x(2) - 2;
    fp3 = 20*x(3) - 20;
    fp4 = 200*x(4) - 200;
    fprim = [fp1;fp2;fp3;fp4];
endfunction

//Metodo de tangentes paralelas
function xmin = ParTan(x,eps,f,fprim,maxit)
    n = 5; // pra el for de adentro, es arbitrario
    for k = 1:maxit
        disp("################################################################")
        y1 = x;
        if norm(fprim(y1)) <= eps
            x = return(x);
        end
        d = -fprim(y1);
        t = argmin(x,f,fprim,d);
        if isinf(-t) then
            disp(" F NO TIENE MINIMIZADOR");
            xmin = return(x);
        end
        y2 = y1 + t*d;
        for j = 2:n
            disp("------------------------------------------------------------")
            disp (j,"j")
            if norm(fprim(y2)) <= eps
                x = y2; // o parar el metodo y retornar el ultimo x que se tenía
                break
            end
            dj = -fprim(y2)
            tj = argmin(y2,f,fprim,dj)
            if isinf(-tj) then
                tj = 0;
                disp("F NO TIENE MINIMIZDOR");
                xmin = return(x);
            end
            zj = y2 + tj*dj;
            deltaj = zj - y1;
            muj = argmin(zj,f,fprim,deltaj);
            disp(y2',"yj");
            disp(fprim(y2)', "fp(yj)")
            disp(dj', "dj");
            disp(zj', "zj");
            disp(deltaj', "deltaj");
            disp(muj', "muj")
            temp = y2
            y2 = zj + muj*deltaj;
            y1 = temp
        end
        xmin = y2
      end
endfunction

//------------------------
//Pruebas
x = [2;3;4;5];
xminf = ParTan(x,0.001,f,fp,1)
//ParTan(x,eps,f,fprim,maxit)
