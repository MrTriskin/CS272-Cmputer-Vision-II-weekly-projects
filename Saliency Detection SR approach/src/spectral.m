clear all
clf
% Reading img
img = rgb2gray(imread('./imgs/1.jpg'));
img = imresize(img,[64 NaN]);
[rows cols] = size(img);
% 2 dimension FFT
fft_img = fft2(img);
% Amplitude of FFT
% A(f) = REAL(FFT(x))
A_f = abs(fft_img);
% Log Amplitude
% L(f) = log(A(f))
L_f = log(A_f);
% Average kernel
hn = fspecial('average',3);
% Spectral residual
% R(f) = L(f) - hn * L(f)
R_f = L_f - imfilter(L_f, hn, 'replicate');
% Phase of fft_img
phase = angle(fft_img);
% Salianciy Map = g(x) * iFFT((exp(R(f)+phase))^2)
% I think it should be Salianciy Map = g(x) * iFFT(exp(R(f)+phase))^2
saliencyMap = abs(ifft2(exp(R_f + 1i*phase))).^2;
% S = abs(ifft2((exp(R_f + 1i*phase)).^2));
saliencyMap = mat2gray(imfilter(saliencyMap,fspecial('gaussian',10,8)));
figure(1);
imshow(saliencyMap);
% initialize object map
objectMap = zeros(rows,cols,'double');
% set threshold = 3 * average intensity of saliencyMap
threshold = 3*sum(sum(saliencyMap))/(rows*cols);
% build boject map
for i=1:rows
  for j=1:cols
    if saliencyMap(i,j) > threshold
      objectMap(i,j) = 1;
    else
      objectMap(i,j) = 0;
    end
  end
end
figure(2);
imshow(objectMap)
