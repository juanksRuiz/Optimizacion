function y = f(H,c,k,x)
    y = 0.5*x'*H*x + c'*x+k;
endfunction

function r = verif_matDP(mat)
    //funcion que verifica si la matriz es semidefinida positiva
    //mat: matriz 3x3
    d0 = mat(1);
    d1 = det(mat(1:2,1:2));
    d2 = det(mat)
    r = [d0,d1,d2]
endfunction
H1 = [10,2,-17;2,19,-6;-17,-6,31];
c1 = [12;-14;9];
k = 0;

H2 = [8,6,-4;6,9,-9;-4,-9,10];
c2 = [-32;-27;20];

H3 = [18,-3,15;-3,5,-1;15,-1,13];
c3 = [-62,;0;-56];
//gradinte de la funcion: H*x + c
x1 = H1\-c1;
r1 = verif_matDP(H1)

x2 = H2\-c2;
r2 = verif_matDP(H2)

x3 = H3\-c3;
r3 = verif_matDP(H3)

t = -1.2:0.1:4
plot([4.5,1.5])
