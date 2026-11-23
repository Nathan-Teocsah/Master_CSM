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

dt = 0.1Ma;
dz = 100;

function f(z,t)
    global k, Ts,Tm;
    return Tm + (Ts-Tm).*erfc(z./(2*sqrt(k.*t)));
end


t = collect(tmin:dt:tmax);
z = collect(zmin:dz:zmax);
T = f.(z',t)

heatmap(t./Ma,z./100,T',
    xlabel = "Time (Ma)",
    ylabel = "Depth (km)",
    title = "Thermal diffusion",
    colorbar_title = "Temperature (°C)",
    yflip=true)
