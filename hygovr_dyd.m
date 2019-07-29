function [flag] = hygovr_dyd(fileID,n,name,kv,id,mva,Pmax,Pmin,R,Td,T1,...
    T2,T3,T4,T5,T6,T7,T8,Tp,Velop,Velcl,Ki,Kg,gmax,gmin,Tt,db1,eps,db2,...
    Tw,At,Dturb,qnl,H0,Gv1,Pgv1,Gv2,Pgv2,Gv3,Pgv3,Gv4,Pgv4,Gv5,Pgv5,Gv6,Pgv6)
%hygovr_dyd This function will write the PSLF hygovr model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% Pmax 1.0 Maximum gate opening, p.u. of mwcap
% Pmin 0.0 Minimum gate opening, p.u. of mwcap
% R 0.05 Steady-state droop, p.u.
% Td 0.05 Input filter time constant, sec.
% T1 1.5 Lead time constant 1, sec.
% T2 0.1 Lag time constant 1, sec.
% T3 1.5 Lead time constant 2, sec.
% T4 0.1 Lag time constant 2, sec.
% T5 0.0 Lead time constant 3, sec.
% T6 0.05 Lag time constant 3, sec.
% T7 0.0 Lead time constant 4, sec.
% T8 0.05 Lag time constant 4, sec.
% Tp 0.05 Gate servo time constant, sec.
% Velop 0.2 Maximum gate opening velocity, p.u./sec
% Velcl -0.2 Maximum gate closing velocity, p.u./sec (< 0.)
% Ki 0.5 Integral gain, p.u.
% Kg 2.0 Gate servo gain, p.u.
% gmax 1.05 Maximum governor output, p.u.
% gmin -0.05 Minimum governor output, p.u.
% Tt 0.0 Power feedback time constant, sec.
% db1 0.0 Intentional dead-band width, Hz.
% eps 0.0 Intentional db hysteresis, Hz.
% db2 0.0 Unintentional dead-band, MW
% Tw 1.0 Water inertia time constant, sec.
% At 1.2 Turbine gain, p.u.
% Dturb 0.2 Turbine damping factor, p.u.
% qnl 0.08 No-load turbine flow at nominal head, p.u.
% H0 1.0 Turbine nominal head, p.u.
% Gv1 -1.0 Nonlinear gain point 1, p.u. gv
% Pgv1 0.0 Nonlinear gain point 1, p.u. power
% Gv2 0.0 Nonlinear gain point 2, p.u. gv
% Pgv2 0.0 Nonlinear gain point 2, p.u. power
% Gv3 0.0 Nonlinear gain point 3, p.u. gv
% Pgv3 0.0 Nonlinear gain point 3, p.u. power
% Gv4 0.0 Nonlinear gain point 4, p.u. gv
% Pgv4 0.0 Nonlinear gain point 4, p.u. power
% Gv5 0.0 Nonlinear gain point 5, p.u. gv
% Pgv5 0.0 Nonlinear gain point 5, p.u. power
% Gv6 0.0 Nonlinear gain point 6, p.u. gv
% Pgv6 0.0 Nonlinear gain point 6, p.u. power
flag=1;
fprintf(fileID,'hygovr     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',...
    n,name,kv,id,mva,Pmax,Pmin,R,Td,T1,T2,T3,T4,T5,T6,T7,T8,Tp,Velop,...
    Velcl,Ki,Kg,gmax,gmin,Tt,db1,eps,db2,Tw,At,Dturb,qnl,H0,Gv1,Pgv1,...
    Gv2,Pgv2,Gv3,Pgv3,Gv4,Pgv4,Gv5,Pgv5,Gv6,Pgv6);
flag=0;
end