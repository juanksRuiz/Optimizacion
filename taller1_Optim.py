#-*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt

#ejemplo funcion con dominio en R2

def f1(x):
    res = x[0]*x[0] + x[1]*x[1]
    return res

def f2(x):
    res = (x[0]**2)
    return res
def min1abFB(f,x,d,a,b,h):
    #codigo inicial:
    # f: funcion que se minimiza: va de Rn----->R
    # x: punto fijo
    # d: valor fijo
    # a,b: limites del intervalo
    # h: heap

    #t varia entre a y b
    #x y d están en Rn

    t = [i for i in np.arange(a,b,h)]
    #print "t: ",t
    valoresF = []
    minimo = f(x+a*d)
    tmin = a
    for i in range(len(t)):
        newValue = f(x + t[i]*d)
        if newValue < minimo:
            minimo = newValue
            #print "NUEVO MINIMO: ",minimo
            tmin = t[i]
    #minimo: en  f(t)

    # [tmin,f(tmin)]
    return [tmin,minimo]
#EJEMPLO
"""
x = np.array([0,0])
d = np.array([1,1]) #la dirección
a = -1
b = 1
h = 0.1
print minF(f2,x,d,a,b,h)
"""

#PRUEBAS----------------------------
#m1 = np.array([[1,2,3],[5,9,0]])
#m2 = np.array([[1,1,1],[1,1,1]])
#print m1 + m2
#print m1
#IMPRIMIENDO Y OPERANDO CON COLUMNAS
#col_c1 = m1[:,0]

#a = np.array([[1,2,3],[4,5,6],[10,11,12]])
#print "a:"
#print a
#print (a[0]*0.5)
#rint multiplicar(0.5,[1,2])
#-----------------------------------
