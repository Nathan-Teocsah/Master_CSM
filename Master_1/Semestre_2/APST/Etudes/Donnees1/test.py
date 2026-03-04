import math

def plus_grand_facteur_premier(n):
    if n <= 1:
        return None  # pas de facteur premier

    plus_grand = None

    # Enlever les facteurs 2
    while n % 2 == 0:
        plus_grand = 2
        n //= 2

    # Tester les diviseurs impairs
    i = 3
    while i * i <= n:
        while n % i == 0:
            plus_grand = i
            n //= i
        i += 2

    # S'il reste un nombre > 1, c'est un facteur premier
    if n > 1:
        plus_grand = n

    return plus_grand

err = 1
for a1 in range(190,2001):
    a = a1
    p = plus_grand_facteur_premier(a)
    if (a//p > p) and (math.sqrt(a) != int(math.sqrt(a))):
        print("n = ",a1)
        if (a//p-p>=0) :
            print("   ",a, "=",a//p,"*",p,"    ","distance = ",a//p-p,"   positif")
            err = 1
        else:
            print("   ",a, "=",a//p,"*",p,"    ","distance = ",a//p-p,"   négatif")
        while math.sqrt(a) != int(math.sqrt(a)):
            a = plus_grand_facteur_premier(a) + a
            p = plus_grand_facteur_premier(a)
            if (a//p-p>=0) :
                print("   ",a, "=",a//p,"*",p,"    ","distance = ",a//p-p,"   positif")
            else :
                print("   ",a, "=",a//p,"*",p,"    ","distance = ",a//p-p,"   négatif")
                err = 0
        print("   ","sqrt(",a,")=",math.sqrt(a))
        if (err==1):
            print("ERREUR !!")
            break