#-*- coding: utf-8 -*-
import numpy as np
from taller1_Optim import min1abFB

LIM_INF = -1000
LIM_SUP = 1000
Eps_Interval =10**(-7)

#ejemplo funcion con dominio en R2

def f1(x):
    res = (x[0]**2) + (x[1]**2)
    return res

def f2(x):
    res = (x[0]**2)
    return res
def f3(x):
    res = (x[0]**2)-x[1]

def minF_enR(f,x,d,a,b,h):
    ext = 100*h
    while a > LIM_INF and b < LIM_SUP:
        res = min1abFB(f,x,d,a,b,h)
        #print "Eps = ",Eps
        #Caso en el que tmin dentro del intervalo
        if abs(res[0] -a) > Eps_Interval+h and abs(b-res[0]) > Eps_Interval+h:
            #print "diferencia tmin y a: ",abs(res[0] -a)
            #print "diferencia tmin y b: ",abs(b -res[0])
            #print "minimo local encontrado"
            #print "[tmin , fmin]: "
            return res
        #Caso en el que tmin esté muy cerca de a
        elif abs(res[0] - a) < Eps_Interval + h:
            #print "DEMASIADO CERCA DE a:"
            #print "antiguo a: ",a
            a = a-ext
            b = res[0]
            #print "Extendiendo intervalo hacia la izquierda..."
            #print "nuevo a: ",a
            #print "-------------------------"
        elif abs(b-res[0]) < Eps_Interval + h:
            #print "DEMASIADO CERCA DE b:"
            #print "antiguo b: ",b
            b = b+ext
            a = res[0]
            #print "Extendiendo intervalo hacia la derecha..."
            #print "nuevo b: ",b
            #print "-------------------------"

    return "LIMITE IZQUIERDO O DERECHO ALCANZADO"
"""
#test
x = np.array([-2,2])
d = np.array([1,0])
a = -20
b = 20
h = 0.1
print minF_enR(f1,x,d,a,b,h)
#print min1abFB(f2,x,d,a,b,h)
#print abs(-0.0000000000000008 - 1.0999999999999992)
#16 decimales
"""