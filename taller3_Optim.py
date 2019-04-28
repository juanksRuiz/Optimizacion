from taller1_Optim import min1abFB
from taller2_Optim import minF_enR
import numpy as np

LIM_INF = -1000
LIM_SUP = 1000
h = 0.1
Eps_Interval = 2*h #Error de los intervalos
E = 10**(-5) #Error entre dos minimos
a = -1
b = 1

def f1(x):
    res = (x[0]**2) + (x[1]**2)
    return res

def f2(x):
    res = (x[0]**2)
    return res
def f3(x):
    res = (x[0]**2)-x[1]

def MatCanonicos(x):
    m = []
    for i in range(len(x)):
        vc = []
        for j in range(len(x)):
            if j == i:
                vc.append(1)
            else:
                vc.append(0)
        m.append(vc)

    m = np.array(m)
    return m




def MCC(f,x,Eps,maxit):
    #maxit empieza desde n y va disminuyendo
    dicInfo = {
        1: "Proceso terminado satisfactoriamente",
        0: "LIMITE DE ITERACIONES EXCEDIDO",
        -1: "optimo no acotado detectado"
    }
    print "Iteraciones restantes: ",maxit
    if maxit == 0:
        print dicInfo[0]
        return [x,f(x)]

    if len(x) == 0:
        return "ERROR: x debe tener al menor una componente"

    d = MatCanonicos(x)
    y_i = x
    cont = 0
    y_i1 = y_i

    Y = [y_i]

    while cont < len(d):
        print "----------------"
        print "vector canonico: ",d[cont]
        res = minF_enR(f,y_i1,d[cont],0,1,0.1)

        if res == 'inf':
            #En el caso que se desborde en la recta
            print dicInfo[-1]
            return [Y[-1],res[1]]

        else:
            #AQUI ESTA EL ERROR
            tmin = res[0]
            print "tmin = ",tmin
            print "y_i: ",y_i
            ancientY = y_i
            y_i = y_i + tmin*d[cont]
            print "y_i+1: ",y_i

            Y.append(y_i)
            print "Y: ",Y
            cont = cont + 1

    if abs(f(y_i) - f(Y[-2])) <= Eps:
        print "Diferencia final MINIMA"
        print dicInfo[1]
        return [Y[-1],f(Y[-1])]
    else:
        cont = 0
        a = Y[-1]
        print "Repitiendo el metodo..."
        MCC(f,a,Eps,maxit-1)


def func(n):
    a = n
    if a == 0:
        return 10
    else:
        for i in range(a):
            a = a+1
            print "a: ",a
            if a == 3:
                func(0)
            
        return a
            
print func(2)
#x = np.array([1,1])
#print MCC(f1,x,0.001,5)
