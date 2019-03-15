from taller1_Optim import min1abFB
from taller2_Optim import minF_enR
import numpy as np

LIM_INF = -1000
LIM_SUP = 1000
Eps_Interval =10**(-7) #Error de los intervalos
E = 10**(-5) #Error entre dos minimos


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


        
def MCC(f,x,Eps):
    textNoMin = "LIMITE IZQUIERDO O DERECHO ALCANZADO"
    dicInfo = {
        1: "Proceso terminado satisfactoriamente",
        0: "LIMITE DE ITERACIONES EXCEDIDO",
        -1: "optimo no acotado detectado"
    }
    if len(x) == 0:
        return "ERROR: x debe tener al menor una componente"
    d = MatCanonicos(x)
    for i in range(len(d)):
        #Se mira todos los minimos desde un punto ? o como funciona?
        res = minF_enR(f,x,d[i])
