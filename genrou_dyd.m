function [flag] = genrou_dyd(fileID,n,name,kv,id,mva,Tpdo,Tppdo,Tpqo,Tppqo,...
    H,D,Ld,Lq,Lpd,Lpq,Lppd,Ll,S1,S12,Ra,Rcomp,Xcomp)
%genrou_dyd This function will write the PSLF genrou model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
%   Tpdo	7       D-axis	transient	rotor	time	constant	
%   Tppdo	0.03	D-axis	sub-transient	rotor	time	constant	
%   Tpqo	0.75	Q-axis	transient	rotor	time	constant	
%   Tppqo	0.05	Q-axis	sub-transient	rotor	time	constant	
%   H       3       Inertia	constant,	sec			
%   D       0       Damping	factor,	pu			
%   Ld      2.1     D-axis	synchronous	reactance			
%   Lq      2       Q-axis	synchronous	reactance			
%   Lpd     0.2     D-axis	transient	reactance			
%   Lpq     0.5 	Q-axis	transient	reactance			
%   Lppd	0.18	D-axis	sub-transient	reactance			
%   Ll      0.15	Stator	leakage	reactance,	pu		
%   S1      0.05	Saturation	factor	at	1	pu	flux
%   S12     0.3     Saturation	factor	at	1.2	pu	flux
%   Ra      0       Stator	resistance,	pu			
%   Rcomp	0       Compounding	resistance	for	voltage	control,	pu
%   Xcomp	0       Compounding	reactance	for	voltage	control,	pu

flag=1;
fprintf(fileID,'genrou     %s "%s" %s "%s" : #9 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',...
    n,name,kv,id,mva,Tpdo,Tppdo,Tpqo,Tppqo,H,D,Ld,Lq,Lpd,Lpq,Lppd,Ll,S1,S12,Ra,Rcomp,Xcomp);
flag=0;
end
