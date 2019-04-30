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
        [gr,H] = numderivative(f,x,[],[],'blockmat');
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
    xk = x0;
    for i = 1:n
        d = -Hf(xk)\grf(xk)
        xk = xk + d
        disp("xk",i)
        disp(xk)
    end
endfunction

A = [1,1;1,2;1,0;-1,0;0,-1];
b = [4;5.8;3;0;0];
c = [-1;1.4];

t = 1
x = [1;1];

//Funcion f;
function y= f(x)
    y = -x(1)-1.4*x(2);
endfunction

// el gradiente es el vector c y la Hessiana es la matriz 0;

function y= B(x)
     y1 = -log(-x(1)-x(2));
     y2 = -log(-x(1)-2*x(2));
     y3 = -log(-x(1));
     y4 = -log(x(1)) - log(x(2));
     y = y1 + y2 + y3 + y4;
endfunction


d = [];
//creando vector d;
for i = 1:length(b)
    d(i) = 1/(b(i)-A(i,:)*x);
end
// gradiente y hessiana de funcion B(x);
//gradiente;
function g = gr_B(x)
    g = A'*d;
endfunction

// Hessiana;
function H = H_B(x)
    H = A'*(diag(d)*diag(d))*A;
endfunction
//----------------------------------------------------
grB = gr_B(x);
H_B = H_B(x);


//Funcion f_t, gradiente y Hessiana;
function y= ft(x,t,f,B)
    y = t*f(x) + B(x)
endfunction

function y = gr_ft(x)
    //c: coeficientes de la funcion lineak que se está minimizando;
    y = t*c + grB
endfunction

function H = Hft(x)
    H = H_B
endfunction

grft = gr_ft(x)
H_ft = Hft(x)

MetodoNewton2(f,x,10,gr_ft,Hft)




