#-*- coding: utf-8 -*-
import numpy as np
from taller1_Optim import min1abFB

h = 0.1
LIM_INF = -100
LIM_SUP = 1000
Eps_Interval = 2*h

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
    ext = 50*h
    while a > LIM_INF and b < LIM_SUP:
        print "input a: ",a
        print "input b: ",b
        print "input x: ",x
        print "input d: ",d
        res = min1abFB(f,x,d,a,b,h)
        print "tmin: ",res[0]
        print "|tmin - a| = ",abs(res[0] - a)
        print "|b - tmin| = ",abs(b - res[0])
        print "Eps_Interval: ",Eps_Interval
        print "res: [tmin,fmin] =  ",res
        #print "Eps = ",Eps
        #Caso en el que tmin dentro del intervalo
        if abs(res[0] -a) > Eps_Interval and abs(b-res[0]) > Eps_Interval:
            #print "diferencia tmin y a: ",abs(res[0] -a)
            #print "diferencia tmin y b: ",abs(b -res[0])
            print "minimo local encontrado"
            print "[tmin , fmin]: ",res
            return res
        #Caso en el que tmin esté muy cerca de a
        elif abs(res[0] - a) < Eps_Interval:
            print "DEMASIADO CERCA DE a:"
            #print "tmin = ",res[0]
            print "ultimo fmin: ",res[1]
            print "antiguo a: ",a
            tempA = a
            b = tempA
            a = a-ext
            print "Extendiendo intervalo hacia la izquierda..."
            print "nuevo a: ",a
            print "-------------------------"
        elif abs(b-res[0]) < Eps_Interval+h:
            print "DEMASIADO CERCA DE b:"
            #print "tmin = ",res[0]
            print "ultimo fmin: ",res[1]
            print "antiguo b: ",b
            tempB = b
            a = tempB
            b = b+ext
            print "Extendiendo intervalo hacia la derecha..."
            print "nuevo b: ",b
            print "-------------------------"

    print "LIMITE IZQUIERDO O DERECHO ALCANZADO"
    return 'inf'

#test
x = np.array([1,1])
d = np.array([1,0])
a = 1
b = 2

#print minF_enR(f1,x,d,a,b,h)
#print min1abFB(f2,x,d,a,b,h)
#print abs(-0.0000000000000008 - 1.0999999999999992)
#16 decimales
