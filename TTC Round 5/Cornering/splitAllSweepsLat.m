function [ ] = splitAllSweepsLat( sweepNameFormat, sweepNumbers )

% sweepNameFormat='Brun';

% note: runs not included are spring rate sweeps. run 32 and run 33 must be
% concatenated as that run was split into 2 files
% sweepNumbers = [5,8,9,11,12,14:19,20:25] ;
for kk=1:length(sweepNumbers)
    clear r
    % load desired test file
    str=sprintf('%s%i.mat',sweepNameFormat,sweepNumbers(kk));
    load(str);
    
    %% split data into each individual sweep
    fNames = fieldnames(Run) ;
    ind = logical( strcmp(fNames,'testid') + strcmp(fNames,'tireid') );
    fNames(ind) = [];
    
    count = 1;
    i = 1;
    while i < length(Run.ET)-1
        if (Run.ET(i+1) - Run.ET(i)) > 2
            % check if there is a jump in time between data points. this
            % indicates a change of test condition ( FZ, IA, P or SA )
            % whenever a jump occurs, store data as a separate field
            if max(Run.SA(1:i)) - min(Run.SA(1:i)) > 24  % only keep SA sweeps
                for j = 1:length(fNames)
                    str = sprintf('data%i',count) ;
                    r.(str).(fNames{j}) = Run.(fNames{j})( 1:i ) ;
                end
            end
            for j = 1:length(fNames)
                Run.(fNames{j})(1:i) = [];
            end
            i = 1;
            count = count + 1;
        end
        i = i+1 ;
    end
    
    %% get nominal sweep information
    % possible nominal conditions
    FZnom = [223,445,668,890,1113,1558] ;
    IAnom = [0,1,2,3,4];
    Pnom = [ 55, 69, 83, 96 ] ;
    fNames = fieldnames(r);
    figure
    hold on
    title(Run.tireid)
    for i = 1:length(fNames)
        % identify nominal conditions
        FZ = abs(median(r.(fNames{i}).FZ)) ;
        fz = FZnom(min(abs(FZ-FZnom))==abs(FZ-FZnom));
        P = median(r.(fNames{i}).P) ;
        p = Pnom(min(abs(P-Pnom))==abs(P-Pnom));
        IA = median(r.(fNames{i}).IA) ;
        ia = IAnom(min(abs(IA-IAnom))==abs(IA-IAnom));
        
        str = sprintf('r_%dkPa_%ddeg_%dN',p,ia,fz);
        r.(str) = r.(fNames{i});
        r = rmfield(r,fNames{i}) ;
        
        % plot data to ensure correct nominal values are obtained
        plot(r.(str).ET,r.(str).IA,'.r')
        plot(r.(str).ET,repmat(ia,length(r.(str).ET),1),'k')
        plot(r.(str).ET,r.(str).FZ./-220,'.y')
        plot(r.(str).ET,repmat(fz/220,length(r.(str).ET),1),'k')
        plot(r.(str).ET,r.(str).P./21,'.m')
        plot(r.(str).ET,repmat(p/21,length(r.(str).ET),1),'k')
    end
    if isfield(Run,'testid')
        r.testid = Run.testid;
    end
    if isfield(Run,'tireid')
        r.tireid = Run.tireid;
    end
    
    saveName=sprintf('Sweep Data\\r%d',sweepNumbers(kk));
    save(saveName,'r')
end

end