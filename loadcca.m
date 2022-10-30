function [ALLEEG,ic2cc]=loadcca(base,stru,W,A,Wm)
% this function is used to load cca information into the ica related fields of a new dataset for visualization which tested 
% by getting source=EEG.icaweights*EEG.icasphere*EEG.data then load source as data
% into EEGlab (in a new set add to the end of ALLEEG). The waveform of source data 
% is all the same to component activation in original data set.
% Note: Preference options: precompute ICA activations should be closed in
% order to get CCA infomation (otherwise It still shows ICA
% information);If Preference options:Scale ICA is closed, the source showed
% in Plot: components activation is same to S or it would be scaled to RMS
% microvolt thus looks different (weight and winv matrix would also be scaled thus has no actual effect on processing.)

% Inputs
% base        -always be ALLEEG
% stru        -struct in ALLEEG on which cca has been calculated
% ind         -index of instruct, e.g. 4 for ALLEEG(4)
% setname     -new setname with cca information stored in ica related fields

%Outputs
%ic2cc        -same to ALLEEG

% Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn

stru.icaweights=double(W);
stru.icawinv=double(A);
stru.icasphere=double(Wm);
stru.icachansind=[1:size(stru.data,1)];
stru=eeg_checkset(stru);
base(end+1)=stru;

ALLEEG=base;
if nargout > 1
    ic2cc=stru;
end