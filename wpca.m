function [W,Y] = wpca(X,nbc,eigratio)
% This function is used to conduct whitening and dimension reduction for Blind source seperation based on canonical correlation analysis

% Input
%   X          -Matrix for testing the need of whitening and dimension reduction
%   nbc        -desired dimension
%   eigratio   -singularity tolerence, the ratio between the highest and lowest eigenvalues of covariance matrix of X
% The last 2 inputs are optional

% Output
%   W          -Whitening and dimension reduction matrix  
%   Y          -Whitened matrix with dimension reducted
% Note even user defined nbc this function will still check if further
% dimension reduction is needed and this function will always whitened the X even dimension reduction is not needed

% Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn

%check the number of inputs
if nargin < 3, eigratio = 1e8; end
if nargin < 2, nbc = size(X,1); end

% preparation for whitening and dimension reduction
C = cov(X');  %cov=dX'*dX./m,dX is X minus means of each column, n is length of columns(number of rows)
[V,D] = eig(C);
[val,I] = sort(abs(diag(D)),'descend');

% whitening and dimension reduction based on tolerence (eigratio)
while val(1)/val(nbc)>eigratio 
    nbc = nbc-1;
end
V = V(:,I(1:nbc));
tmp =diag(D);
D = diag(tmp(I(1:nbc))); 
W = D^(-.5)*V';      
Y = W*X;   