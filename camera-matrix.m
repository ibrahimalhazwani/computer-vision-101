clc, clear all, close all;

% from the calibration result file I took the value of fc, cc, and alpha

% focal length:
fc = [ 578.952814872337060 ; 585.355122127640240 ];
% principal point:
cc = [ 645.829043343746890 ; 366.668100334605700 ];
% skew coefficient:
alpha_c = 0.000000000000000;
% intrinsic matrix
K = [fc(1) alpha_c cc(1); 0 fc(2) cc(2); 0 0 1];

% projection matrix: 
Prj = [1 0 0 0; 0 1 0 0; 0 0 1 0];

% t is the distance form the camera center
t1 = [0 0 3];
t2 = [0 0 5];
t3 = [0.5 1 3];
t4 = [15 1 3];

tform1 = trvec2tform(t1);
tform2 = trvec2tform(t2);
tform3 = trvec2tform(t3);
tform4 = trvec2tform(t4);

% alpha = 0 since the camera is completely aligned with the world coordinate axis
R1 = [cosd(0) 0 sind(0) 0; 0 1 0 0; -sind(0) 0 cosd(0) 0; 0 0 0 1];
R2 = [cosd(0) 0 sind(0) 0; 0 1 0 0; -sind(0) 0 cosd(0) 0; 0 0 0 1];
% alpha = 20 is a positive angle because we rotate on the left which is counterclockwise
R3 = [cosd(20) 0 sind(20) 0; 0 1 0 0; -sind(20) 0 cosd(20) 0; 0 0 0 1];
R3_2 = [cosd(20) 0 sind(20) ; 0 1 0 ; -sind(20) 0 cosd(20)];
R4 = [cosd(20) 0 sind(20) 0; 0 1 0 0; -sind(20) 0 cosd(20) 0; 0 0 0 1];
% camera matrix
P1 = K*Prj*R1*tform1;
P2 = K*Prj*R2*tform2;
P3 = K*Prj*R3*tform3;
% P3_2 = calcola con concatenazione
P4 = K*Prj*R4*tform4;
% coordinate of the object point X
X = [0 0 1 1]';
% image coordinate
x1 = P1*X;
x1 = x1/x1(3)
x2 = P2*X;
x2 = x2/x2(3)
x3 = P3*X;
x3 = x3/x3(3)
x4 = P4*X;
x4 = x4/x4(3)
