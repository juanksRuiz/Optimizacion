function b = vp(d)
    for  i = 1:length(d)
         if d(i) < 0
            b = %f;
            return
         end
    end
    b = %t
endfunction


function tmaxAf = tmaxAfin(psi,d)
    minimo = 1e10;
    //Primero hacer un for que verifique si d > = 0
    if(vp(d) == %t)
        tmaxAf = 100000;
    else
        for i = 1:length(d)
             if -psi(i)/d(i) < minimo
                minimo = -psi(i)/d(i)
             end
        end
        tmaxAf = minimo
    end
endfunction

function newT = newTk(tmax)
    newT = min(1,0.99*tmax)
endfunction

//Primero convertir problema en la forma estandar

x = [1;1;2;2.8;2]
y = [-0.3;-0.6;-0.3]
s = [0.2;0.1;0.3;0.6;0.3]
c = [-1;-1.4;;0;0;0]
A = [1,1,1,0,0;1,2,0,1,0;1,0,0,0,1]
b = [4;5.8;3]

//Verificar que se cumple que el resiuo primal es 0 y el residuo dual es 0
rp = A*x-b
rd = A'*y + s - c
rc = x.*s

m1 = zeros(5,5);
m3 = eye(5,5);
m5 = zeros(3,3);
m6 = zeros(3,5);
S = diag(s);
m8 = zeros(5,3);
X = diag(x);



M = [m1, A', m3; A,m5, m6; S, m8, X]

der = [zeros(5,1); zeros(3,1);rc];
d = -M\der
dx = d(1:5);
dy = d(6:8);
ds = d(9:13);

tmax = tmaxAfin([x;s],[dx;ds])

tk = newTk(tmax)


// hacer el metodo primal dual afin no factible
