function [ P,FZ,IA ] = getRunInfoMetric( run )
%for given test run returns pressure, FZs and IAs

P=[];
FZ=[];
IA=[];
% get field names ( of form "r_XXkPA_Xdeg_XXX(X)N" )
strings = fieldnames(run);
for i = 1:length(strings)   % for each entry
    str = strings{i,1};
    if strcmp(str,'testid') || strcmp(str,'tireid') || strcmp(str,'warmup')
        continue
    end
    % remove leading "r_"
    str(1:2) = [];
    % get pressure and remove numbers from str
    P(length(P)+1) = str2double(str(1:2));
    str(1:2)=[];
    % remove "kPa_"
    str(1:4) = [];
    
    % get inclination angle
    IA(length(IA)+1) = str2double(str(1));
    % remove "#deg_"
    str(1:5) = [];
    
    % get vertical load and remove numbers from str
    if isnan(str2double(str(1:4)))
        % if FZ is 3 digits in length
        FZ(length(FZ)+1) = str2double(str(1:3)) ;
        str(1:3)=[];
    else
        % if FZ is 4 digits in length
        FZ(length(FZ)+1) = str2double(str(1:4)) ;
        str(1:4)=[];
    end
    % remove "N"
    str(1) = [];
    
    
end

P = unique(P);
FZ = unique(FZ);
IA = unique(IA);

end

