function [flag] = oel1_dyd(fileID,n,name,kv,id,Ifdset,Ifdmax,Tpickup,...
    Runback,Tmax,Tset,Ifcont,Vfdflag,Alarm)
%oel1_dyd This function will write the PSLF oel1 model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% Ifdset 0.0 Pickup level of time dependent excitation limit, per unit
% Ifdmax 0.0 Level of hard excitation limit, per unit
% Tpickup 0.0 Timer setting for time dependent limit
% Runback 0.0 Parameter of voltage regulator reference adjustment
% Tmax 0.0 Definite time delay for generator trip if field current exceeds
% Ifdmax
% Tset 0.0 Definite time delay for generator trip if field current exceeds
% Ifdset
% Ifcont 0.0 Maximum continuous field current, per unit
% Vfdflag 0.0 0 for field current 1 for field voltage
% Alarm 0.0 If greater than zero, no limiting action is enforced; a message is printed when limit is exceeded. See Note l.
flag=1;
fprintf(fileID,'oel1     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,Ifdset,Ifdmax,Tpickup,Runback,Tmax,Tset,Ifcont,Vfdflag,Alarm);
flag=0;
end