addpath(genpath(pwd))

% load individual data sets and save as structures
% stores data in folder "Structure Data". These can be deleted after
% running
convert2structLong( 'B1464run', 28 : 58 ) ;

% split each data channel into individual SL sweeps 
% (note: important to use SL data for slip ratio and not SR )
% stores data in folder "Sweep Data". These can be deleted after running
splitAllSweepsLong( 'Brun', [ 28,29,30,33,34,36,37,39,40,42,43,45,46,48,49,51,52 ] ) ;

% load run guide. this is an array of structures containing information
% about tire compounds, rim widths, pressures, etc for each test run
load('round5RunGuideLong') ;
% save data from individual sweeps in separate files for each different
% nominal pressure
storeIndividualRunsLong( round5RunGuide ) ;
