function [K,M]=ex_beam_element(beam_param)

rho=beam_param.rho; E=beam_param.E; b=beam_param.b; h=beam_param.h; L=beam_param.L;

K = E*(b*h^3/12)/(L^3)*2*[
  6,    3*L,    -6,    3*L;
  3*L,  2*L^2,  -3*L,  L^2; 
  -6,   -3*L,   6,     -3*L;
  3*L,  L^2,    -3*L,  2*L^2];                   
                           
M = rho*b*h*L/420*[
    156,    22*L,   	54,     -13*L;
    22*L,   4*L^2,  	13*L,   -3*L^2;
    54,     13*L,   	156,    -22*L;
    -13*L,  -3*L^2, 	-22*L,  4*L^2];

end
