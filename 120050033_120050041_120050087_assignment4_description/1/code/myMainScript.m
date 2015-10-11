%% Custom SVD Implementation
% Input Matrix - X  
%
% Output:  
%
% * U: Matrix of eigenvectors of (X * X')  
% * V: Matrix of eigenvectors of (X' * X)  
% * S: svd of X  
%
% Negative error correction
%
%    S = U' * X * V;
%    
%    [Sr, Sc] = size(S);
%    for i = 1:min(Sr, Sc)
%        if (S(i, i) < 0)
%            V(:, i) = -1*V(:, i);
%        end
%    end
%    
%    S = U' * X * V;
%

%% Testing 
% *Case 1*
X = [1];
[U, S, V] = mySVD(X);
[Uo, So, Vo] = svd(X);

display(S);
display(So);

%%
% *Case 2*
X = [1 2 4];
[U, S, V] = mySVD(X);
[Uo, So, Vo] = svd(X);
display(S);
display(So);

%%
% *Case 3*
X = [1 2 4; 0 3 6];
[U, S, V] = mySVD(X);
[Uo, So, Vo] = svd(X);
display(S);
display(So);

%%
% *Case 4*
X = [1 2 4; 0 3 6; 9 1 5];
[U, S, V] = mySVD(X);
[Uo, So, Vo] = svd(X);
display(S);
display(So);
