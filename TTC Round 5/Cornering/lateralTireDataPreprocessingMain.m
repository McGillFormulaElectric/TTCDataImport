addpath(genpath(pwd))

% load individual data sets and save as structures
% stores data in folder "Structure Data". These can be deleted after
% running
convert2struct( 'B1464run', [3,5:25] ) ;

% split each data channel into individual SA sweeps
% stores data in folder "Sweep Data". These can be deleted after running
splitAllSweepsLat( 'Brun', [5,8,9,11,12,14:25] ) ;

% load run guide. this is an array of structures containing information
% about tire compounds, rim widths, pressures, etc for each test run
load('round5RunGuideLat') ;
% save data from individual sweeps in separate files for each different
% nominal pressure
storeIndividualRuns( round5RunGuide ) ;
