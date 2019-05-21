function y = f(x)
    y = 2*x(1)^4 + (x(1) + x(2) - 1)^2
endfunction

//funcion objetivo
function y = phi(x,t,f,d)
    y = f(x + t*d)
endfunction

//Encontrar t moño mejor que tk
function tmono = findTm(f,x,d,tk,eps,hinic,phi)
    //en R
    h = hinic;
    phik = phi(x,tk,f,d);
    info = 0;
    while abs(h) > eps
        disp(phi(x,tk+h,f,d),"fi(x)");
        if phi(x,tk + h,f,d) < phik
            tmono = tk + h;
            info = 1;
            break;
        elseif phi(x,tk - h,f,d) < phik
            tmono = tk - h;
            info=1;
        end
        h = h/2;
    end
endfunction

//Encontrar 3 puntos
function [tao1,tao2,tao3] = find3points(f,x,d,tk,tm,K,phi)
    // K es demasiado grande. >>0
    tao1 = tk;
    phi1 = phi(x,tao1,f,d);
    tao2 = tm;
    phi2 = phi(x,tao2,f,d);
    tao3 = tao2;
    while abs(tao3) < K
        disp("=======================================================");
        disp(phi2,"phi2");
        disp(phi3,"phi3");
        disp(abs(tao3),"tao3")
        tao3 = tao2 + 2*(tao2 - tao1);
        phi3 = phi(x,tao3,f,d);
        if phi3 >= phi2
            return;
        else
            tao1 = tao2;
            tao2 = tao3;
            phi1 = phi2;
            phi2 = phi3;
        end
    end
endfunction

function tk = nextTk(x,t1,t2,t3,phi,f,d)
    phi1 = phi(x,t1,f,d);
    phi2 = phi(x,t2,f,d);
    phi3 = phi(x,t3,f,d);
    a = ((t2 - t1)^2)*(phi2 - phi3);
    b = ((t2 - t3)^2)*(phi2 - phi1);
    c = (t2 - t1)*(phi2 - phi3);
    d = (t2 - t1)*(phi2 - phi1);
    tp = t2 - 0.5*(a-b)/c-d;
    disp(tp,"tp");
    disp(phi(x,tp,f,d),"fi(tp");
    tk = min(phi(x,t2,f,d),phi(x,tp,f,d));
endfunction

function tmin = TresPuntosFinal(f,x,d,tk,eps,hinic,phi)
    tm = tk;
    while norm(phi(x,tm,f,d))>= 0.1
        tm = findTm(f,x,d,tk,eps,hinic,phi)
        K = 1000;
        [t1,t2,t3] = find3points(f,x,d,tk,tm,K,phi)
        tm = nextTk(x,t1,t2,t3,phi,f,d)
    end
    tmin = tm;
endfunction

//x y d son siempre dados
x = [3;4];
d = [-5;-1];
tk = 1;
eps = 0.001;
hinic = 0.1;

//tm = findTm(f,x,d,tk,eps,hinic,phi)

tm = 1.5;
K = 10000;
//find3points(f,x,d,tk,tm,K,phi)
[t1,t2,t3] =find3points(f,x,d,tk,tm,K,phi)
disp(t1)
disp(t2)
disp(t3)

//tmin = TresPuntosFinal(f,x,d,tk,eps,hinic,phi)
