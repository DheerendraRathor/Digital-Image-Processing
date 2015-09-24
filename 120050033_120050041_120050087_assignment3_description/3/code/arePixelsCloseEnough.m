function [answer] = arePixelsCloseEnough(pixel1, pixel2, epsilon)
        p1 = [pixel1(1,1,1), pixel1(1,1,2), pixel1(1,1,3)];
        p2 = [pixel2(1,1,1), pixel2(1,1,2), pixel2(1,1,3)];
        change = p1 - p2;
        compare = (change <= epsilon);
        sum_ = sum(compare);
        if sum_ == 3
            answer = true;
        else
            answer = false;
        end
end

