kappa = 1e-6;
w = 50; # largeur du "dyke"

tmin = 0
tmax = 2*365.25*24*3600 # 7 jours

xmin = -50
xmax = 50

Tmagma = 1200
Trock = 300


dt = 7*24*3600
dx = 0.1
CFL = kappa*dt/(dx^2)

t = collect(tmin:dt:tmax)
x = collect(xmin:dx:xmax)

T0 = zeros(length(x))

xdebut = (xmax-xmin-w)/2 + xmin
xfin = xdebut + w

n_min = round(Int, (xdebut-xmin)/dx)
n_max = round(Int, (xfin-xmin)/dx)

T0[n_min:n_max] .= Tmagma
T0[1:n_min-1] .= Trock
T0[n_max+1:end] .= Trock

I = collect(2:1:length(x))
J = collect(1:1:length(x)-1)
SD = zeros(length(x)-1)
SD.=-CFL
SD0 = copy(SD)

SD0[1] = 0
SD[end] = 0

append!(I,collect(1:1:length(x)))
append!(J,collect(1:1:length(x)))
D = ones(length(x))
D[2:end-1].=1+2*CFL
append!(SD,D)

append!(I,collect(1:1:length(x)-1))
append!(J,collect(2:1:length(x)))
append!(SD,SD0)

using SparseArrays

S = sparse(I,J,SD)
T = zeros(length(t),length(x))
T[1,1:end] = T0 
for i in 2:length(t)
    T[i,1:end] = S\T[i-1,1:end]
end

using Plots


heatmap(
    x ,
    t ./ (24*3600),
    T,
    xlabel = "Distance (m)",
    ylabel = "Time (days)",
    title = "Heat diffusion",
    colorbar_title = "Temperature"
)




temps = 50 # jours
i_jour = round(Int, 24*3600*temps/dt)+1
plot(
    x,
    T[i_jour,1:end],
    xlabel = "Distance (m)",
    ylabel = "Température",
    title = "Heat dffusion"
)
