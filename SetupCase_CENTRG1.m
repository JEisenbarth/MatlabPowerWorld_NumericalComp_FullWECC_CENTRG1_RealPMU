function [] = SetupCase_CENTRG1(filename_SetupAux,filename_PlayInCase,Ppmu,Qpmu,Vpmu,SimAuto)
%SetupCase_CENTRG1 This funciton will be used to write and run an Aux file
% to setup a case file from PMU Data. It takes the PMU voltage at the
% PlayIn bus then performs a calcuation to find the voltage and power at
% the generator bus so that the P,Q, and V measurements for the PMU match
% match the setup case.

%% Calculate Vm and Pm for Bus with CENTRG1 Generator
%Known Quantities
Sbase=100e6;
Z=(.0004+1i*.024309);   %PU
S=Ppmu*1e6+1i*Qpmu*1e6;               %MVA
S=S/Sbase;              %PU
XfmrTap=1.05;           %Ratio

%Calculate Vm and Pm
I=conj(S/Vpmu);                   %PU
Vm=-I*Z*XfmrTap+Vpmu/XfmrTap; %Solve Vm then plug in for I.
Pm=-real(Vm*conj(I))*XfmrTap*Sbase/1e6;

fileID = fopen(filename_SetupAux,'w');
fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Load Case\n']);

fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);
% fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Voltage for PlayIn Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['47741 "CENTR P1" 1 ',num2str(Vpmu,6),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Bus Voltage and Angle for PlayIn Bus\n']);
fprintf(fileID,['DATA (Bus, [BusNum,BusName,BusPUVolt,BusAngle])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['47741 "CENTR P1" ',num2str(Vpmu,12),' 0\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Real Power and Voltage for Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet,GenMW])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['47740 "CENTR G1" 1 ',num2str(abs(Vm),12),' ',num2str(Pm,12),'\n']);
fprintf(fileID,['}\n\n']);

fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);
% fprintf(fileID,['//Solve Power Flow\n']);
fprintf(fileID,['SolvePowerFlow (RECTNEWT,"","");\n']);
fprintf(fileID,['SaveCase("%s");\n'],filename_PlayInCase);
fprintf(fileID,['}\n\n']);
fclose(fileID);

%% Process Aux File to Load and Run Simulation
% Make the processAuxFile call
simOutput = SimAuto.ProcessAuxFile(filename_SetupAux);

end

