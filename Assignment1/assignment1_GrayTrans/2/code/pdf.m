function pd_values = pdf(image, lower_r, higher_r, lower_c, higher_c)
[pixel_counts] = imhist(image(lower_r:higher_r, lower_c:higher_c));
pd_values = pixel_counts / ((higher_r - lower_r+1)*(higher_c - lower_c+1));
end