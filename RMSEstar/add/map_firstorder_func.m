function[rmse_out]=map_firstorder_func(vParams,obj,subj);
% map_firstorder_func.m Calculates the rmse between subjective and
% objective scores mapped onto the first order mapping function

% 2018-02-06, thomas.biberger@uni-ol.de


reg1=ones(size(obj)).*vParams(2);
reg2=obj.*vParams(1);
y_opt=reg1+reg2;

rmse_out=sqrt(mean((subj-y_opt).^2));
end