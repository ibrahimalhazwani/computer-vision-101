clc; clear all; close all;

corridor = imread("Corridor1.jpg");
corridor_grey = rgb2gray(corridor);
figure(1), imshow(corridor_grey), title('Gray Scale Image')

% Canny edge detector

edge_dect = edge(corridor_grey, "Canny");
figure(2), imshow(edge_dect), title('Canny Edge Detection')

% Hough Transform - Matlab implementation 

% [H,T,R] = hough(lines,'RhoResolution',1,'Theta',-90:0.5:89);
% figure, imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
% title('Hough transform of gantrycrane.png');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(gca, hot);
% P  = houghpeaks(H,5);
% imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal,
% plot(T(P(:,2)),R(P(:,1)),'s','color','yellow');


% Hough Transform - personal implementation

[h, theta, rho] = hough_me(edge_dect,0.5,1);
figure,imshow(imadjust(rescale(h)), 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
title('Hough trasformation');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca, bone);

% P  = houghpeaks(h,5);
% imshow(h,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal,
% plot(theta(P(:,2)),rho(P(:,1)),'s','color','yellow');
 
% HoughPeaks

[r,c,hnew] = houghpeaks_me(h, 5, 0.7);
x = theta(c);
y = rho(r);
plot(x,y,'s','color','red')

% Houghlines

lines = houghlines_me(edge_dect,theta,rho,r,c);

figure(5), imshow(corridor_grey), hold on
 for k = 1:length(lines)
    xy = [lines(k).point1 ; lines(k).point2];
    plot(xy(:,2), xy(:,1), 'Linewidth', 3 , 'Color', [1 1 0]);
    plot(xy(1,2),xy(1,1),'x','LineWidth',2,'Color','green');
    plot(xy(2,2),xy(2,1),'x','LineWidth',2,'Color','red');
 end
