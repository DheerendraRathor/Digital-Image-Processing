function pdf = createPdf(image, center_r, center_c, half_size_r, half_size_c)
pdf = zeros(256,1);
point_count = 0;

for i = center_r-half_size_r:center_r+half_size_r
    for j = center_c-half_size_c:center_c+half_size_c
        if (i <= 0 || i > size(image, 1) || j <= 0 || j > size(image, 2))
          continue
        end
        
        pdf(image(i,j)+1, 1) = pdf(image(i,j)+1, 1) + 1;
        point_count = point_count + 1;
    end
end
display(pdf);
pdf = pdf/point_count;
end