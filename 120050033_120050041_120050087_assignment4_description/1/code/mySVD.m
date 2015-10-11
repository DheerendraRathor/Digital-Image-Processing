function [U, S, V] = mySVD(X)
   [U, Uv] = eig(X * X');
   [V, Vv] = eig(X' * X);
   
   U = fliplr(U);
   V = fliplr(V);
   
   S = U' * X * V;
   
   [Sr, Sc] = size(S);
   for i = 1:min(Sr, Sc)
       if (S(i, i) < 0)
           V(:, i) = -1*V(:, i);
       end
   end
   
   S = U' * X * V;
end