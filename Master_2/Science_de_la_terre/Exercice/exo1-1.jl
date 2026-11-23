using Plots
using SpecialFunctions

Ma = 1e6*365.25*24*3600;
#Physical parameter
zmin = 0.0; #[km]
zmax = 150e3; #[km]
tmin = 0.0; #[Ma]
tmax = 40Ma; #[Ma]
k = 1e-6; #[m-2s-1]
Ts = 20; #T surface
Tm = 1350;

dt = 0.1;
dz = 100;

function f(z,t)
    global k, Ts,Tm;
    return Tm + (Ts-Tm)*erfc(z/(2*sqrt(k*t)));
end


f_list = Float64[]
z = Float64[]

t = 5Ma;
for i in 0:round((zmax-zmin)/dz)
    push!(z,zmin + i*dz);
    println(zmin + i*dz," ", f(z[end],t))
    push!(f_list,f(z[end],t));
end

plot(z ./ 1000, f_list,
    xlabel = "Depth (millier de km)",
    ylabel = "Temperature (°C)",
    label = "t = 50 Ma")
