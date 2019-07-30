function [data] = PowerWorld_WriteDYD_Run_RealPMU(filenamedyd,genrou,exac8b,pss2a,SimAuto,filename_RunAux,filename_PlayInCase)
%PowerWorld_WriteDYD This function uses a series of other functions to write a
%PSLF dyd file which is later used by a PowerWorld simulation which is ran by
%using the SimAuto Add-on. An aux file is written to 

%% Open dyd File
fileID=fopen(filenamedyd,'w+');    %Open/create file for reading and writing.
%Discards previous contents.

%% Call Functions to Add Models to dyd File
fprintf(fileID,'models\n');

genrou_dyd(fileID,'47740','CENTR G1','20.00','1','mva=870.0',num2str(genrou(1),10),num2str(genrou(2),10),num2str(genrou(3),10),num2str(genrou(4),10),num2str(genrou(5),10),num2str(genrou(6),10),num2str(genrou(7),10),num2str(genrou(8),10),num2str(genrou(9),10),num2str(genrou(10),10),num2str(genrou(11),10),num2str(genrou(12),10),num2str(genrou(13),10),num2str(genrou(14),10),num2str(genrou(15),10),num2str(genrou(16),10),num2str(genrou(17),10));
exac8b_dyd(fileID,'47740','CENTR G1','20.00','1',num2str(exac8b(1),10),num2str(exac8b(2),10),num2str(exac8b(3),10),num2str(exac8b(4),10),num2str(exac8b(5),10),num2str(exac8b(6),10),num2str(exac8b(7),10),num2str(exac8b(8),10),num2str(exac8b(9),10),num2str(exac8b(10),10),num2str(exac8b(11),10),num2str(exac8b(12),10),num2str(exac8b(13),10),num2str(exac8b(14),10),num2str(exac8b(15),10),num2str(exac8b(16),10),num2str(exac8b(17),10),num2str(exac8b(18),10));
pss2a_dyd(fileID,'47740','CENTR G1','20.00','1',num2str(pss2a(1),10),num2str(pss2a(2),10),num2str(pss2a(3),10),num2str(pss2a(4),10),num2str(pss2a(5),10),num2str(pss2a(6),10),num2str(pss2a(7),10),num2str(pss2a(8),10),num2str(pss2a(9),10),num2str(pss2a(10),10),num2str(pss2a(11),10),num2str(pss2a(12),10),num2str(pss2a(13),10),num2str(pss2a(14),10),num2str(pss2a(15),10),num2str(pss2a(16),10),num2str(pss2a(17),10),num2str(pss2a(18),10),num2str(pss2a(19),10),num2str(pss2a(20),10),num2str(pss2a(21),10),num2str(pss2a(22),10),num2str(pss2a(23),10),num2str(pss2a(24),10),num2str(pss2a(25),10),num2str(pss2a(26),10),num2str(pss2a(27),10));

fclose(fileID);     %Closes file.


%% Run Simulation

%% Process Aux File to Load and Run Simulation
%Setup Aux File to Run Simulation
fileID = fopen(filename_RunAux,'w');
fprintf(fileID,['SCRIPT LoadDYD_RunPlayIn\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['//Load Case\n']);

fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);
fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);

fprintf(fileID,['//Load Dyd File\n']);
fprintf(fileID,['TSLoadGE("CENTRG1_PlayIn.dyd", NO, YES);\n']);


fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);

% fprintf(fileID,['//AutoCorrect\n']);
% fprintf(fileID,['TSAutoCorrect;\n']);
% 'Auto Correct On'

fprintf(fileID,['//Solve Dynamic Simulation\n']);
fprintf(fileID,['TSSolveAll;\n']);

fprintf(fileID,['}\n\n']);
fclose(fileID);

 
% Make the processAuxFile call
simOutput = SimAuto.ProcessAuxFile(filename_RunAux);

%% Load Results into Matlab via TSGetContingencyResults
% Here we get the results for all of the angles directly into Matlab via SimAuto
%%
newCtgName = 'My Transient Contingency';
objFieldList = {'"Plot ''PlayInData''"' };
simOutput = SimAuto.TSGetContingencyResults(newCtgName, objFieldList , '0.0', '20.0');
if ~(strcmp(simOutput{1},''))
disp(simOutput{1})
else
% disp('GetTSResultsInSimAuto successful')
 
%Get the results
data.Data = simOutput{3};
 
%Get the header variables to use for plot labels
data.Header = simOutput{2};

% Convert a matrix of strings into a matrix of numbers and plot them
data.Data = str2double(data.Data);
end



end

