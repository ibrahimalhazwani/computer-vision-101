function [r, c] = houghpixels_me(f, theta, rho, rbin, cbin)
%HOUGHPIXELS_ME find the pixel in the Hough.

[x, y, val] = find(f);
x = x - 1; 
y = y - 1;

theta_c = theta(cbin) * pi / 180;
rho_xy = x*cos(theta_c) + y*sin(theta_c);
nrho = length(rho);
slope = (nrho - 1)/(rho(end) - rho(1));
rho_bin_index = round(slope*(rho_xy - rho(1)) + 1);

idx = find(rho_bin_index == rbin);

% return the index of the x, y coordinate of the pixel
r = x(idx) + 1; 
c = y(idx) + 1;
