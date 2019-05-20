// Metodo barrera logaritmica con problema de optimizacion lineal

// Metodo de Newton en Rn sin restricciones:
//Numericamente;
function xk = MetodoNewton(f,x0,n)
    // f: funcion que se busca minimizar;
    // x: punto inicial;
    // n: numero de iteraciones;
    // retorna el x*;
    xk = x0;
    for i = 1:n
        disp(xk)
        [gr,H] = numderivative(f,xk,[],[],'blockmat');
        gr = gr';
        d = -H\gr
        xk = xk + d 
    end
endfunction

// con calculos algebraicos previos;
function xk = MetodoNewton2(f,x0,n,grf,Hf)
    // f: funcion que se busca minimizar;
    // x: punto inicial;
    // n: numero de iteraciones;
    // grf: gradiente columna de f que depende de x;
    // H: Hessiana de funcion f que depende de x;
    // retorna el x*;
    disp("x")
    disp(x)
    xk = x0
    for i = 1:n
        disp("xk")
        disp(xk)
        disp("Hessiano en x")
        disp(Hf(xk)) ///////////////////////////////////////////  ERROR
        disp("gradiente en x")
        disp(grf(xk))
        d = -Hf(xk)\grf(xk)
        xk = xk + d
        disp("xk actualizado")
        disp("---------------------------------------------------------")
    end
endfunction

//##############################################################################
A = [1,1;1,2;1,0;-1,0;0,-1];
b = [4;5.8;3;0;0];
c = [-1;1.4];
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
    g = [g1;g2;g3;g4;g5];
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


//Gradiente de B
function g= grB(x)
    g = A'*d;
endfunction
grB(x)

// Hessiana de B;
function H = HB(x)
    H = A'*(diag(d)*diag(d))*A;
endfunction
HB(x)

//Funcion f_t, gradiente y Hessiana;
function y= ft(x,t,func,Bar)
    y = t*func(x) + Bar(x)
endfunction
ft(x,t,f,B)

function y = grft(x)
    //c: coeficientes de la funcion lineak que se está minimizando;
    y = t*c + grB(x);
endfunction
grft(x)


function H = Hft(x)
    disp("x")
    disp(x)
    H = HB(x);
endfunction


// xk = MetodoNewton2(f,x0,n,grf,Hf)
MetodoNewton2(ft,x,10,grft,Hft)



