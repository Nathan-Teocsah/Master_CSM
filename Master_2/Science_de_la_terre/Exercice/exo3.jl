kappa = 1e-6;
w = 50; # largeur du "dyke"

tmin = 0
tmax = 50*365.25*24*3600 # 7 jours

xmin = -50
xmax = 50

Tmagma = 1200
Trock = 300

CFL = 0.4
dt = 7*24*3600
dx = sqrt(kappa*dt/CFL)

t = collect(tmin:dt:tmax)
x = collect(xmin:dx:xmax)
print(length(t))

T = zeros(length(t), length(x))

xdebut = (xmax-xmin-w)/2 + xmin
xfin = xdebut + w

n_min = round(Int, (xdebut-xmin)/dx)
n_max = round(Int, (xfin-xmin)/dx)

T[1,n_min:n_max] .= Tmagma
T[1,1:n_min-1] .= Trock
T[1,n_max+1:end] .= Trock

function New_f(fm1, f, fp1)
    global kappa, dt, dx
    return f + kappa*dt*(fp1 - 2*f + fm1)/(dx^2)
end

n = length(x)

for i in 2:length(t)
    T[i,1] = T[i-1,1]
    T[i,end] = T[i-1,end]
    T[i,2:n-1] .= New_f.(
        T[i-1,1:n-2],
        T[i-1,2:n-1],
        T[i-1,3:n]
    )
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

#=
temps = 50*365 # jours
i_jour = round(Int, 24*3600*temps/dt)+1
plot(
    x,
    T[i_jour,1:end],
    xlabel = "Distance (m)",
    ylabel = "Température",
    title = "Heat dffusion"
)
=#
