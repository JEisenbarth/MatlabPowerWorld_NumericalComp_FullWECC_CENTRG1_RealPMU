function [ndx] = PWFind(PWstruct,TypeDesired,NumberDesired,MeasurementDesired)
%PWFind Finds the associated index in the header associated with the
%desired field. The ndx is incremented by 1 since the first column of the
%PWstruct.Data is Time.
%   Detailed explanation goes here
%% Find Index of Desired Field
ndx=[];
for k=1:size(PWstruct.Header,1)
    if(strcmp(PWstruct.Header{k,1},TypeDesired))
        if(strcmp(PWstruct.Header{k,2},NumberDesired))
            if(strcmp(PWstruct.Header{k,6},MeasurementDesired))
                ndx=k+1;
            end
        end
    end
end

%% If Field Does Not Exist
if(ndx==[])
    error('Could Not Find Index in PWFind \n');
end
end

