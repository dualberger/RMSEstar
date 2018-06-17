function [ obj_opt ] = mapping_fun(subj,obj,mapping)
% mapping_fun.m Calculates the mapping function applied to objective scores
% 
%   input:
%     subj          subjective scores          
%      obj          objective scores
%  mapping          type of mapping
% 
%   output:
%    obj_map        mapped objective scores     


% type of mapping
if mapping ==2
    vParams=[0.05 0.05];
    [rmse_out]=map_firstorder_func(vParams,obj,subj);
    map_fun='map_firstorder_func';
elseif mapping ==3
    vParams=[0.05 0.05 0.05 0.05];
    [rmse_out]=map_thirdorder_func(vParams,obj,subj);
    map_fun='map_thirdorder_func';
end

% optimization procedure
options= optimset('TolX', 1.e-4, 'TolFun',1.e-4,'MaxFunEvals', 1500, 'MaxIter', 500);
[vParams,fval_a,exitflag_a,output_a]= fminsearch(map_fun,vParams,options,obj,subj);

% mapping function with optimized parameters is applied to objective scores
obj_opt=map_obj_func(obj,vParams,mapping);

end



function [obj_opt] = map_obj_func(obj,vParams,mapping);

if mapping ==2
reg1=ones(size(obj)).*vParams(2);
reg2=obj.*vParams(1);
obj_opt=reg1+reg2;

elseif mapping ==3
reg1=ones(size(obj)).*vParams(4);
reg2=obj.*vParams(3);
reg3=(obj.^2).*vParams(2);
reg4=(obj.^3).*vParams(1);
obj_opt=reg1+reg2+reg3+reg4;

else
error ('No valid mapping selected')    
end

end





