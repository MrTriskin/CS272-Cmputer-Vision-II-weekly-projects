function [ saliencyMap ] = singleScale( R, K, img )

  [height, width, layer] = size(img);
  % color part
  labImg = padarray(rgb2lab(img),[3 3]);
  saliencyMap = zeros(size(img));
  patches = cell(size(img));
  for l=1:layer
    for row=4:height+3
      for col=4:width+3
        patches{row-3,col-3,l} = reshape(labImg(row-R:row+R,col-R:col+R,l),[],1);
      end
    end
  end
  maxDcolor = 100*(2*R+1);
  maxDdistance = (height^2 + width^2)^0.5;
  for l=1:layer
    display(l);
    for row=1:height
      for col=1:width
        % display(['row ' torow ' col ' col ' layer ' l]);
        dColor = zeros(size(img,1),size(img,2));
        dDistance = zeros(size(img,1),size(img,2));
        for r=1:R:height
          for c=1:R:width
              dColor(r,c) = (sum((patches{row,col,l} - patches{r,c,l}).^2))^0.5;
              dDistance(r,c) = ((row-r)^2 + (col-c)^2)^0.5;
          end
        end
        tmp = dColor./maxDcolor./(1+3*dDistance./maxDdistance);
        ks = reshape(tmp,[],1);
        ks = sort(ks(ks~=0));
        ks = ks(1:K);
        saliencyMap(row,col,l) = 1-exp((-1/K)*sum(ks));
      end
    end
  end
end  % function
