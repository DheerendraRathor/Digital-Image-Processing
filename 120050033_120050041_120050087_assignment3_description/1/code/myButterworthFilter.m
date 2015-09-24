function [filter] = myButterworthFilter(d0, n, window)
    filter = zeros(window);
    mp = ceil(window./2);
    
    for i = 1:window
        for j = 1:window
            d = sum(([i, j] - mp).^2).^0.5;
            filter(i, j) = 1/(1 + (d/d0)^(2*n));
        end
    end
    
    %% plotting the curve using - surf(filter)
end