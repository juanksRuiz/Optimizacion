#-*- coding: utf-8 -*-
import numpy as np

#Ejemplos de funciones
def f1(x):
    #Paraboloide centrado en 0
    res = ((x[0])**2)  ((x[1])**2)
    return res

def f2(x):
    a = (x[0] + x[1]-2)**2
    b = (5*x[0]**2-1)**3
    y = a + b
    return y

def MinimmoEnIntervalo(f,x,d,h,a,b):
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
        #print ("t[i]: ",t[i])
        #print ("tmin: ",tmin)
        #print ("fmin: ", f(x + tmin*d))
        #print("------------------------") 
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

    # Esta función funciona por recursion 

    tmin, fmin = MinimmoEnIntervalo(f,x,d,h,a,b)
    # Numero maximo de iteraciones:
    maxit = 100
    print("--------------------")
    print ("it: ",it)
    print("tmin: ",tmin)
    print("Intervalo actual: ",[a,b])
    #Error al aproximarse a los limites del intervalo:
    eps = h
    if it == maxit:
        print("MAXIMO NUMERO DE ITERACIONES ALCANZADO")
        tmin = "NA"
        fmin = "-inf"
        return tmin, fmin
    else:
        print("abs(tmin-a): ", abs(tmin-a))
        print("abs(tmin-b): ", abs(tmin-b))
        print("abs(tmin-a) <= eps ?", abs(tmin-a) <= eps)
        print("abs(tmin-b) <= eps ?", abs(tmin-b) <= eps)
        if abs(tmin-a) <= eps or ((tmin < a)):
            print("tmin EN EL LIIMITE IXQUIERDO a = " , a)
            temp = a
            a = a -2
            b = temp
            print("nuevo intervalo: ",[a,b])
            return MinimoEnRecta(f,x,d,h,a,b,it+1)
        elif abs(tmin-b) <= eps or (tmin > b):
            print("tmin EN EL LIMITE DERECHO b = " , b)
            temp = b
            b = b+2
            a = temp
            print("nuevo intervalo: ",[a,b])
            return MinimoEnRecta(f,x,d,h,a,b,it+1)
        else:
            print("MINIMO DENTRO DEL INTERVALO ENCONTRADO")
            tmin, fmin = MinimmoEnIntervalo(f,x,d,h,a,b)
            return (tmin, fmin)

#-------------------------------------
#Prueba 1 de MinimmoEnIntervalo()
"""
x0 = np.array([0,0])
d = np.array([0,1])
h = 0.1
a = 0
b = 3

tmin,fmin = MinimmoEnIntervalo(f2,x0,d,h,a,b)
print ("tmin: ",tmin)
print ("fmin: ",fmin)
#print (tmin == a)
"""
# FUNCIONA
#-------------------------------------

#-------------------------------------
#Prueba 2 de MinimoEnRecta

x0 = np.array([0,0])
d = np.array([1,0])
h = 0.1
a = -1
b = 3

tmin,fmin = MinimoEnRecta(f1,x0,d,h,a,b,0)

print("tmin: ",tmin)
print("fmin: ",fmin)

# NO FUNCIONA
#-------------------------------------