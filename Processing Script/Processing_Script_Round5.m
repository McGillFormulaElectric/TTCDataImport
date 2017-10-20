%%  Raw Data Processing Script
% This Script cuts and identifies the TTC Raw Data for use by the Non-
% Dimensional Lateral Tire Model.

% How to use:

%1) Get startpoints from Raw Data. Find ET and then find corresponding array cell.
%2) Fill Initialisation_Round_5
%3) Modify Round5_Run_Array so that it contains the runs for which the
%startpoints were obtained.
%4) Make sure path is correct.
%5) Run Script.

clc
clear

%% Processing 

Initialisation_Round5;
Round5_Run_array = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];

for n = (1:length(Round5_Run_array)) 
    
       
    %Load Run file
    runNumber = Round5_Run_array(n);
    filename = sprintf('C:\\Users\\Felix Lamy\\Documents\\Professional Life\\McGill Racing Team\\MRT18\\5 Vehicle Dynamics\\1. Matlab Projects\\Tire Analysis\\Tire Modelling\\TTC FSAE Data\\TTC FSAE Round 5\\Cornering\\RawData_Cornering_Matlab_SI\\B1464run%d', runNumber);
    load(filename);
    
    %Get run parameters
    structname = sprintf('run%d', runNumber);
    RoundData = TTC_Round5.(structname);
    
    Data_Processing;
    disp(runNumber);
    
    Initialisation_Round5;
    Round5_Run_array = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];
          
    
end
clear;
