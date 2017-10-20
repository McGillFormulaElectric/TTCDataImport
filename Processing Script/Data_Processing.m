%% Data Processing Script


% Loop for Tire Pressure Indexing
for Index_P = (1:length(RoundData.P))  
    
    S=0;
    E=1;
    
        % Loop for Inclination Angle Indexing
        for Index_IA = 1:length(RoundData.IA)                
            
            
                % Loop for Vertical Load Indexing
                for N = 1:length(RoundData.FZ)
                    
                    
                  %Determine Pressure, Inclination Angle and Vertical Load
                  %from Test Matrix.
                  Pressure = RoundData.P(Index_P);
                  Inclination_Angle = RoundData.IA(Index_IA);
                  Vertical_Load = RoundData.FZ(N);

                  %Create filename according to run number, pressure, inclination
                  %angle and vertical load.
                  filename = sprintf('Test%ddeg%dN', Inclination_Angle, Vertical_Load);
                  structurename = sprintf('%s%dpsi', RoundData.TireCODE, Pressure);
                  
                  %Set the start points for the particular test pressure
                  Start_point = RoundData.startpoints(Index_P) + (S * RoundData.interval);       
                  End_point = Start_point + RoundData.interval;
                                  
                   
                  %Pass test data to a structure
                                    
                  Raw_Data.ET = ET(Start_point : End_point);
                  Raw_Data.FX = FX(Start_point : End_point);
                  Raw_Data.FY = FY(Start_point : End_point);
                  Raw_Data.FZ = FZ(Start_point : End_point);
                  Raw_Data.IA = IA(Start_point : End_point);
                  Raw_Data.MX = MX(Start_point : End_point);
                  Raw_Data.MZ = MZ(Start_point : End_point);
                  Raw_Data.NFX = NFX(Start_point : End_point);
                  Raw_Data.NFY = NFY(Start_point : End_point);
                  Raw_Data.P = P(Start_point : End_point);
                  Raw_Data.RE = RE(Start_point : End_point);
                  Raw_Data.RL = RL(Start_point : End_point);
                  Raw_Data.RST = RST(Start_point : End_point);
                  Raw_Data.SA = SA(Start_point : End_point);
                  Raw_Data.SL = SL(Start_point : End_point);
                  Raw_Data.SR = SR(Start_point : End_point);
                  Raw_Data.TSTC = TSTC(Start_point : End_point);
                  Raw_Data.TSTI = TSTI(Start_point : End_point);
                  Raw_Data.TSTO = TSTO(Start_point : End_point);
                  Raw_Data.V    = V(Start_point : End_point);
                  Raw_Data.AMBTMP = AMBTMP(Start_point : End_point);


                  % Find new Startpoint and Endpoint of Data 
                  
                  j = 1;
                  
                  while(abs(Raw_Data.SA(j+1)-Raw_Data.SA(j)) < 1)

                              j = j + 1;

                  end
                                
                  Start_point_2 = j + 1 ; 
                  
                  End_point_2 = Start_point_2 + 794; 
                  
                  % Modify Data Structure Startpoint and endpoint
                  
                  Raw_Data = Resize_struct_function(Raw_Data, Start_point_2, End_point_2);                  
                  
                  % Find index of maximum positive slip angle
                  
                  Max_Positive_SA = find(Raw_Data.SA == max(Raw_Data.SA));
                                    
                  % Find index of maximum negative slip angle
                  
                  Max_Negative_SA = find(Raw_Data.SA == min(Raw_Data.SA));                  
                
                  % Modify the data so that the positive slip rate sweeps
                  % are of equal dimension
                  
                  a = length(Raw_Data.SA) - Max_Negative_SA ;
                      
                  Start = Max_Positive_SA - a;
                     
                  Data.(structurename).(filename) = Resize_struct_function(Raw_Data, Start, length(Raw_Data.SA));            
                
                  
                  % Update Index S, E and i
                  
                  S = S + 1;
                  E = E + 1;
                  
                                   
                  
                end
                
        % Update Inclination Angle Index    
        Index_IA = Index_IA + 1;  
        
        
        end
        
        % Save Data structure
                   

        save(structurename,'-struct','Data');
        clear Data;
    
% Update Pressure Index        
Index_P = Index_P + 1;



end
