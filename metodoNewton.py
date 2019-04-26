from decimal import *
import numpy as np
import sympy as sp
from sympy import *

getcontext().prec = 50

#x es una lista de Decimals
def f(x):
    # funcion que representa f(x1,x2) = ((x1  - 1)**4) + (x1 + 2x2 - 3)**2
    # x esta en R2
    return ((x[0][0] - 1)**4) + ((x[0][0] + 2*x[1][0] - 3)**2)


def gr(x):
    print ("x de entrada: ",x)
    g1 = 4*(x[0]-1)**3 + 2*(x[0] + 2*x[1]-3)
    g2 = 4*(x[0] + 2*x[1] - 3)
    return Matrix([[g1],[g2]])

def Hess(x):
    h1 = 12*(x[0]-1)**2 + 2
    h2 = 4
    h3 = 4
    h4 = 8
    return np.array([[h1,h2],[h3,h4]])

def solve(x):
    d1 = (32*(2*x[1][0] - 2))/(96*(x[0][0]-1)**2)
    d2 = (16*(x[0][0]- 1)**3 - 16*(x[0][0] + 2*x[1][0] -3) - (48*(x[0][0] - 1)**2)*(x[0][0] + 2*x[1][0] -3))/(96*(x[0][0] - 1)**2)
    solv = np.array([[d1],[d2]])
    return solv

def inversa(x):
    # Calcula la inversa de la Hessiana del problema y retorna un objeto Matrix
    B = (12*(x[0]-1)**2)+2
    d1_1 = 1/B
    d1_2 = 0
    d2_1 = -4/(8*B-16)
    d2_2 = B/(8*B-16)
    return Matrix([[d1_1,d1_2],[d2_1,d2_2]])


def solveFinal(x):
    g = gr(x)
    #print ("g: ",g)
    #print ("------------")
    inv = inversa(x)
    #print ("inv: ",inv)
    #print ("------------")
    d = -inv*g
    #print ("d: ",d)
    return d

x = np.array([[Decimal(2)],[Decimal(2)]],dtype=np.dtype(Decimal))
x = Matrix(x,dtype=np.dtype(Decimal))
"""
g = gr(x)
e = Hess(x)
inv = inversa(x)
sol = solveFinal(x)


print ("g: ",g)
print ("sol: " , sol)

k = x + sol
print '\n'
print ("k: ",k)

print ("Nuevo x: ",solveFinal(k))

"""
for i in range(81):
    print("it = ",i)
    sol = solveFinal(x)
    k = x + sol
    print ("Nuevo x: ",k)
    x = k
    print ("------------------------------------------")
"""
"""
