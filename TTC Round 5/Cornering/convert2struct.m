function [ ] = convert2struct( runNameFormat, runNumbers )
% load each desired TTC tire data set and store the individual variables in
% a structure
%
% runNameFormat is a string specifying the name format under which tire
% data is saved
% runNumbers is the numbers of desired test runs
%
% example: TTC data stored in files B1464run1, B1464run2, B1464run3
% runNameFormat = 'B1464run', runNumbers = 1:3

% inputs
% runNameFormat='B1464run';
% runNumbers=[3,5:25];


for r=1:length(runNumbers)
    runName=sprintf('%s%d.mat',runNameFormat,runNumbers(r));
    load(runName)
    
    names=who;
    
    for i=1:length(names)
        bannedVars={'runNameFormat','runNumbers','runName','names','saveName','bannedVars','r','i','Run','str'};
        if ~sum(strcmp(bannedVars,names{i}))
            str=names{i};
            Run.(str)=eval(str);
        end
    end
    
    saveName=sprintf('Structure Data\\Brun%d',runNumbers(r));
    save(saveName,'Run')
end

end