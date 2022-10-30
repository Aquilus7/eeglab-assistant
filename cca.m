function [W,iW,r,S]=cca(stru,delay)
% This function is used for conducting blind source seperation based on Canonical correlation analysis.

% Inputs                        
%   stru              -struct in ALLEEG.data & EEG.data (eeglab toolbox) or normal 2D matrix
%   delay             -the sample delay (default 1) used to do auto-correlation

% Outputs
%   W                 -Seperation matrix, S=W*X
%   iW                -Mixing matrix
%   r                 -Corresponding auto-correlation coefficients of each row of source
%   S                 -Source matrix with most auto-correlation sources stored in each rows
  
% Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn

if nargin < 2
    delay=1;
end

[m n]=size(stru);
X=stru(:,delay+1:end);
Y=stru(:,1:end-delay);
dX=X - repmat(mean(X,2),1,n-1);
dY=Y- repmat(mean(Y,2),1,n-1); 

XX=dX*dX'./(n-1);
YY=dY*dY'./(n-1);
XY=dX*dY'./(n-1);
YX=XY';
iXX=pinv(XX);
iYY=pinv(YY);
fX=iXX*XY*iYY*YX;
fY=iYY*YX*iXX*XY;
[W r]=eig(fX);
r = sqrt(abs(real(r)));
[r,l] = sort(diag(r),'descend');
W=W(:,l)';
iW=pinv(W);
S=W*X;







