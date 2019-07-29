function [flag] = exst3a_dyd(fileID,n,name,kv,id,Tr,Vimax,Vimin,Kj,Tc,Tb,...
    Ka,Ta,Vrmax,Vrmin,Kg,Kp,Ki,Vbmax,Kc,Xl,Vgmax,Angp)
%exst3a_dyd This function will write the PSLF exst3a model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
%   Tr      0.0     Filter time constant, sec.
%   Vimax   0.2     Maximum error, p.u.
%   Vimin   -0.2    Minimum error, p.u.
%   Kj      200.0   Gain, p.u. (> 0.)
%   Tc      1.0     Lead time constant, sec.
%   Tb      10.0    Lag time constant, sec.
%   Ka      7.24    Gain, p.u. (> 0.)
%   Ta      0.4     Time constant, sec. (> 0.)
%   Vrmax   1.0     Maximum controller output, p.u.
%   Vrmin   0.0     Minimum controller output, p.u.
%   Kg      1.0     Excitation limiter gain, p.u.
%   Kp      5.1     Potential source gain, p.u.
%   Ki      0.0     Current source gain, p.u.
%   Vbmax   6.35    Maximum excitation voltage, p.u.
%   Kc      0.14    Exciter regulation factor, p.u.
%   Xl      0.0     P-bar reactance, p.u.
%   Vgmax   6.25    Maximum excitation voltage
%   Angp    0.0     Phase angle of potential source, degrees
flag=1;
fprintf(fileID,'exst3a     %s "%s" %s "%s" : #9 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,Tr,Vimax,Vimin,Kj,Tc,Tb,Ka,Ta,Vrmax,Vrmin,Kg,Kp,Ki,Vbmax,Kc,Xl,Vgmax,Angp);
flag=0;
end
