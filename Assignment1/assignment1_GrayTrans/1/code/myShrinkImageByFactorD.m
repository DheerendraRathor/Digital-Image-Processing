%% MyShrinkImageByFactorD

function out_image = myShrinkImageByFactorD(image, factor)
factor = int32(factor);
[rows, cols] = size(image);
out_image = zeros(idivide(rows,factor), idivide(cols,factor));

for i = 1:rows
    for j = 1:cols
        if (and(eq(mod(i,factor),0) , eq(mod(j,factor), 0)))
            final_i = idivide(i,factor);
            final_j = idivide(j,factor);
            out_image(final_i, final_j) = image(i,j);
        end
    end
end

out_image = uint8(out_image);
end