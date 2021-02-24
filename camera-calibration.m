clc, clear all, close all;

addpath('/Users/ibrahim/Documents/MATLAB/TOOLBOX_calib');
calib_gui

% Calibration parameters after initialization:
% 
% Focal Length:          fc = [ 2595.50661   2595.50661 ]
% Principal point:       cc = [ 1631.50000   917.50000 ]
% Skew:             alpha_c = [ 0.00000 ]   => angle of pixel = 90.00000 degrees
% Distortion:            kc = [ 0.00000   0.00000   0.00000   0.00000   0.00000 ]
% 
% Main calibration optimization procedure - Number of images: 15
% Gradient descent iterations: 1...2...3...4...5...6...7...8...9...10...11...12...13...14...15...16...17...18...done
% Estimation of uncertainties...done
% Calibration results after optimization (with uncertainties):
% 
% Focal Length:          
fc = [ 2580.07613   2578.82500 ] %+/- [ 6.85658   6.62802 ]
% Principal point:       
cc = [ 1623.61390   929.16102 ] %+/- [ 9.71830   7.52473 ]
% Skew:             
alpha_c = [ 0.00000 ] %+/- [ 0.00000  ]   => angle of pixel axes = 90.00000 +/- 0.00000 degrees
% Distortion:            
kc = [ 0.15249   -0.41887   0.00202   -0.00113  0.00000 ] %+/- [ 0.01266   0.07254   0.00134   0.00178  0.00000 ]
% Pixel error:          
err = [ 0.64040   0.71762 ]

% Number(s) of image(s) to show ([] = all images) = 
% Pixel error:      err = [0.64040   0.71762] (all active images)

% Aspect ratio optimized (est_aspect_ratio = 1) -> both components of fc are estimated (DEFAULT).
% Principal point optimized (center_optim=1) - (DEFAULT). To reject principal point, set center_optim=0
% Skew not optimized (est_alpha=0) - (DEFAULT)
% Distortion not fully estimated (defined by the variable est_dist):
%      Sixth order distortion not estimated (est_dist(5)=0) - (DEFAULT) .
% 
% Main calibration optimization procedure - Number of images: 15
% Gradient descent iterations: 1...2...3...4...5...6...7...8...9...10...11...12...13...14...15...16...17...done
% Estimation of uncertainties...done


% Calibration results after optimization (with uncertainties):

% %Focal Length:          
% fc = [ 2581.42398   2580.15602 ] %+/- [ 8.29686   8.01963 ];
% %Principal point:       
% cc = [ 1622.97023   933.60129 ] %+/- [ 11.76165   9.10552 ];
% %Skew:             
% alpha_c = [0.00000];
% %Distortion:            
% kc = [ 0.14745   -0.40354   0.00259   -0.00128  0.00000 ] %+/- [ 0.01538   0.08826   0.00161   0.00214  0.00000 ];
% %Pixel error:          
% err = [ 0.79161   0.85085 ];

% K MATRIX

K1 = [fc(1) alpha_c cc(1); 0 fc(2) cc(2); 0 0 1];
K1

%%
% importing gopro images

gopro_img = imread("GOPR1515 06102.jpg");
%-- Focal length:
fc = [ 585.850107917267790 ; 586.003198722303180 ];

%-- Principal point:
cc = [ 664.903569991381570 ; 498.409524449186850 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.159950393345315 ; 0.000000000000000 ; -0.000685869015729 ; -0.004896132860374 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 8.710017825595292 ; 8.939613454740497 ];

%-- Principal point uncertainty:
cc_error = [ 5.809944557431711 ; 7.463027311611222 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

K2 = [fc(1) alpha_c_error cc(1); 0 fc(2) cc(2); 0 0 1];
K2
