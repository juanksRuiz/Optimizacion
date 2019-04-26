import math
from decimal import *
import numpy as np

getcontext().prec = 100

#def f(x):
#    y = (Decimal(x[0][0])**2)+(Decimal(x[1][0])**2)
#    return y

def f(x):
    y = (x[0][0]-1)**4 + (x[0][0]+2*x[1][0]-3)**2
    return y

def gr(x):
    d1 = (4*(x[0][0]-1)**3)+(2*(x[0][0]+2*x[1][0]-3))
    d2 = (4*(x[0][0] + 2 * x[1][0] - 3))
    gra = np.array([[d1],[d2]])
    return gra


def inv(x):
    d1 = (8 * 1/(96*(x[0][0] - 1)**2))
    d2 = (-4 * 1/(96*(x[0][0] - 1)**2))
    d3 = (-4 * 1/(96*(x[0][0] - 1)**2))
    d4 = (12*(x[0][0] - 1)**2 + 2)/(96*(x[0][0]-1)**2)
    invesi = np.array([[d1,d2],[d3,d4]])
    return invesi
def solve(x):
    d1 = (32*(2*x[1][0] - 2))/(96*(x[0][0]-1)**2)
    d2 = (16*(x[0][0]- 1)**3 - 16*(x[0][0] + 2*x[1][0] -3) - (48*(x[0][0] - 1)**2)*(x[0][0] + 2*x[1][0] -3))/(96*(x[0][0] - 1)**2)
    solv = np.array([[d1],[d2]])
    return solv

x = np.array([[Decimal(2)],[Decimal(2)]],dtype=np.dtype(Decimal))
"""
g = gr(x)
e = esi(x)
inversa = inv(x)
sol = solve(x)
print ("g: ",g)
print ("e: " , e)
print ("sol: " , sol)

k = x + sol

print ("k: ",k)

print ("Nuevo x: ",solve(k))
"""

#Por algun motivo con n = 83 iteraciones en un momento deja de converger a (1,1)
for i in range(82):
    print("it = ",i)
    sol = solve(x)
    k = x + sol
    print ("Nuevo x: ",k)
    x = k
    print ("------------------------------------------")
