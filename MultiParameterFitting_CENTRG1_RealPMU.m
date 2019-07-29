% Jacob Eisenbarth, July 2019
% This script will be used to run multiple different PowerWorld cases within
% Matlab. First, the script writes a  .dyd file from Matlab using a
% series of functions. NEED to finish Description.....

%% Initialize Matlab
clc,close all,clear all, format longG,format compact

tic

%% Establish a connection with PowerWorld / SimAuto
disp('>> Connecting to PowerWorld Simulator / SimAuto...')
SimAuto = actxserver('pwrworld.SimulatorAuto');
disp('Connection established')

%% Data to be Entered into dyd File
%Model genrou
genrou(1)=5.8; %Tpdo
% genrou(2)=0.015; %Tppdo
genrou(2)=0.016; %Tppdo
genrou(3)=0.6; %Tpqo
genrou(4)=0.03; %Tppqo
genrou(5)=3.25; %H
genrou(6)=0; %D
genrou(7)=2.05; %Ld
genrou(8)=1.95; %Lq
genrou(9)=0.42; %Lpd
genrou(10)=0.65; %Lpq
genrou(11)=0.24; %Lppd
genrou(12)=0.12; %Ll
genrou(13)=0.125; %S1
genrou(14)=0.33; %S12
genrou(15)=0.0019; %Ra
genrou(16)=0; %Rcomp
genrou(17)=0.063; %Xcomp

index_genrou=[1:5,7:15,17];     %Index for numerical parameters to edit

%Model exac8b
exac8b(1)=0.02; %Tr
exac8b(2)=200; %Kvp
exac8b(3)=0; %Kvi
exac8b(4)=60; %Kvd
exac8b(5)=0.02; %Tvd
exac8b(6)=999; %Vimax
exac8b(7)=0.02; %Ta
exac8b(8)=10; %Vrmax
exac8b(9)=-10; %Vrmin
exac8b(10)=1; %Ke
exac8b(11)=1.5; %Te
exac8b(12)=0.15; %Kc
exac8b(13)=0.45; %Kd
exac8b(14)=6.5; %E1
exac8b(15)=0.3; %S(E1)
exac8b(16)=9; %E2
exac8b(17)=3; %S(E2)
exac8b(18)=0; %limflg

index_exac8b=[1:2,4:17];     %Index for numerical parameters to edit

%Model pss2a
pss2a(1)=2; %J1
pss2a(2)=0; %K1
pss2a(3)=3; %J2
pss2a(4)=0; %K2
pss2a(5)=15; %Tw1
pss2a(6)=5; %Tw2
pss2a(7)=15; %Tw3
pss2a(8)=1; %Tw4
pss2a(9)=1; %T6
pss2a(10)=5; %T7
pss2a(11)=0.3077; %Ks2
pss2a(12)=1; %Ks3
pss2a(13)=1; %Ks4
pss2a(14)=0.4; %T8
pss2a(15)=1; %T9
pss2a(16)=1; %n
pss2a(17)=1; %m
pss2a(18)=2; %Ks1
pss2a(19)=0.4; %T1
pss2a(20)=0.2; %T2
pss2a(21)=0.4; %T3
pss2a(22)=0.2; %T4
pss2a(23)=0.05; %Vstmax
pss2a(24)=-0.05; %Vstmin
pss2a(25)=1; %a
pss2a(26)=0.4; %Ta
pss2a(27)=0.2; %Tb

index_pss2a=[5:15,18:27];     %Index for numerical parameters to edit

genrou_original=genrou;
exac8b_original=exac8b;
pss2a_original=pss2a;


index=struct('genrou',index_genrou,'exac8b',index_exac8b,'pss2a',index_pss2a);

clear index_genrou index_exac8b index_oel1 index_pss2a index_hygovr

%% Parameter List to be Ran in Single Parameter Fitting
% list=[ones(length(index.genrou),1),[1:length(index.genrou)]';...
%     2*ones(length(index.exac8b),1),[1:length(index.exac8b)]';...
%     3*ones(length(index.pss2a),1),[1:length(index.pss2a)]';];

%Setup Lower Bound Vector for Timeconstants >4*Timestep
% lb=-Inf*ones(size(list,1),1);
% lb([1:4,16,19,21,25,32:37,41:42,44:47,51:52])=0.016;




%% Setup PlayIn PowerWorld Case for PMU Data
%Load datacsv
load(['D:\Users\JEisenbarth\Desktop\PowerWorld Files\CENTRG1 Real PMU Data\CENTRG1_CSV_Event_5100to5120.mat']);

%File Names to Be Used In Script
filename_SetupAux=[pwd,'\SetupAux.aux'];
filename_PlayInCase='CENTRG1_PlayIn_RealPMU.PWB';
filename_DataAux=[pwd,'\PlayInData.aux'];
filenamedyd=[pwd,'\CENTRG1_PlayIn.dyd'];
filename_RunAux = [pwd,'\LoadDYD_RunPlayIn_RealPMU.aux'];
filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\CENTRG1 Real PMU Data\FinalTheta_CENTRG1_PowerWorld_RealPMU_5100to5120_notgenrou.mat'];

%Setup PowerWorld Case Based on Starting Point for Real PMU Data
Ppmu=datacsv.P(1);
Qpmu=datacsv.Q(1);
Vpmu=datacsv.v1(1);
SetupCase_CENTRG1(filename_SetupAux,filename_PlayInCase,Ppmu,Qpmu,Vpmu,SimAuto)

list=1;
for k=1:size(list,1)
    numericalsims=1;
    for x=1:numericalsims
        
        %% Write Data Aux File for Centralia Event PlayIn
        datacsv.t1=datacsv.t1-datacsv.t1(1);
        t1=datacsv.t1;
        v1=datacsv.v1;
        f1=datacsv.f1;
        
        %%ADD Filtered Measurement Noise to V and F
        noisemultiplier=0;
        vnom=0.001;
        fnom=.25;
        vmeasnoise=vnom*noisemultiplier*randn(length(v1),1);
        fmeasnoise=fnom*noisemultiplier*randn(length(f1),1);
        
        [b,a]=butter(3,.05);
        
        vmeasnoise=filter(b,a,vmeasnoise);
        fmeasnoise=filter(b,a,fmeasnoise);
        
        v1=v1+vmeasnoise;
        f1=f1+fmeasnoise;
        
        WritePlayInAux(filename_DataAux,t1,v1,f1/60)
        %         data_PlayInAux(k,x).t1=t1;
        %         data_PlayInAux(k,x).v1=v1;
        %         data_PlayInAux(k,x).f1=f1;
        
        
        %                 %%Filter Plot Check
        %                 figure
        %                 subplot(2,1,1)
        %                 plot(t1,v1,t1,v1-vmeasnoise)
        %                 legend('Added Measurement Noise','Original')
        %                 title('CENTR G1 Event 3: Voltage')
        %                 grid
        %                 xlim([0,20])
        %
        %
        %                 subplot(2,1,2)
        %                 plot(t1,(f1),t1,f1-fmeasnoise)
        %
        %                 legend('Added Measurement Noise','Original')
        %                 title('CENTR G1 Event 3: Frequency')
        %                 grid
        %                 xlim([0,20])
        %
        
        %% Setup to Run to Minimize Cost Function
        %Setup Column Vector of Parameter to Adjust
        theta_indicies=[ones(length(index.genrou),1),[1:length(index.genrou)]';...
            2*ones(length(index.exac8b),1),[1:length(index.exac8b)]';...
            3*ones(length(index.pss2a),1),[1:length(index.pss2a)]';];
        
        theta_indicies=theta_indicies([1,2,39,40,51],:);
        
        %         theta_indicies=list(k,:);
        
        %             theta_indicies=[1,4;1,5];    %1st column is model,2nd column is numerical parameter,3rd column is what residual vector to use 1=P 2=Q 3=P&Q
        %Ex. [1,5]->model=genrou, parameter=H, P for
        % residual calculations.
        %Ex. [2,2]->model=exac8b, parameter=Kr, Q for
        % residual calculations.
        
        %Setup theta Vectors
        theta=zeros(size(theta_indicies,1),1);
        for b=1:length(theta)
            if theta_indicies(b,1)==1
                theta(b)= genrou_original(index.genrou(theta_indicies(b,2)));
            elseif theta_indicies(b,1)==2
                theta(b)= exac8b_original(index.exac8b(theta_indicies(b,2)));
            elseif theta_indicies(b,1)==3
                theta(b)= pss2a_original(index.pss2a(theta_indicies(b,2)));
            end
        end
        
        percentnominal=abs(.01*theta);
        
        %% Run Simulation w Original theta in model
        % Run Original Simulation w/ Nominal dyd file.
        [data_orig(:,x)] = PowerWorld_WriteDYD_Run_RealPMU(filenamedyd,genrou_original,exac8b_original,pss2a_original,SimAuto,filename_RunAux,filename_PlayInCase);
        
        %% Run Minimizing Cost Function
        PQ_Flag=2; %When PQ_Flag is 2 then that means to use P and Q for residual calculations.
        
        %opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-12,'MaxFunEvals',50000,'SpecifyObjectiveGradient',true);
        opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-12,'MaxFunEvals',50000,'SpecifyObjectiveGradient',true);
        %opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-12,'MaxFunEvals',0,'MaxIterations',0,'SpecifyObjectiveGradient',true);
        
        residual = @(theta) residual_Jacobian_PowerWorld_RealPMU(theta,theta_indicies,index,datacsv,filenamedyd,genrou_original,exac8b_original,pss2a_original,PQ_Flag,SimAuto,percentnominal,filename_RunAux,filename_PlayInCase);
        
        [final_theta(:,x),resnorm(:,x),residual,exitflag,output(:,x),lambda,Jacobian] = lsqnonlin(residual,theta,[],[],opts);
        
        x
        
        %% Run Simulation with newly found theta
        %Put thetas into model
        for m=1:size(theta_indicies,1)
            if theta_indicies(m,1)==1
                genrou(index.genrou(theta_indicies(m,2)))=final_theta(m);
            elseif theta_indicies(m,1)==2
                exac8b(index.exac8b(theta_indicies(m,2)))=final_theta(m);
            elseif theta_indicies(m,1)==3
                pss2a(index.pss2a(theta_indicies(m,2)))=final_theta(m);
            end
        end
        %Run Simulation w final theta in model
        [data(k,x)] = PowerWorld_WriteDYD_Run_RealPMU(filenamedyd,genrou_original,exac8b_original,pss2a_original,SimAuto,filename_RunAux,filename_PlayInCase);
        
        %Set Models to Original
        genrou=genrou_original;
        exac8b=exac8b_original;
        pss2a=pss2a_original;
        
        
        toc
    end
    %% Save Fitting Data
    %save(filename_SaveLocation,'final_theta','resnorm','output','list')
    %save(filename_SaveLocation,'final_theta','resnorm','output','list','data')
end
