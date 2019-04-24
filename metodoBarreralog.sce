A = [1,1;1,2;1,0;-1,0;0,-1];
b = [4;5.8;3;0;0];
c = [-1;1.4];

t = 1
x = [1;1];


function y= f(x)
    y = -x(1)-1.4*x(2)
endfunction

function y= B(x)
     y1 = -log(-x(1)-x(2));
     y2 = -log(-x(1)-2*x(2));
     y3 = -log(-x(1));
     y4 = -log(x(1)) - log(x(2));
     y = y1 + y2 + y3 + y4
endfunction


function y= f_t(x,t,f,B)
    y = t*f(x) + B(x)
endfunction


d = [];
//creando vector d
for i =1:length(b)
    d(i) = 1/(b(i)-A(i,:)*x0)
end

grad_B = A'*d
Hess_B = A'*(diag(d)*diag(d))*A

maxit = 10;

//[gr_f_t,Hf_t] = numderivative(f)
