function [] = WritePlayInAux(filename,t1,v1,f1)
%WritePlayInAux This funciton will be used to write play in data to an .aux
%file so it can be used by the PlayIn Gen model within PowerWorld.
%   Detailed explanation goes here

fileID = fopen(filename,'w');
fprintf(fileID,['DATA (PlayIn, [TSName,             TSTimeOffSet], AUXDEF, YES)\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['"PlayInData" 0.0\n']);
fprintf(fileID,['}\n\n']);

fprintf(fileID,['DATA (PlayInInfo, [TSName,            TSSignalIndex, TSInfoName,       TSScale, TSFilter], AUXDEF, YES)\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['"PlayInData" 0              "V pu"            1				0.0\n']);
fprintf(fileID,['"PlayInData" 1              "Frequency pu"    1				0.0\n']);
fprintf(fileID,['}\n\n']);

fprintf(fileID,['DATA (PlayInSignal, [TSName,             TSTime,  TSSignal,  TSSignal:1], AUXDEF, YES)\n\n']);
fprintf(fileID,['{\n']);
%         fclose(fileID);

for k=1:length(t1)
    fprintf(fileID,['"PlayInData"    ']);
    fprintf(fileID,'%4.8f    ',t1(k));
    fprintf(fileID,'%4.15f    ',v1(k));
    fprintf(fileID,'%4.15f\n',f1(k));  
end
fprintf(fileID,['}\n\n']);
fclose(fileID);
end

