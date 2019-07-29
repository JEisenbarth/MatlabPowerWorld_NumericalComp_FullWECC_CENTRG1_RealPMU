function [flag] = tgov1_dyd(fileID,n,name,kv,id,mva,R,T1,Vmax,Vmin,T2,T3,Dt)
%tgov1_dyd This function will write the PSLF tgov1 model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
%   R       0.05    Permanent droop, p.u.
%   T1      0.5     Steam bowl time constant, sec
%   Vmax    1.0     Maximum valve position, p.u. of mwcap
%   Vmin    0.0     Minimum valve position, p.u. of mwcap
%   T2      3.0     Numerator time constant of T2, T3 block, sec.
%    T3     10.0    Reheater time constant, sec.
%    Dt     0.0     Turbine damping coefficient, p.u.
flag=1;
fprintf(fileID,'tgov1     %s "%s" %s "%s" : #9 %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,mva,R,T1,Vmax,Vmin,T2,T3,Dt);
flag=0;
end