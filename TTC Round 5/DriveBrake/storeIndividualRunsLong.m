function [] = storeIndividualRunsLong( round5RunGuide )

sweepNameFormat='r';

for kk=1:length(round5RunGuide)
    
    % load desired test file
    str=sprintf('%s%i.mat',sweepNameFormat,round5RunGuide(kk).RunNumber);
    load(str);
    R = r ;
    
    fNames = fieldnames( R ) ;
    
    % get sweep info
    [P,FZ,IA ] = getRunInfoMetric( r ) ;
    
    for j = 1 : length( P ) 
        
        r = [] ;
        
        for i = 1 : length( fNames ) 
            
            if ~isempty( strfind( fNames{i}, [num2str(P(j)),'kPa'] ) )
                r.(fNames{i}) = R.(fNames{i}) ;
            end
            
        end
        
        % add run information
        if isfield(R,'testid')
            r.testid = R.testid;
        end
        if isfield(R,'tireid')
            r.tireid = R.tireid;
        end
        %% save data
        saveName = sprintf('Individual Runs\\%s_%s_%dx%d_%dkPa_run%d_',...
            round5RunGuide(kk).Manufacturer, round5RunGuide(kk).Compound, ...
            round5RunGuide(kk).RimWidth, round5RunGuide(kk).RimDiameter, ...
            P(j), round5RunGuide(kk).RunNumber) ;
        
        save(saveName,'r')
        
        
        
    end
    
end

end