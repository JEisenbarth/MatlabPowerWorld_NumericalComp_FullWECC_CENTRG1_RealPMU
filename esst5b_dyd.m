function [flag] = esst5b_dyd(fileID,n,name,kv,id,Tr,Kr,T1,Kc,Vrmax,Vrmin,...
    Tc1,Tb1,Tc2,Tb2,Toc1,Tob1,Toc2,Tob2,Tuc1,Tub1,Tuc2,Tub2)
%esst5b_dyd This function will write the PSLF esst5b model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% Tr 0.0 Filter time constant, sec.
% Kr 200 Regulator gain, p.u. (> 0.)
% T1 0.004 Firing circuit time constant, sec.
% Kc 0.004 Rectifier regulation factor, p.u.
% Vrmax 5.0 Maximum regulator output, p.u.
% Vrmin -4.0 Minimum regulator output, p.u.
% Tc1 0.8 Regulator lead time constant, sec.
% Tb1 6.0 Regulator lag time constant, sec.
% Tc2 0.08 Regulator lead time constant, sec.
% Tb2 0.01 Regulator lag time constant, sec.
% Toc1 0.1 OEL lead time constant, sec.
% Tob1 2.0 OEL lag time constant, sec.
% Toc2 0.08 OEL lead time constant, sec.
% Tob2 0.08 OEL lag time constant, sec.
% Tuc1 2.0 UEL lead time constant, sec.
% Tub1 10.0 UEL lag time constant, sec.
% Tuc2 0.1 UEL lead time constant, sec.
% Tub2 0.05 UEL lag time constant, sec.
flag=1;
fprintf(fileID,'esst5b     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,Tr,Kr,T1,Kc,Vrmax,Vrmin,Tc1,Tb1,Tc2,Tb2,Toc1,Tob1,Toc2,Tob2,Tuc1,Tub1,Tuc2,Tub2);
flag=0;
end
