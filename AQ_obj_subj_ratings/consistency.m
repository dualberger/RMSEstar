function [out]=consistency(subj,obj,criterion);
% consistency.m Function to calculate the consistency according to
% Harlander et al. (2014)
% Input
%   subj:       subjective ratings
%   obj:        objective ratings (model predictions)
%   criterion:  criterion for consistency calculation (e.g. 2*standard dev)

% Output
%    out:       consistency
% 2017-03-24, tb
subj=subj(:);
obj=obj(:);
criterion=criterion(:);

zeros_vec=zeros(length(criterion),1);
zeros_vec(abs(obj-subj)>criterion)=1;
out=1-(sum(zeros_vec)/length(zeros_vec));