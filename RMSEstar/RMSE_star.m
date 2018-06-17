function [RMSEst]=RMSE_star(subj,obj,subj_std,nos,mapping);
% RMSE_star.m Function to calculate the RMSE* (epsilon-insensitive rmse)
% according to ITU-T P.1401 (07/2012).
% [...This is a rmse that considers the confidence interval
% of the individual MOS scores. This metric is calculated like the traditional rmse, but small
% differences to the target value are not counted. This rmse considers only differences related to an
% epsilon-wide band around the target value. This 'epsilon' is defined as the 95 per cent confidence
% interval of the subjective MOS value. By definition, the uncertainty of the MOS is taken into
% account in this evaluation...]

% Input
%   subj:       subjective ratings
%   obj:        objective ratings (model predictions)
%   sub_std:    standard deviations of subjective ratings per
%               condition/algorithm
%   nos:        number of subjects
%   mapping:    no maping ('1')
%               first order mapping ('2')-> default
%               third order mapping ('3')

% Output
%    RMSEst:      rmse* a.k.a. epsilon-insensitive rmse
% 2018-02-06, thomas.biberger@uni-ol.de

subj=subj(:);
subj_std=subj_std(:);
obj=obj(:);

if nargin <5
    mapping=2;
else
end

%% at first, a mapping function is applied to objective score

if mapping ==1;    % no mapping is applied
    
elseif mapping ==2;  % first order mapping is applied
    [obj] = mapping_fun(subj,obj,mapping);
elseif mapping ==3;  % third order mapping is applied
    [obj] = mapping_fun(subj,obj,mapping);
else
    error('No valid mapping selected')
end


%% here starts the rmse* calculation

% ****** Some default settings ************
ci=95; % confidence interval in percentage
alpha=1-ci/100; % alpha
% *****************************************

N=length(subj); % number of conditions
dof=nos-1; % degree of freedom

% use t-distribution for less than 30 subjects, otherwise normal
% distribution
if nos < 30;
    quant = tinv(1-alpha/2,dof); % 95% quantile
    CI95=quant.*(subj_std./sqrt(nos));  % 95% confidence interval
else
    quant= norminv([alpha/2 1-alpha/2],0,1);% 95% quantile
    CI95=quant(2).*(subj_std./sqrt(nos));    % 95% confidence interval
end

% Eq. (7-29) in ITU-T P.1401 (07/2012)
Perror=max(0,abs(subj-obj)-CI95);
Perror_tot=sum(Perror);

% calculation of the final RMSE* with respect to the selected mapping
% function
if mapping ==1
    RMSEst=sqrt((1/(N-1))*Perror_tot);
elseif mapping ==2
    RMSEst=sqrt((1/(N-2))*Perror_tot);
elseif mapping == 3
    RMSEst=sqrt((1/(N-4))*Perror_tot);
else
    error('No valid mapping!')
end


end


