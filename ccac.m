function [W,W2,A,r,S,Wm] =ccac(stru,delay,nbs,eigratio)
% This function is used to conduct blind source seperation based on Canonical correlation analysis.
% If user desire less sources than channels or the channels are not totallyindependent, dimension reduction and whitening would work automatically. 
% Inputs
%   stru             -ALLEEG(i).data & EEG.data (eeglab) or normal 2D matrix
%   delay            -sample delay for auto-correlation
%   nbs              -desired source number (only works when rank of stru is not below: actual eigratio is not above aigratio)
%   eigratio         -eigratio is the tolerence of singularity (the ratio of the highest and lowest eigenvalues of covariance matrix of stru)
%   the last 3 inputs are optional

% Outputs
%   W                -Seperation matrix for reducted signals, makes rows in Source=W*stru independent to each other and have the highly auto-correlated
%   W2               -W2=W*Wm, seperation matrix for complete signal
%   A                -Mixing matrix, pseudo inversed matrix of W (inversed matrix if stru has not been processed with dimension reduction), original signal can be get by A*S
%   r                -corresponding auto-correlation coefficients of each rows of Source
%   S                -Source matrix
%   Wm               -Whitening matrix (if the function determined not to white it is an Unit matrix)

% Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn

% check the number of inputs
if nargin ==1
    delay =1;
    nbs=size(stru,1);
    eigratio=1e6;
elseif nargin == 2
    nbs =size(stru,1);
    eigratio=1e6;
elseif nargin == 3
        eigratio=1e6;
end

% check if needs to reduct dimension
if eigratio < inf || nbs < size(stru,1)
    [Wm stru]=wpca(stru,nbs,eigratio); % this stru has been whitened with dimension reducted in the same time
else 
    Wm=eye(nbs,nbs);
end
    [W,~,r,S]=cca(stru,delay);
    W2=W*Wm;                   % if dimension reduction and whitening occurred,A should be the pseudo matrix of W*Wm to get stru for S=W*Wm*stru
    A=pinv(W2);
                      
    



