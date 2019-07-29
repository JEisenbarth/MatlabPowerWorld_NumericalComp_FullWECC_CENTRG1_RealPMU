function [residual,J] = residual_Jacobian_PowerWorld_RealPMU(theta,theta_indicies,index,data_event,filenamedyd,genrou,exac8b,pss2a,PQ_Flag,SimAuto,percentnominal,filename_RunAux,filename_PlayInCase)
%residual_Jacobian_PowerWorld This function calculates the P, Q, or PQ residual based on a given theta.
%   PQ_Flag=0 then use P Residual
%   PQ_Flag=1 then use Q Residual
%   PQ_Flag=2 then use PQ Residual


%% Get nominal thetas for later Jacobian calculations
theta_nominal=zeros(size(theta));
for m=1:length(theta)
    if theta_indicies(m,1)==1
        theta_nominal(m)=genrou(index.genrou(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==2
        theta_nominal(m)=exac8b(index.exac8b(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==3
        theta_nominal(m)=pss2a(index.pss2a(theta_indicies(m,2)));
    end
end
delta=percentnominal;

%% Put thetas into model for original residual calc.
for m=1:length(theta)
    if theta_indicies(m,1)==1
        genrou(index.genrou(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==2
        exac8b(index.exac8b(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==3
        pss2a(index.pss2a(theta_indicies(m,2)))=theta(m);
        
    end
end
theta
%% Write dyd and run simulation
[data]=PowerWorld_WriteDYD_Run_RealPMU(filenamedyd,genrou,exac8b,pss2a,SimAuto,filename_RunAux,filename_PlayInCase);

%% Down sample from pslf defoult Ts to 1/60 sec like pmu data
ndxkeep=[1:5:length(data.Data)];
data.Data=data.Data([ndxkeep],:);

%% Find indicies for residual calculations then calc residual.
ndxP=PWFind(data,'Branch ',' 47741 47740 1 ','MW From');
ndxQ=PWFind(data,'Branch ',' 47741 47740 1 ','Mvar From');

%% Calculate residual based on PQ_Flag.
if(PQ_Flag==0)
    residual=data_event.P-data.Data(:,ndxP);
elseif(PQ_Flag==1)
    residual=data_event.Q-data.Data(:,ndxQ);
elseif(PQ_Flag==2)
    residual=[data_event.P;data_event.Q]-[data.Data(:,ndxP);data.Data(:,ndxQ);];
end

%% Calculate Residual for Jacobian Calculations.
for x=1:length(theta)
    %% Put thetas into model so can change a single parameter for Jacobian Calculations.
    for m=1:length(theta)
        if theta_indicies(m,1)==1
            genrou(index.genrou(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==2
            exac8b(index.exac8b(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==3
            pss2a(index.pss2a(theta_indicies(m,2)))=theta(m);
        end
    end
    
    %% Change only one parameter by delta based on k for loop
    if theta_indicies(x,1)==1
        genrou(index.genrou(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==2
        exac8b(index.exac8b(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==3
        pss2a(index.pss2a(theta_indicies(x,2)))=theta(x)+delta(x);
    end
    
    %% Write dyd and run simulation for residual for Jacobian calc.
    [data_Jacobian]=PowerWorld_WriteDYD_Run_RealPMU(filenamedyd,genrou,exac8b,pss2a,SimAuto,filename_RunAux,filename_PlayInCase);
    
    %% Down sample from pslf defoult Ts to 1/60 sec like pmu data
    ndxkeep=[1:5:length(data_Jacobian.Data)];
    data_Jacobian.Data=data_Jacobian.Data([ndxkeep],:);
    
    %% Find indicies for residual calculations then calc residual.
    ndxP=PWFind(data_Jacobian,'Branch ',' 47741 47740 1 ','MW From');
    ndxQ=PWFind(data_Jacobian,'Branch ',' 47741 47740 1 ','Mvar From');
    
    %% Calculate residual based on PQ_Flag.
    if(PQ_Flag==0)
        r(:,x)=data_event.P-data_Jacobian.Data(:,ndxP);
    elseif(PQ_Flag==1)
        r(:,x)=data_event.Q-data_Jacobian.Data(:,ndxQ);
    elseif(PQ_Flag==2)
        r(:,x)=[data_event.P;data_event.Q]-[data_Jacobian.Data(:,ndxP);data_Jacobian.Data(:,ndxQ);];
    end
    
    J(:,x)=(r(:,x)-residual)/delta(x);
end

%% Plot Check
figure
subplot(3,1,1)
hold on
plot(data_event.t1,data_event.P,'LineWidth',1,'DisplayName','Event')
plot(data.Data(:,1),data.Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn')
hold off
title('P Plot')
legend();
grid

subplot(3,1,2)
hold on
plot(data_event.t1,data_event.Q,'LineWidth',1,'DisplayName','Event')
plot(data.Data(:,1),data.Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn')
hold off
title('Q Plot')
legend();
grid

subplot(3,1,3)
hold on
plot(residual,'DisplayName',['Parameter=',num2str(theta)])
plot(residual,'DisplayName',['Parameter='])
hold off
title('Residual')
legend();

ndxV=PWFind(data,'Bus ',' 47741 ','V pu');
figure
subplot(3,1,1)
hold on
plot(data_event.t1,data_event.v1,'LineWidth',1,'DisplayName','Event')
plot(data.Data(:,1),data.Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn')
hold off
title('V Plot')
legend();
grid

ndxF=PWFind(data,'Bus ',' 47741 ','Frequency in PU');
subplot(3,1,2)
hold on
plot(data_event.t1,data_event.f1/60,'LineWidth',1,'DisplayName','Event')
plot(data.Data(:,1),data.Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn')
hold off
title('F Plot')
legend();
grid
% 
% ndxVang=PWFind(data,'Bus ',' 47741 ','V angle No shift');
% subplot(3,1,3)
% hold on
% plot(data_event.t1,data_event.Vang1-data_event.Vang1(1),'LineWidth',1,'DisplayName','Event')
% plot(data.Data(:,1),unwrap((data.Data(:,ndxVang)-data.Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn')
% hold off
% title('Vang Plot')
% legend();
% grid
% 

end