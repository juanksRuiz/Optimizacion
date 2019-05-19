c = [-1;-1.4;0;0;0]
G = -eye(5,5);
q = [-0.1;-0.2;0;0;0];
A = [1,1,1,0,0;1,2,0,1,0;1,0,0,0,1];
b = [4;5.8;3];
x = [0.2;1.45;2.35;2.7;2.8];
u = ones(5,1);
v = zeros(3,1);


function tmx = tmax_U(u,du)
    tmx = 1e10;
    n = length(u)
    for i = 1:n
        if du(i) < 0
           tmx = min(tmx,-u(i)/du(i)) 
        end
    end
endfunction

function tmx = tmax_X(G,q,x,dx)
    tmx = 1e10;
    gx = G*x-q
    gd = G*dx
    n = length(x)
    for i = 1:n
        if gd(i) > 0
            tmx = min(tmx,-gx(i)/gd(i))
        end
    end
endfunction

//G*x0-q // < 0
//A*x0 -b = 0

gx = G*x-q;

mu = 10;

// eta moño
etam = -u'*gx;
//maxit = 1

tao = mu*5/etam;
rd = c+G'*u+A'*v;
rc = -u.*gx - ones(5,1)/tao;
rp = A*x-b;
rt = [rd;rc;rp];
//sistema: lado izquierdo
S1 = [zeros(5,5), G', A']
S2 = [-diag(u).*G, -diag(G*x-q), zeros(5,3)]
S3 = [A, zeros(3,5), zeros(3,3)]
S = [S1;S2;S3]
sol = -S\rt
dx = sol(1:5);
du = sol(6:10);
dv = sol(11:13);


tmxU = tmax_U(u,du)
tmxX = tmax_X(G,q,x,dx)

maxT = min(tmxX,tmxU)
tk = 0.99*maxT

x = x + tk*dx
u = u + tk*du
v = v + tk*dv





//a medida que la brecha dual es mas pequeña el tao es el mas grande y el probema se aproxima al  problema original
