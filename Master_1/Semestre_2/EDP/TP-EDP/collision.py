import numpy as rd

def bernoulli(p):
  u=rd.random.uniform()
  if p>u:
    return 1
  else : 
    return 0

def collision(v,eta,tau,dt):
    if (dt> 0.1*tau*eta) :
        print("erreur dans le choix du pas en espace")
    p = dt/(eta*tau)
    if bernoulli(p):
       return rd.random.uniform(-1,1)
    else :
       return v

def particule(tn,xn,vn,dt,eta,tau):
   tnp1 = tn + dt
   xnp1 = xn + vn*dt/eta
   if xnp1 < 0 : # condition de bord sur [0,1]
      xnp1 = 1+xnp1
   elif xnp1 > 1 :
      xnp1 = xnp1-1
   vnp1 = collision(vn,eta,tau,dt)
   return [tnp1,xnp1,vnp1]
   

eta = 0.1
tau = 0.5
dt = 0.02*tau*eta
v = 0.5
for i in range(1,51):
    v = collision(v,eta,tau,dt)
    print(v)

       


