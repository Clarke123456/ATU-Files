rgb = imread('3.png');                              %Read in Image
figure,imshow(rgb),title('RGB Image')               %Display Image

I = rgb2gray(rgb);                                  %Convert rgb to gray
figure,imshow(I),title('GreyScale Image')           %Display Gray Image


[~,threshold] = edge(I,'sobel');                    %Calculate thresh using edge & sobel
fudgeFactor = 0.9;                                  %Tune Thresh
BWs = edge(I,'sobel',threshold * fudgeFactor);      %Create Binary mask using Edge again
figure,imshow(BWs),title('Binary Gradient Mask')    %Display Binary Gradient Mask

se90 = strel('line',3,90);                          %Create Linear Structering Element
se0 = strel('line',3,0);                            %Create Linear Structering Element-Perpendicular
BWsdil = imdilate(BWs,[se90 se0]);                  %Dilate Binary Gradient Mask
figure,imshow(BWsdil),title('Dilated Gradient Mask')%Display Dialted Gradient Mask

BWdfill = imfill(BWsdil,'holes');                   %Fill Interior Gaps
figure,imshow(BWdfill),title('Binary Image with Filled Holes') %Display Filled Binary Image

BWnobord = imclearborder(BWdfill,4);                %Remove Connected Border Oblects
figure,imshow(BWnobord),title('Cleared Border Image')%Display Result

seD = strel('diamond',1);                           %Create diamond structering Element using Strel Function
BWfinal = imerode(BWnobord,seD);                    %Smooth Object By Eroding
BWfinal = imerode(BWfinal,seD);                     %Smooth Object By Eroding
figure,imshow(BWfinal),title('Segmented Image');    %Display Segmented Image

BWdfinal = imfill(BWfinal,'holes');                 %Fill Holes In Binary Image
figure,imshow(BWdfinal),title('Binary Image with Filled Holes')%Display Result

BWffinal = bwareaopen(BWdfinal,400);                %Remove Objects With Fewer Than 400 Pixels
figure,imshow(BWffinal),title('Clean Image')        %Display Cleaned Image

BWfill = imfill(BWffinal,'holes');                  %Repeat Fill Holes In Binary Image  
figure,imshow(BWfill),title('Binary Image Refilled')%Display Result


[labeledImage, numberOfObjcts] = bwlabel(BWfill);                             %Get regions and Attach Label to Components
ObjectMeasurements=regionprops(labeledImage,'Perimeter','Area','Centroid'); %Measure Properties Of Regions

figure, imshow(BWfill, []),title('See the Labels')  % Display Labels for images
vislabels(labeledImage)

% GET CIRCULAR INFORMATION
circularities = [ObjectMeasurements.Perimeter].*[ObjectMeasurements.Perimeter]./(4*pi*[ObjectMeasurements.Area]);  %Circularity Equation
