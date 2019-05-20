// Metodo barrera logaritmica con problema de optimizacion lineal

// Metodo de Newton en Rn sin restricciones:

// con calculos algebraicos previos;
function xk = MetodoNewton(f,x0,n,dsol)
    // f: funcion que se busca minimizar;
    // x: punto inicial;
    // n: numero de iteraciones;
    // grf: gradiente columna de f que depende de x;
    // H: Hessiana de funcion f que depende de x;
    // retorna el x*;
    //Gradiente de B
    grB = A'*dsol;
    // Hessiana de B;
    Hb = A'*(diag(dsol)*diag(dsol))*A
    disp("Hessiano en x")
    disp(Hb) ///////////////////////////////////////////  ERROR
    disp("gradiente en x")
    disp(grB)
    grft = t*c + grB
    disp("x")
    disp(x)
    xk = x0
    for i = 1:n
        disp(i)
        disp("xk")
        disp(xk)
        d = -Hb\grft
        M  = 1.1 // M > 0
        tmax = tmax_g(g,xk,d,M)
        disp(tmax,"tmax: ")
        tk = min(1,0.99*tmax)
        disp("t: ")
        disp(tk)
        xk = xk + tk*d
        disp("xk actualizado")
        disp("---------------------------------------------------------")
        end
endfunction

//============================================================================
function tmx = tmax_g(g, x, d, M)
    //
    // tmx = max { t  :  g( x + t d ) <= 0, 
    //             0 < t <= M }
    //
    // se supone que  g(x) < 0
    //
    //                0 < M
    //
    // utiliza biseccion (o dicotomia) y secante
    //
    //*************************
    EPS0 = 1.0e-8
    EPS  = 1.0e-6
    //*************************
    
    //escrVectED(x, 'x en tmax'), escrVectED(d, 'd')
    g0 = g(x)
    if max(g0) >= -EPS0
    printf('El punto no es estrictamente factible.\n')
    tmx = -1000
    return
    end
    gM = g(x + M*d)
    //escrVectED(gM, 'g(x+Md)')
    if max(gM) <= EPS0
    tmx = M
    return
    end
    
    a = 0
    b = M
    c0 = M/3
    c1 = 2*M/3
    gc0 = max( g( x + c0*d ) )
    gc1 = max( g( x + c1*d ) )
    
    while (b-a) >= EPS
    //escrVectED([a b], 'a b')
    deno = gc1 - gc0
    if abs(deno) < EPS0
        c2 = c1 + 0.01
    else
        c2 = c1 - gc1*(c1-c0)/deno
    end

    gc2 = max( g( x + c2*d ) )
    if 0 < c2 & c2 <= M & abs(gc2) <= EPS0
        //printf('secante\n')
        tmx = c2
        return
    end
    c0 = c1, gc0 = gc1
    c1 = c2, gc1 = gc2
    
    m = (a+b)/2
    gm = max( g(x + m*d) )
    
    if abs(gm ) <= EPS0
        tmx = m
        return
    end
    
    if gm > 0
        b = m
    else
        a = m
    end
    end
    tmx = (a+b)/2
endfunction // tmax_g
//============================================================================


//----------------------------------------------------------
//##############################################################################
A = [1,1;1,2;1,0;-1,0;0,-1];
b = [4;5.8;3;0;0];
c = [-1;-1.4];
t = 1
x = [1;1];


//Funcion f;
function y= f(x)
    y = -x(1)-1.4*x(2);
endfunction
f(x)


fp = c;
Hf = zeros(2,2)
// g_i(x) < 0
function g = g(x)
    g1 = x(1) + x(2) - 4;
    g2 = x(1) + 2*x(2)-5.8;
    g3 = x(1)-3;
    g4 = -x(1);
    g5 = -x(2);
    g = [g1;g2;g3;g4;g5]
endfunction

// el gradiente es el vector c y la Hessiana es la matriz 0;

function y= B(x)
    y = -sum(-log(g(x)))
endfunction


d = [];
//creando vector d;
for i = 1:length(b)
    d(i) = 1/(b(i)-A(i,:)*x);
end


//Funcion f_t, gradiente y Hessiana;
function y= ft(x,t,func,Bar)
    y = t*func(x) + Bar(x)
endfunction
ft(x,t,f,B)
/*
function y = grft(x)
    //c: coeficientes de la funcion lineak que se está minimizando;
    y = t*c + grB;
endfunction
*/
//grft(x)


function H = Hft(x)
    H = HB(x);
endfunction


xf = MetodoNewton(ft,x,20,d)
