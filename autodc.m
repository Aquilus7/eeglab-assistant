function [ALLEEG EEG CURRENTSET dc lcn]=autodc(ALLEEG,EEG,ind,class,thresh,over)
% Input 
% ind           -index of ALLEEG struct
% class         -class of components, 1-7 for 'Brain','Muscle','Eye''Heart','Line Noise','Channel Noise','Other' respectively
% thresh        -threshold in percentage that one component is possible to belong to a particular class of artifact
% over          -overwrite or pop a new set

% Output
% dc            - index of removed components
% lcn           - numbers of left components

% AeolusQuinlan, wentaozeng@stu.xjtu.edu.cn
if nargin <6
    over='yes';
end
a=ALLEEG(ind).etc.ic_classification.ICLabel.classifications(:,class);  
n=find(a>thresh);
if isempty(n)
    fprintf('%s','no component matched the threshold! ');
    dc=[];lcn=size(ALLEEG(ind).icaweights,1);
else
    EEG=ALLEEG(ind);
    
EEG = pop_subcomp( EEG, n, 0);
dc=n; lcn=size(ALLEEG(ind).icaweights,1)-size(n,1);
end
% check if needs to overwrite
if contains(over,'yes')
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, ind,'overwrite','on','gui','off'); 
else
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, ind,'overwrite','off','gui','off'); 

end
