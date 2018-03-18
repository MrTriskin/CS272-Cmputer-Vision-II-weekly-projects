function [ saliencyMap, l, a, b ] = showImg( img )

  l = mat2gray(img(:,:,1));
  a = mat2gray(img(:,:,2));
  b = mat2gray(img(:,:,3));
  saliencyMap = l+a+b;
  figure;
  imshow(l);
  figure;
  imshow(a);
  figure;
  imshow(b);
  figure;
  imshow(saliencyMap);
end  % function
