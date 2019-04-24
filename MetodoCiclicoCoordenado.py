#-*- coding: utf-8 -*-
import numpy as np

#Ejemplos de funciones
def f1(x):
    res = (x[0]**2) + (x[1]**2)
    return res


def MinimmoEnIntervalo(f,x,d,h,a,b):
    eps = 0.00001
    # f: funcion con la cual se busca el minimo
    # x: punto fijo
    # d: dirección
    # h: paso de los valores de t
    # a: limite inferior del intervalo de t
    # b: limite suberior del intervalo de t
    t = [i for i in np.arange(a,b+h,h)]
    tmin = a
    #print t
    for i in range(len(t)):
        #print "t[i]: ",t[i]
        #print "tmin: ",tmin
        #print "fmin: ", f(x + tmin*d)
        #print "------------------------"
        if f(x + t[i]*d) < f(x + tmin*d):
            tmin = t[i]

    return tmin, f(x + tmin*d)

def MinimoEnRecta(f,x,d,h,a,b,it):
    # f: funcion con la cual se busca el minimo
    # x: punto fijo
    # d: dirección
    # h: paso de los valores de t
    # a: limite inferior del intervalo de t
    # b: limite suberior del intervalo de t
    # it: numero de la iteracion: comienza en 0
    maxit = 100
    if it == maxit:
        print "MAXIMO NUMERO DE ITERACIONES ALCANZADO"
        tmin = "NA"
        fmin = "-inf"
        return tmin, fmin
    else:
        tmin, fmin = MinimmoEnIntervalo(f,x,d,h,a,b)
        if tmin == a:
            print "tmin en el limite izquierdo a = " , a
            temp = a
            a = a -2
            b = temp
            print "nuevo intervalo: ",[a,b]
            MinimoEnRecta(f,x,d,h,a,b,it+1)
        elif tmin == b:
            print "tmin en el limite derecho b = " , b
            temp = b
            b = b+2
            a = temp
            print "nuevo intervalo: ",[a,b]
            MinimoEnRecta(f,x,d,h,a,b,it+1)

        else:
            print "MINIMO DENTRO DEL INTERVALO ENCONTRADO"
            return tmin, fmin

#-------------------------------------
#Prueba 1 de MinimmoEnIntervalo()
"""
x0 = np.array([0,0])
d = np.array([1,0])
h = 0.1
a = 0
b = 1

tmin,fmin = MinimmoEnIntervalo(f1,x0,d,h,a,b)
print "tmin: ",tmin
print "fmin: ",fmin
print tmin == a
"""
# FUNCIONA
#-------------------------------------

#-------------------------------------
#Prueba 2 de MinimoEnRecta
x0 = np.array([0,0])
d = np.array([1,0])
h = 0.1
a = 0
b = 1

tmin,fmin = MinimoEnRecta(f1,x0,d,h,a,b,0)
print "tmin: ",tmin
print "fmin: ",fmin
#-------------------------------------
