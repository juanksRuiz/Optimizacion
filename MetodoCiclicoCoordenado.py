#-*- coding: utf-8 -*-
import numpy as np
from math import e as exp
#Ejemplos de funciones
def f1(x):
    #Paraboloide centrado en 0
    res = ((x[0])**2) +((x[1])**2)
    return res

def f2(x):
    y = exp**(x[0]**2) + 2*x[1]**2
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

def MinimoEnRecta(f,x,d,h,a,b,it,intervalos):
    # f: funcion con la cual se busca el minimo
    # x: punto fijo
    # d: dirección
    # h: paso de los valores de t
    # a: limite inferior del intervalo de t
    # b: limite suberior del intervalo de t
    # it: numero de la iteracion: comienza en 0
    # intervalos: diccionario de  en el cual la llave es el intervalo
    #             y el valor es el tmin en ese intervalo
    #             para que en el caso que la busqueda comience en el minimo
    #             no se quede en un bucle infinito
    # Esta función funciona por recursion

    tmin, fmin = MinimmoEnIntervalo(f,x,d,h,a,b)
    # Numero maximo de iteraciones:
    maxit = 100

    #print("--------------------")
    #print ("it: ",it)
    #print("tmin: ",tmin)
    #print("Intervalo actual: ",[a,b])
    #Error al aproximarse a los limites del intervalo:
    eps = h
    if it == maxit:
        print("MAXIMO NUMERO DE ITERACIONES ALCANZADO")
        tmin = "NA"
        fmin = "-inf"
        return tmin, fmin
    else:
        #print("abs(tmin-a): ", abs(tmin-a))
        #print("abs(tmin-b): ", abs(tmin-b))
        #print("abs(tmin-a) <= eps ?", abs(tmin-a) <= eps)
        #print("abs(tmin-b) <= eps ?", abs(tmin-b) <= eps)
        if abs(tmin-a) <= eps or ((tmin < a)):
            #print("tmin EN EL LIIMITE IXQUIERDO a = " , a)
            temp = a
            a = a -2
            b = temp
            #print(intervalos)
            if ((a,b) in intervalos.keys()):
                #print("INTERVALO  YA EVALUADO: ",(a,b))
                #print("punto minimizador: ",(x+tmin*d,fmin))
                return intervalos[(a,b)][0] , intervalos[(a,b)][1]
            else:
                #print("nuevo intervalo: ",[a,b])
                intervalos[(a,b)] = (tmin,fmin)
                return MinimoEnRecta(f,x,d,h,a,b,it+1,intervalos)

        elif abs(tmin-b) <= eps or (tmin > b):
            #print("tmin EN EL LIMITE DERECHO b = " , b)
            temp = b
            b = b+2
            a = temp
            #print(intervalos)
            if ((a,b) in intervalos.keys()):
                #print("INTERVALO [a,b] YA EVALUADO: ",(a,b))
                #print("punto minimizador: ",(x+tmin*d,fmin))
                return intervalos[(a,b)][0] , intervalos[(a,b)][1]
            else:
                #print("nuevo intervalo: ",[a,b])
                intervalos[(a,b)] = (tmin,fmin)
                return MinimoEnRecta(f,x,d,h,a,b,it+1,intervalos)

        else:
            #print("MINIMO DENTRO DEL INTERVALO ENCONTRADO")
            tmin, fmin = MinimmoEnIntervalo(f,x,d,h,a,b)
            #print("punto minimizador: ",(x+tmin*d,fmin))
            return tmin, fmin

def MatCanonicos(x):
    # Funcion que retorna un arreglo bidimensional nxn donde cada sub arreglo
    # es un vector canonico y n es la longitud del vector x
    #
    # x: arreglo numpy con n elementos
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


def MetodoCiclicoCoordenado(f,x):
    # f: funcion con la cual se busca el minimo
    # x: punto fijo

    # Valores por defecto para la funcion MinimoEnIntervalo
    h = 0.1
    a = 0
    b = 1
    #punto = x
    m = MatCanonicos(x)


    for can in m:
        tmin, fmin = MinimmoEnIntervalo(f1,x,can,h,a,b)
        intervalos = {(a,b):(tmin,fmin)}
        #print("direccion: ",can)
        tmin, fmin = MinimoEnRecta(f,x,can,h,a,b,0,intervalos)
        if fmin == "-inf":
            print("FUNCION NO ACOTADA")
            xf = "x optimo NO ENCONTRADO"
            return tmin,xf, fmin
        else:
            x = x + tmin*can
            #print("CAMBIANDO CANONICO xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    return tmin,x,fmin

#-------------------------------------
#Prueba 1 de MinimmoEnIntervalo()
"""
x0 = np.array([0,0])
d = np.array([0,1])
h = 0.1
a = 0
b = 1000

tmin,fmin = MinimmoEnIntervalo(f2,x0,d,h,a,b)
print ("tmin: ",tmin)
print ("fmin: ",fmin)
#print (tmin == a)
"""
# FUNCIONA
#-------------------------------------

#-------------------------------------
#Prueba 2 de MinimoEnRecta
"""
x0 = np.array([0,0])
d = np.array([0,1])
h = 0.1
a = 0
b = 1
tmin, fmin = MinimmoEnIntervalo(f2,x0,d,h,a,b)
intervalos = {(a,b):(tmin,fmin)}
tmin,fmin = MinimoEnRecta(f2,x0,d,h,a,b,0,intervalos)

print("tmin: ",tmin)
print("fmin: ",fmin)
"""
# FUNCIONA
#-------------------------------------

#-------------------------------------
# Pruebas 3 - Metodo cíclico coordenado

x = np.array([3.8,-1])
tmin,xf, fmin = MetodoCiclicoCoordenado(f2,x)
print("tmin: ",tmin)
print("xf: ",xf)
print("fmin: ",fmin)

