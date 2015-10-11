function rmsd = myRMSDofImage(imageA, imageB)
    [row, col] = size(imageA);
    sum_of_distance = sum(sum((imageA- imageB).^2));
    sum_of_distance = sum_of_distance/(row*col);
    rmsd = sqrt(sum_of_distance);
end