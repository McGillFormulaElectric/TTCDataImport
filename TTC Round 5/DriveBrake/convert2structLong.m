function [] = convert2structLong( runNameFormat, runNumbers )
% Take raw data from TTC and save all variables from each run in a
% structure

% inputs
% runNameFormat='B1464run';
% runNumbers=28:58;


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