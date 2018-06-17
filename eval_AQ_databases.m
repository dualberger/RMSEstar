    
clc,clear all,close all
 %% select quality metric
                % 1 = OPM
                % 2 = SNRac
                % 3 = SNRdc
      
        visual.JH_params=1;


disp(['****************************************************'])
disp(['**************Start of LoudspeakerAudi**************'])            
disp(['****************************************************'])
            
     load GPSMresults_LS_new
     load Loudspeaker_subjectiv
     load LS_subj_std
     
    
            LoudspeakerAudi_objective_global_score_all=LSAudi_objScore;
     
%% **************************************************************************************
% *****************Accuracy measure******************************************************
% ***************************************************************************************
            corr_coeff_mSig=corrcoef(LoudspeakerAudi_subjective_global_score_all,LoudspeakerAudi_objective_global_score_all)           

%% **************************************************************************************            
% *****************Monotonicity measure**************************************************
% ***************************************************************************************
            rank_corr_all=rankcor(LoudspeakerAudi_subjective_global_score_all,LoudspeakerAudi_objective_global_score_all)
            
 %% **************************************************************************************                                 
 % *****************Consistency measure***************************************************
 % ***************************************************************************************
            b = regress(LoudspeakerAudi_subjective_global_score_all,[LoudspeakerAudi_objective_global_score_all ones(size(LoudspeakerAudi_objective_global_score_all))]);
            LoudspeakerAudi_objective_global_score_all = [LoudspeakerAudi_objective_global_score_all ones(size(LoudspeakerAudi_objective_global_score_all))]*b;
            LoudspeakerAudi_objective_global_score_all(LoudspeakerAudi_objective_global_score_all<0)=0;
            LSAudi_sub_Twstd=  LSAudi_subSTD.*1;  
            [consist]=consistency(LoudspeakerAudi_subjective_global_score_all,LoudspeakerAudi_objective_global_score_all,LSAudi_sub_Twstd)
 
 %% **************************************************************************************                                 
 % *****************RMSE measure**********************************************************
 % ***************************************************************************************
            nos=10; % number of subjects (subjects<30 students t distribution, otherwise normal distr.)
            mapping=2; % type of mapping
%                        1->no mapping
%                        2-> 1st order mapping (default)
%                        3-> 3rd order mapping
           [RMSEst]=RMSE_star(LoudspeakerAudi_subjective_global_score_all,LoudspeakerAudi_objective_global_score_all,LSAudi_sub_Twstd,nos,mapping)
 
       
