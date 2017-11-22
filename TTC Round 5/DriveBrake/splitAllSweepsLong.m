function [] = splitAllSweepsLong( sweepNameFormat, sweepNumbers )


% note: runs not included are spring rate sweeps. run 32 and run 33 must be
% concatenated as that run was split into 2 files
% sweepNumbers= [ 29,30,33,34,36,37,39,40  , 42,43,45,46,48,49,51,52 ];
for kk=1:length(sweepNumbers)
    clear r
    % load desired test file
    str=sprintf('%s%i.mat',sweepNameFormat,sweepNumbers(kk));
    load(str);
    
    %% split data into each individual sweep
    fNames = fieldnames(Run) ;
    ind = logical( strcmp(fNames,'testid') + strcmp(fNames,'tireid') );
    fNames(ind) = [];
    
    % remove sweeps identified as containing poor quality data
    if sweepNumbers(kk) == 30
        ind = logical( (Run.ET > 462) .* (Run.ET < 474) + (Run.ET > 693) .* (Run.ET < 725) );
        for j = 1:length(fNames)
            Run.(fNames{j})(ind) = [];
        end
    elseif sweepNumbers(kk) == 34 || sweepNumbers(kk) == 37
        ind = logical( (Run.ET > 693) .* (Run.ET < 705) );
        for j = 1:length(fNames)
            Run.(fNames{j})(ind) = [];
        end
    end
    
    % concatenate runs 32 and 33
    if sweepNumbers(kk) == 33
        str2 = sprintf('%s%i.mat',sweepNameFormat,sweepNumbers(kk)-1);
        run32 = load(str2);
        Run.ET = Run.ET + max(run32.Run.ET) ;
        for j = 1:length(fNames)
            Run.(fNames{j}) = [run32.Run.(fNames{j}) ; Run.(fNames{j}) ] ;
        end
    end
    
    count = 1;
    i = 1;
    while i < length(Run.ET)-1
        % check if there is a jump in time between data points. this
        % indicates a change of test condition ( FZ, IA, P or SA )
        % whenever a jump occurs, store data as a separate field
        if (Run.ET(i+1) - Run.ET(i)) > 2
            for j = 1:length(fNames)
                str = sprintf('data%i',count) ;
                r.(str).(fNames{j}) = Run.(fNames{j})( 1:i ) ;
                Run.(fNames{j})(1:i) = [];
            end
            i = 1;
            count = count + 1;
        end
        i = i+1 ;
    end
    % when no more jumps are detected store all remaining data (last sweep)
    % as a final field
    for j = 1:length(fNames)
        str = sprintf('data%i',count) ;
        r.(str).(fNames{j}) = Run.(fNames{j})( 1:end ) ;
        Run.(fNames{j})(1:end) = [];
    end
    
    %% get nominal sweep information
    % possible nominal conditions
    FZnom = [223,445,668,890,1113,1558] ;
    IAnom = [0,1,2,3,4];
    Pnom = [ 55, 69, 83, 96 ] ;
    SAnom = [0 3 6 ] ;
    fNames = fieldnames(r);
    figure
    hold on
    title(Run.tireid)
    for i = 1:length(fNames)
        % identify nominal conditions by taking it median value and finding
        % its associated nominal test condition
        FZ = abs(median(r.(fNames{i}).FZ)) ;
        fz = FZnom(min(abs(FZ-FZnom))==abs(FZ-FZnom)) ;
        P = median(r.(fNames{i}).P) ;
        p = Pnom(min(abs(P-Pnom))==abs(P-Pnom)) ;
        IA = median(r.(fNames{i}).IA) ;
        ia = IAnom(min(abs(IA-IAnom))==abs(IA-IAnom)) ;
        SA = abs(median(r.(fNames{i}).SA) ) ;
        sa = SAnom(min(abs(SA-SAnom))==abs(SA-SAnom)) ;
        
        str = sprintf('r_%dkPa_%ddeg_%dN_%ddeg',p,ia,fz,sa);
        r.(str) = r.(fNames{i});
        r = rmfield(r,fNames{i}) ;
        
        %% plot data to ensure correct nominal values are obtained
        plot(r.(str).ET,r.(str).SA./-5,'.b')
        plot(r.(str).ET,repmat(sa/5,length(r.(str).ET),1),'k')
        plot(r.(str).ET,r.(str).IA,'.r')
        plot(r.(str).ET,repmat(ia,length(r.(str).ET),1),'k')
        plot(r.(str).ET,r.(str).FZ./-220,'.y')
        plot(r.(str).ET,repmat(fz/220,length(r.(str).ET),1),'k')
        plot(r.(str).ET,r.(str).P./21,'.m')
        plot(r.(str).ET,repmat(p/21,length(r.(str).ET),1),'k')
    end
    % add run information
    if isfield(Run,'testid')
        r.testid = Run.testid;
    end
    if isfield(Run,'tireid')
        r.tireid = Run.tireid;
    end
    %% save data
    saveName=sprintf('Sweep Data\\r%d',sweepNumbers(kk));
    save(saveName,'r')
end

clear