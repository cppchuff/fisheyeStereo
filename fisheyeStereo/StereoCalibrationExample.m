%% Stereo Camera Calibration
% Specify calibration images.

% Copyright 2015 The MathWorks, Inc.

imageDir = fullfile(toolboxdir('vision'),'visiondata','calibration','stereo');
leftImages = imageSet(fullfile(imageDir,'left'));
rightImages = imageSet(fullfile(imageDir,'right'));
images1 = leftImages.ImageLocation;
images2 = rightImages.ImageLocation;

%%
% Detect the checkerboards.
[imagePoints, boardSize] = detectCheckerboardPoints(images1,images2);

%%
% Specify the world coordinates of the checkerboard keypoints.
squareSizeInMM = 21.22;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);

%%
% Calibrate the stereo camera system.
im = read(leftImages,1);
stereoparams = estimateCameraParameters(imagePoints,worldPoints);

%%
% Visualize the calibration accuracy.
showReprojectionErrors(stereoparams);