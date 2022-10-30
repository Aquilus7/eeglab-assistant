function [stru,enum,epochtime]=restev(stru,eplen,overlap)
% This function is used to insert marker on continuous resting data 
% for segmentation.
% stru is a struct in ALLEEG, like ALLEEG(1). 
% eplen is epoch length defined by the user, overlap
%is the ratio of overlapping between epochs.
% Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn
le=size(stru.data,2);
intv=eplen*stru.srate*(1-overlap);
enum=floor(le/intv);
epochtime=[1:intv:1+(enum-1)*intv];

for index = 1:length(epochtime)
	stru.event(end+1).type= 'cut';
    stru.event(end).latency= epochtime(index);
end
     stru = pop_editeventvals( stru, 'sort', { 'latency', [0] } );
if isfield(stru.event, 'urevent')
    stru.event = rmfield(stru.event, 'urevent');
end
stru = eeg_checkset(stru, 'eventconsistency');
stru = eeg_checkset(stru, 'makeur');
end


