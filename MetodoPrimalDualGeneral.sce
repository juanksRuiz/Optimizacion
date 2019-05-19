A = [2,1];
b = 5;
mu = 10;
u = [1;1;1];
x = [1.3;2.4];
v = 0;

function y = f(x)
    y = (x(1)-3)^4 - x(2)^2;
endfunction

function y = fprim(x)
    fp1 = 4*(x(1)-3)^3;
    fp2 = 2*x(2);
    y = [fp1;fp2];
endfunction

function gDesig = g(x)
    g1 = x(1)^2 + x(2)^2 - 25;
    g2 = x(1)-x(2) + 1;
    g3 = -x(1);
    gDesig = [g1;g2;g3];
endfunction

function Hessf = Hf(x)
    h1 = 12*(x(1)-3)^2;
    Hessf = [h1,0;0,2];
endfunction

//Calcular los Hgs
Hg1 = [2,0;0,2];
Hg2 = zeros(2,2);
Hg3 = Hg2;
function J = Jg(x)
    J = [2*x(1), 2*x(2); 1,-1;-1,0];
endfunction

function resD = rd(x)
    resD = fprim(x) + Jg(x)'*u + A'*v;
end

etam = -u'*g(x);
tao = mu*3/etam;

function resC = rc(x)
   resC = -u.*g(x) - ones(3,1)/tao;
endfunction

function resP = rp(x)
    resP = A*x-b;
endfunction
//Se para cuando el residuo sea casi 0

function resTao = r_tao(x)
    resTao = [rd(x);rc(x);rp(x)];
endfunction

function Sis = S(x)
    s1 = Hf(x) + Hg1 + Hg2 + Hg3;
    s2 = Jg(x)';
    s3 = A';
    s4 = -diag(u)*Jg(x)
    s5 = -diag(g(x));
    s6 = zeros(3,1);
    s7 = A;
    s8 = zeros(1,3);
    s9 = zeros(1,1);
    Sis = [s1,s2,s3;s4,s5,s6;s7,s8,s9];
endfunction

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


d = -S(x)\r_tao(x)
dx = d(1:2)
du = d(3:5)
dv = d(6)

x
u
v
g(x)
max(g(x))
etam
tao
r_tao(x)
norm(r_tao(x))
S(x)




