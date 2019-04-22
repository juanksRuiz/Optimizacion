from decimal import *
import numpy as np

getcontext().prec = 50

#x es una lista de Decimals
def f(x):
    # funcion que representa f(x1,x2) = ((x1  - 1)**4) + (x1 + 2x2 - 3)**2
    # x esta en R2
    return ((x[0][0] - 1)**4) + ((x[0][0] + 2*x[1][0] - 3)**2)

def gr(x):
    g1 = 4*(x[0][0]-1)**3 + 2*(x[0][0] + 2*x[1][0]-3)
    g2 = 4*(x[0][0] + 2*x[1][0] - 3)
    return np.array([[g1],[g2]])

def Hess(x):
    h1 = 12*(x[0][0]-1)**2 + 2
    h2 = 4
    h3 = 4
    h4 = 8
    return np.array([[h1,h2],[h3,h4]])

def solve(x):
    d1 = (32*(2*x[1][0] - 2))/(96*(x[0][0]-1)**2)
    d2 = (16*(x[0][0]- 1)**3 - 16*(x[0][0] + 2*x[1][0] -3) - (48*(x[0][0] - 1)**2)*(x[0][0] + 2*x[1][0] -3))/(96*(x[0][0] - 1)**2)
    solv = np.array([[d1],[d2]])
    return solv

#x = np.array([[Decimal(2)],[Decimal(2)]],dtype=np.dtype(Decimal))
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
for i in range(82):
    print("it = ",i)
    sol = solve(x)
    k = x + sol
    print ("Nuevo x: ",k)
    x = k
    print ("------------------------------------------")
