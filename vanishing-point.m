clc, clear all, close all;
corr_one = imread("Corridor1.jpg");
corr_two = imread("Corridor2.jpg");

corr_one = rgb2gray(corr_one);
corr_two = rgb2gray(corr_two);

edge_corr_one = edge(corr_one, "Canny");
edge_corr_two = edge(corr_two, "Canny");

figure(1);
subplot(121), imshow(corr_one);
subplot(122), imshow(edge_corr_one);

figure(2);
subplot(121), imshow(corr_two);
subplot(122), imshow(edge_corr_two);

[H,T,R] = hough(edge_corr_one,'RhoResolution',1,'Theta',-90:0.5:89);
figure, imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform of Corridor One');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca, hot);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
figure(3), plot(x,y,'s','color','white');
lines = houghlines(edge_corr_one,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(corr_one), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


[H,T,R] = hough(edge_corr_two,'RhoResolution',1,'Theta',-90:0.5:89);
figure, imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform of Corridor Two');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca, hot);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
figure(3), plot(x,y,'s','color','white');
lines = houghlines(edge_corr_one,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(corr_two), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


