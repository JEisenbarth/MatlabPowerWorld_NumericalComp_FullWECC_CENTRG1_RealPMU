function [EventData] = TrimEventData(EventData,texpected)
%TrimEventData This function will get rid of the extra points created while
%running a PowerWorld contingency in a large system. During the PowerWorld
%simulation, events such as dropping a line, opening a load, etc will
%create an extra time point to be added to the simulation. The non uniform
%time vector will created added difficulties when taking the derivative and
%add interpolation during the PlayIn.

%% First Get Rid of the Second Repeated Point in the Event Data Matrix
ndxdelete=[];
for k=1:size(EventData,1)-1
    if(EventData(k,1)==EventData(k+1,1))
        ndxdelete=[ndxdelete,k+1];
    end
end
EventData([ndxdelete],:)=[];

%% Get Rid of Points Not on the Expected Time Vector
ndxkeep=zeros(size(EventData,1),1);
for k=1:size(EventData,1)
    for x=1:length(texpected)
        if(abs(EventData(k,1)-texpected(x))<0.0000001)
            ndxkeep(k)=1;
            break;
        end
    end
end
EventData(~[ndxkeep],:)=[];
end
