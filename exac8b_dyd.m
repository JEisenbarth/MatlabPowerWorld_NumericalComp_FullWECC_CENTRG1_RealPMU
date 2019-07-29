function [flag] = exac8b_dyd(fileID,n,name,kv,id,Tr,Kvp,Kvi,Kvd,Tvd,Vimax,Ta,Vrmax,Vrmin,Ke,Te,Kc,Kd,E1,S_E1,E2,S_E2,limflg)
%exac8b_dyd This function will write the PSLF exac8b model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
% EPCL Default    Variable Data   Description
% Tr      0.02    Voltage transducer time constant, sec.
% Kvp     4.0     Voltage Regulator Proportional Gain (> 0. if Kvi = 0.)
% Kvi     4.0     Voltage Regulator Integral Gain
% Kvd     20.0    Voltage Regulator Derivative Gain
% Tvd     0.05    Voltage Regulator Derivative Time Constant, sec.
% Vimax   0.1     Voltage Regulator Input Limit, p.u.
% Ta      0.02    Voltage Regulator time constant, sec.
% Vrmax   10.0    Maximum controller output, p.u. (note e)
% Vrmin   -10.0   Minimum controller output, p.u. (note e)
% Ke      1.0     Exciter field proportional constant
% Te      0.2     Exciter field time constant, sec. (> 0.)
% Kc      0.1     Rectifier regulation factor, p.u.
% Kd      1.0     Exciter regulation factor, p.u.
% E1      5.0     Field voltage value 1, p.u. (note c)
% S(E1)   0.001   Saturation factor at E1 (note c)
% E2      7.0     Field voltage value 2, p.u. (note c)
% S(E2)   0.01    Saturation factor at E2 (note c)
% limflg  0.0     Limit flag (note e)

flag=1;
fprintf(fileID,'exac8b     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,Tr,Kvp,Kvi,Kvd,Tvd,Vimax,Ta,Vrmax,Vrmin,Ke,Te,Kc,Kd,E1,S_E1,E2,S_E2,limflg);
flag=0;


end

