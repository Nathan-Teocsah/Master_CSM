import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("Cobb.txt",skiprows=1)
y=np.log(data[:,1])
X=np.log(data[:,[2,3]])
nomvar=np.loadtxt("Cobb.txt",dtype='str')[0,:][2:]

# Utilisation de scikitlearn

from sklearn.linear_model import LinearRegression
mod = LinearRegression()
mod.fit(X=X,y=y)
coef=np.around(np.append(mod.intercept_,mod.coef_),3)
print("Coefficients avec scikitlearn:")
print(*['cste',*nomvar],sep='   ')
print(*coef)
plt.close()
plt.plot(y,mod.predict(X),'r+')
plt.xlabel('Réponse')
plt.ylabel("Prédiction")
plt.plot(y,y,color='black')
plt.show()

#Calcul manuel avec la formule  classique

X1=np.append(np.ones((len(y),1)),X,1)
Xt=X1.T
Ri=np.linalg.inv(???)
bet=Ri.dot((Xt).dot(???))
yhat=???
print("Coefficients manuels:",end="  ")
print(*np.around(bet,3))

plt.close()
plt.plot(y,yhat,'r+')
plt.xlabel('Reponse')
plt.ylabel("Prediction")
plt.plot(y,y,color='black')
plt.title('Droite de regression')
plt.show()
