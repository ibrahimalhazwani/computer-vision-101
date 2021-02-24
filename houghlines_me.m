function lines = houghlines_me(f,theta,rho,rr,cc,fillgap,minlength)
% HOUGHLINES_ME returns the lines based on the resutl of hugh_me function.
% It takes as parameters:  
%      length    Distance between point1 and point2
%      theta     Angle (in degrees) of the Hough transform
%      rho       Rho-axis position of the Hough transform
%      rr        Row from the Houghpixel_me
%      cc        Coloumn from the Houghpixel_me
%      fillgap   Integer to check how neat are two lines. If the distance
%                between two lines is less than fillgap the two lines are 
%                going to be marged.
%      minleght  Minum lenght of the line to be displayed and merged

if nargin < 6 
   fillgap = 20; 
end
if nargin < 7 
   minlength = 40; 
end

numlines = 0; lines = struct;
for k = 1:length(rr)
   rbin = rr(k); cbin = cc(k);
   
   % Get all pixels associated with Hough transform cell.
   [r, c] = houghpixels_me(f, theta, rho, rbin, cbin);
   if isempty(r) 
      continue 
   end
   
   % Rotate the pixel locations about (1,1) so that they lie
   % approximately along a vertical line.
   omega = (90 - theta(cbin)) * pi / 180;
   T = [cos(omega) sin(omega); -sin(omega) cos(omega)];
   xy = [r - 1  c - 1] * T;
   x = sort(xy(:,1));
   
   % Find the gaps larger than the threshold.
   diff_x = [diff(x); Inf];
   idx = [0; find(diff_x > fillgap)];
   for p = 1:length(idx) - 1
      x1 = x(idx(p) + 1); x2 = x(idx(p + 1));
      linelength = x2 - x1;
      if linelength >= minlength
         point1 = [x1 rho(rbin)]; point2 = [x2 rho(rbin)];
         % Rotate the end-point locations back to the original
         % angle.
         Tinv = inv(T);
         point1 = point1 * Tinv; point2 = point2 * Tinv;
         
         numlines = numlines + 1;
         lines(numlines).point1 = point1 + 1;
         lines(numlines).point2 = point2 + 1;
         lines(numlines).length = linelength;
         lines(numlines).theta = theta(cbin);
         lines(numlines).rho = rho(rbin);
      end
   end
end
