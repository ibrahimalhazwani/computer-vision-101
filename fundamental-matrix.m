clc, clear all, close all;

% load the images
img1 = imread("image1.jpg");
img2 = imread("image2.jpg");
% convert into gray images
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
% detect features
points1 = detectSURFFeatures(img1);
points2 = detectSURFFeatures(img2);
% extract features;
[f1,vpts1] = extractFeatures(img1,points1);
[f2,vpts2] = extractFeatures(img2,points2);
% match features;
indexPairs = matchFeatures(f1,f2);
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));
% plot
figure; showMatchedFeatures(img1,img2,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
% 8 points
p1 = ([matchedPoints1.Location(1: 8, :), ones(8, 1)])';
p2 = ([matchedPoints2.Location(1: 8, :), ones(8, 1)])';
% get the normalize matrix
[x,y] = size(img1);
T = [2/x 0 -1; 0 2/y -1; 0 0 1];
x1 = T*p1;
x2 = T*p2;

A = [x2(1,:)'.*x1(1,:)' x2(1,:)'.*x1(2,:)' x2(1,:)' ... 
    x2(2,:)'.*x1(1,:)' x2(2,:)'.*x1(2,:)' x2(2,:)' ... 
    x1(1,:)' x1(2,:)' ones(8,1) ];
[U,D,V] = svd(A);
F = reshape(V(:,9),3,3)'; 
[U,D,V] = svd(F);
F = U*diag([D(1,1) D(2,2) 0])*V';
% Denormalise 
F = T'*F*T;

% epipolar points
[~,~,v] = svd(F);
epi_one = v(:,3)/v(3,3);
[~,~,v] = svd(F');
epi_two = v(:,3)/v(3,3);

% plot the epipolar point on the image
imshow(img1), hold on;
plot(epi_one(1,1), epi_one(2,1), 'o','MarkerSize',10,'color', 'Yellow');
imshow(img2), hold on;
plot(epi_two(1,1), epi_two(2,1), 'o','MarkerSize',10, 'color', 'Green'); 

% EXTRA
% use the predefined matlab function to searching for the inliners used for
% plotting epipolar lines and epipols
[fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,...
    matchedPoints2,'NumTrials',4000);
% figure1
figure, imshow(img1), hold on
title('Inliers and Epipolar Lines in First Image')
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go'), hold on
plot(epi_one(1,1), epi_one(2,1),'o','LineWidth',2,'markersize', 20, 'Color', 'blue')
epiLines = epipolarLine(F',matchedPoints2.Location(inliers,:));
points = lineToBorderPoints(epiLines,size(img1));
line(points(:,[1,3])',points(:,[2,4])');
% figure2
figure, imshow(img2), hold on
title('Inliers and Epipolar Lines in Second Image')
plot(matchedPoints2.Location(inliers,1),matchedPoints2.Location(inliers,2),'go'), hold on
plot(epi_two(1,1), epi_two(2,1),'o','LineWidth',2,'markersize', 20, 'Color', 'blue')
epiLines = epipolarLine(F',matchedPoints2.Location(inliers,:));
points = lineToBorderPoints(epiLines,size(img1));
line(points(:,[1,3])',points(:,[2,4])');
