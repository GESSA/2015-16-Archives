%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GESSA MATLAB TUTORING Week 1
%This example is taken from : http://www.mathworks.com/help/images/examples/detect-and-measure-circular-objects-in-an-image.html?prodcode=ML
%Detect and measure circular objects in an image (image processing)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%read and show an image
rgb = imread('coloredChips.png');
figure
imshow(rgb)

% create a measureing tool to measure approximately radius of circles
%d = imdistline;
%delete(d);

%Check if objects are brighter or darker than background
gray_image = rgb2gray(rgb);
imshow(gray_image);

%Most of the circles are brighter.

%imfindcircles finds circular objects that are brighter than the background
%in the following manner, but this still misses almost everything.
%[centers, radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark')

%Lets us try increasing the sesitivity (this is like inverse of threshold)
%From MATLAB site: A higher 'Sensitivity' value sets the detection threshold lower and leads to detecting more circles.
%This is similar to the sensitivity control on the motion detectors used in home security systems.

[centers, radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', ...
    'Sensitivity',0.95);

% Draw all the circles (you can always click F1 on any function to get more details about it)
imshow(rgb);
h = viscircles(centers,radii);
%Lets also cover the lighter ones - yellow ones
[centersBright, radiiBright] = imfindcircles(rgb,[20 25],'ObjectPolarity', ...
    'bright','Sensitivity',0.95);

% imshow(rgb);
 %hBright = viscircles(centersBright, radiiBright,'Color','b');

%Edge Threshold 
%The 'EdgeThreshold' parameter controls how high the gradient value at a pixel has to be before it is considered an edge pixel
%and included in computation. A high value (closer to 1) for this parameter will allow only the strong edges (higher gradient values) to be included,
%whereas a low value (closer to 0) is more permissive and includes even the weaker edges (lower gradient values) in computation.
 
%[centersBright, radiiBright, metricBright] = imfindcircles(rgb,[20 25], ...
%    'ObjectPolarity','bright','Sensitivity',0.92,'EdgeThreshold',0.1);
 %delete(hBright);
 hBright = viscircles(centersBright, radiiBright);
 h = viscircles(centers,radii);
