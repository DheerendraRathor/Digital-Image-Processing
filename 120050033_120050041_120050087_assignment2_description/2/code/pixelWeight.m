function weight = pixelWeight(image, p1, p2, sigmaD, sigmaR)
    i = p1(1,1); 
    j = p1(1,2); 
    k = p2(1,1); 
    l = p2(1,2);
    temp1 = ((i - k).^2 + (j - l).^2)/2*(sigmaD.^2);
    temp2 = ((image(i,j) - image(k,l)).^2)/2*(sigmaR.^2);
    weight = exp(-(temp1 + temp2));
end