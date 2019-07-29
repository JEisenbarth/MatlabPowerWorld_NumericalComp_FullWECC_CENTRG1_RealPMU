function [flag] = gentpj_dyd(fileID,n,name,kv,id,mva,Tpdo,Tppdo,Tpqo,...
    Tppqo,H,D,Ld,Lq,Lpd,Lpq,Lppd,Lppq,Ll,S1,S12,Ra,Rcomp,Xcomp,accel,Kis)
%gentpj_dyd This function will write the PSLF gentpj model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
%   Tpdo        7.0             D-axis transient rotor time constant
%   Tppdo       0.035           D-axis sub-transient rotor time constant
%   Tpqo        0.75            Q-axis transient rotor time constant
%   Tppqo       0.035           Q-axis sub-transient rotor time constant
%   H           3.0             Inertia constant, sec
%   D           0.0             Damping factor, pu
%   Ld          2.1             D-axis synchronous reactance
%   Lq          2.04            Q-axis synchronous reactance
%   Lpd         0.21            D-axis transient reactance
%   Lpq         0.4             Q-axis transient reactance
%   Lppd        0.18            D-axis sub-transient reactance
%   Lppq        0.18            Q-axis sub-transient reactance
%   Ll          0.12            Stator leakage reactance, pu
%   S1          0.05            Saturation factor at 1 pu flux
%   S12         0.4             Saturation factor at 1.2 pu flux
%   Ra          0.0             Stator resistance, pu
%   Rcomp       0.0             Compounding resistance for voltage control, pu
%   Xcomp       0.0             Compounding reactance for voltage control, pu
%   accel       0.5             Acceleration factor for network boundary iter.
flag=1;
fprintf(fileID,'gentpj     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',...
    n,name,kv,id,mva,Tpdo,Tppdo,Tpqo,Tppqo,H,D,Ld,Lq,Lpd,Lpq,Lppd,Lppq,Ll,S1,S12,Ra,Rcomp,Xcomp,accel,Kis);
flag=0;
end
