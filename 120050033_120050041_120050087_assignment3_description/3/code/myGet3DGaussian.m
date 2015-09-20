function guassian3 = myGet3DGaussian(A, sigma, xr, yr, zr)
    guassian3 = zeros(xr, yr, zr);
    mx = ceil(xr/2);
    my = ceil(yr/2);
    mz = ceil(zr/2);
    
    for x=1:xr
        for y=1:yr
            for z=1:zr
                r_sqr = (x-mx)^2 + (y-my)^2 + (z-mz)^2;
                guassian3(x, y, z) = A * exp(-r_sqr/(2*sigma*sigma));
            end
        end
    end
end