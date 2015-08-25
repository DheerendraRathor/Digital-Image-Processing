function rmsd = myRMSDofImage(imageA, imageB)
    [row, col] = size(imageA);
    sum=0;
    for i=1:row
        for j=1:col
            sum = sum + (imageA(i,j) - imageB(i,j))^2;
        end
    end
    sum = sum/(row*col);
    rmsd = sqrt(sum);
end