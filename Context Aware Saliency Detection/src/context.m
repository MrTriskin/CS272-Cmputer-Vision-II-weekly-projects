clear all
clf
% load('fig2.mat');
% read in raw rgb img
K = 64;
Rq = [1 2 3];

img = imread('./imgs/bird.jpg');
scale all the imgs to the same size of 250 pixels in largest dimension
if size(img,1) > size(img,2)
  img = imresize(img,[250 NaN]);
else
  img = imresize(img,[NaN 250]);
end
saliencyMap1 = singleScale(Rq(1), K, img);
saliencyMap2 = singleScale(Rq(2), K, img);
saliencyMap3 = singleScale(Rq(3), K, img);
[saliencyMap11 l1 a1 b1] = showImg(saliencyMap1);
[saliencyMap22 l2 a2 b2] = showImg(saliencyMap2);
[saliencyMap33 l3 a3 b3] = showImg(saliencyMap3);
saliencyMap = (saliencyMap1 + saliencyMap2 + saliencyMap3 )./3;
[saliencyMap l a b] = showImg(saliencyMap);
