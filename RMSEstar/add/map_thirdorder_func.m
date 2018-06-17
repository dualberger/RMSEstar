function[rmse_out]=map_thirdorder_func(vParams,obj,subj);
% map_thirdorder_func Calculates the rmse between subjective and
% objective scores mapped onto the third order mapping function
% 2018-02-06, thomas.biberger@uni-ol.de

reg1=ones(size(obj)).*vParams(4);
reg2=obj.*vParams(3);
reg3=(obj.^2).*vParams(2);
reg4=(obj.^3).*vParams(1);
y_opt=reg1+reg2+reg3+reg4;

rmse_out=sqrt(mean((subj-y_opt).^2));
end