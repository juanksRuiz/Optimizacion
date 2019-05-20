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
function xk = MetodoNewton2(f,x,n,grf,Hf)
    // f: funcion que se busca minimizar;
    // x: punto inicial;
    // n: numero de iteraciones;
    // grf: gradiente columna de f que depende de x;
    // H: Hessiana de funcion f que depende de x;
    // retorna el x*;
    for i = 1:n
        x
        disp("Hessiano en x")
        disp(Hf(x))
        disp("gradiente en x")
        disp(grf(x))
        d = -Hf(x)\grf(x)
        x = x + d
        disp("xk")
        disp(x)
        disp("xk actualizado")
    end
endfunction

//##############################################################################
A = [1,1;1,2;1,0;-1,0;0,-1];
b = [4;5.8;3;0;0];
c = [-1;1.4];


//Funcion f;
function y= f(x)
    y = -x(1)-1.4*x(2);
endfunction

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
function g= gr_B(x)
    g = A'*d;
endfunction

// Hessiana de B;
function H = H_B(x)
    H = A'*(diag(d)*diag(d))*A;
endfunction

H_B(x)

t = 1
x = [1;1];


//Funcion f_t, gradiente y Hessiana;
function y= ft(x,t,f,B)
    y = t*f(x) + B(x)
endfunction

function y = gr_ft(x)
    //c: coeficientes de la funcion lineak que se está minimizando;
    y = t*c + gr_B(x);
endfunction

function H = Hft(x)
    H = H_B(x);
endfunction

grft = gr_ft(x);
H_ft = Hft(x)


// xk = MetodoNewton2(f,x0,n,grf,Hf)
MetodoNewton2(ft,x,10,gr_ft,Hft)



