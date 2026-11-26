kappa_magma = 1e-6;
kappa_rock = 2*kappa_magma;
w = 50; # largeur du "dyke"

tmin = 0
tmax = 60*365.25*24*3600 # 7 jours

xmin = -50
xmax = 50

Tmagma = 1200
Trock = 300


dt = 7*24*3600
dx = 0.1
CFL = kappa*dt/(dx^2)

t = collect(tmin:dt:tmax)
x = collect(xmin:dx:xmax)

kappa = zeros(length(x)-1)
rho = ones(length(x))
Cp = ones(length(x))

T0 = zeros(length(x))

xdebut = (xmax-xmin-w)/2 + xmin
xfin = xdebut + w

n_min = round(Int, (xdebut-xmin)/dx)
n_max = round(Int, (xfin-xmin)/dx)

T0[n_min:n_max] .= Tmagma
T0[1:n_min-1] .= Trock
T0[n_max+1:end] .= Trock

kappa[n_min:n_max] .= kappa_magma
kappa[1:n_min-1] .= kappa_rock
kappa[n_max+1:end] .= kappa_rock

#Sous-diagonale
I = collect(2:1:length(x))
J = collect(1:1:length(x)-1)
SousD = zeros(length(x)-1)
SousD[1:end-1] = -kappa[1:end-1].*dt./(rho[2:length(x)-1].*Cp[2:length(x)-1].*dx^2)
M = SousD

#diagonale
append!(I,collect(1:1:length(x)))
append!(J,collect(1:1:length(x)))
D = ones(length(x))
D[2:end-1] = ones(length(x)-2)+dt.*(kappa[2:end].+kappa[1:end-1])./(rho[2:end-1].*Cp[2:end-1].*dx^2)
append!(M,D)

#Sur diagonale
append!(I,collect(1:1:length(x)-1))
append!(J,collect(2:1:length(x)))
SurD = zeros(length(x)-1)
SurD[2:end] = -dt*kappa[2:end]./(rho[2:end-1].*Cp[2:end-1].*dx^2)
append!(M,SurD)

using SparseArrays

S = sparse(I,J,M)
T = zeros(length(t),length(x))
T[1,1:end] = T0 
for i in 2:length(t)
    T[i,1:end] = S\T[i-1,1:end]
end

using Plots


print("Succès !")
heatmap(
    x ,
    t ./ (24*3600),
    T,
    xlabel = "Distance (m)",
    ylabel = "Time (days)",
    title = "Heat diffusion",
    colorbar_title = "Temperature"
)



#=
temps = 10 # jours
i_jour = round(Int, 24*3600*temps/dt)+1
plot(
    x,
    T[i_jour,1:end],
    xlabel = "Distance (m)",
    ylabel = "Température",
    title = "Heat dffusion"
)
=#
