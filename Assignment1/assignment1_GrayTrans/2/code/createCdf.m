function cdf = createCdf(pdf)
cdf = zeros(256,1);

cdf(1,1) = pdf(1,1);
for i = 2:size(pdf)
   cdf(i,1) = cdf(i-1,1) + pdf(i,1); 
end

end