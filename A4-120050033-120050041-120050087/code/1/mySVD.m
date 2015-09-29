function [U, S, V] = mySVD(X)
   [U, Uv] = eig(X * X');
   [V, Vv] = eig(X' * X);
   S = U' * X * V;
   
   display(U);
   display(V);
   display(S);
   
   [U, S, V] = svd(X);
   
   display(U);
   display(V);
   display(S);
end