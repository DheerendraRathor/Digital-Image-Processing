function clipped_pdf = clipPdf(pdf, threshold)

clipped_pdf = pdf;
offset = 0;

for i = 1:size(clipped_pdf,1)
   if (clipped_pdf(i,1) >= threshold)
       offset = offset + clipped_pdf(i,1) - threshold;
       clipped_pdf(i,1) = threshold;
   end
end

clipped_pdf = clipped_pdf + offset/size(clipped_pdf,1);
end