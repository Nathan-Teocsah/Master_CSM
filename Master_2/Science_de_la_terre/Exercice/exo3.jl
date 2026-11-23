kappa = 1e-6

tmin = 0
tmax = 1*365.25*24*3600

xmin = 0
xmax = 150e3

dt = 1e6
dx = 1e3

t = collect(tmin:dt:tmax)
x = collect(xmin:dx:xmax)

T = zeros(length(t), length(x))

n_min = round(Int, length(x)/3)
n_max = 2*n_min

T[1,n_min:n_max] .= 1.0

function New_f(fm1, f, fp1)
    global kappa, dt, dx
    return f + kappa*dt*(fp1 - 2*f + fm1)/(dx^2)
end

n = length(x)

for i in 2:length(t)
    T[i,2:n-1] .= New_f.(
        T[i-1,1:n-2],
        T[i-1,2:n-1],
        T[i-1,3:n]
    )
end

using Plots

heatmap(
    x ./ 1000,
    t ./ (24*3600),
    T,
    xlabel = "Distance (km)",
    ylabel = "Time (days)",
    title = "Heat diffusion",
    colorbar_title = "Temperature"
)