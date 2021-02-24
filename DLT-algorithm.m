clc; clear all; close all;

photo_one = imread("IMG_1841.jpg");
photo_one = rgb2gray(photo_one);
photo_one = imrotate(photo_one, -90);

photo_two = imread("IMG_1842.jpg");
photo_two = rgb2gray(photo_two);
photo_two = imrotate(photo_two, -90);

% Detect surf of the images

points_one = detectSURFFeatures(photo_one);
points_two = detectSURFFeatures(photo_two);
figure, imshow(photo_one); hold on;
plot(points_one.selectStrongest(4));
figure, imshow(photo_two); hold on;
plot(points_two.selectStrongest(4));

% Detect features

[features1,valid_points1] = extractFeatures(photo_one,points_one);
[features2,valid_points2] = extractFeatures(photo_two,points_two);

% Match the features

indexPairs = matchFeatures(features1,features2);

% Locations of the corresponding points

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure; showMatchedFeatures(photo_one,photo_two,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');

% Compute the 3x3 homography matrix H
A = zeros(2*length(matchedPoints1),9);

for n = 1:size(matchedPoints1.Location)
    x(n,:) = matchedPoints1.Location(:,1);
    xp(n,:) = matchedPoints2.Location(:,2);
    
    A(n*2-1,:) = [-x(n,1) -x(n,2) -1 0 0 0 x(n,1)*xp(n,1) x(n,2).*xp(n,1) xp(n,1)];
    A(n*2,:) = [0 0 0 -x(n,1) -x(n,2) -1 x(n,1)*xp(n,2) x(n,2)*xp(n,2) xp(n,2)];
end

[U,S,V] = svd(A);
H = V(:,end);
H=reshape(H,3,3);

image1points=zeros(length(matchedPoints1),2);
image2points=zeros(length(matchedPoints1),2);
for index =1:length(matchedPoints1)
    x=matchedPoints1(index).Location;
    projection = [x(1); x(2); 1].*H;
    projection_carthesian= [projection(1)/projection(3) projection(2)/projection(3)];
    image1points(index,:)=x;
    image2points(index,:)=projection_carthesian;
end
figure ,showMatchedFeatures(photo_one,photo_two,image1points,image2points);


