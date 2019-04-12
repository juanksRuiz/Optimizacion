function y = f(x)
    y1 = (x(1)-1)**4
    y2 = (x(2) + 2*x(2) - 3)**2
    y3 = (x(1) + 3*x(2) - x(3) + x(4) - 2)**2 + 10
    y = y1 + y2 + y3
endfunction

A = [1,2,3,4]
b = [10]
xmoño = [10;0;0;0] // x particular, fijo
z = [0;0;0]
B = [-2,-3,-4;1,0,0;0,1,0;0,0,1]//fijo

/*
xk = xmoño + B*z
[gr,H] = numderivative(f,xk,[],[],'blockmat')
gr = gr'
fmoño_2prima = B'*H*B
fmoño_prima = B'*gr
d = -fmoño_2prima\fmoño_prima
z = z+d


for i =1:3
    xk = xmoño + B*z

    [gr,H] = numderivative(f,xk,[],[],'blockmat')
    gr = gr'
    fmoño_2prima = B'*H*B
    fmoño_prima = B'*gr
    d = -fmoño_2prima\fmoño_prima
    z = z+d
end
 */
//----------------------------------------

[m,n] = size(A);
xv = zeros(5,1)

for i = 1:11
    disp("---------------------------------------")
    x = xv(1:n)
    v = xv(n+1:n+m)
    [gr,H] = numderivative(f,x,[],[],'blockmat')
    gr = gr'
    Fxv = [gr + A'*v;A*x - b]
    DF = [H A'; A zeros(m,m)]
    d = -DF\Fxv
    xv = xv + d
end
