%% Raw data plotting script



%% General Plotting of Raw Data

figure();
plot(ET, (FZ), '.');
hold on
grid on
plot(ET, (IA*20));
plot(ET, 50*SA, '.');
plot(ET, 10 * P);
%plot(ET, 0.14*P);
%xlim([145, 900]);    %This means that the 8 psi test section will only be shown.

%% Plot FY vs SA

plot(FY, SA, '.');

%% FY vs SA

plot(SA, FY, '.');
%xlim([200, 500]);

%% Plot polynomials
                  
  figure();
  
  plot(Data.SA(Domain_1), Polynomial_1, '.', Data.SA(Domain_2), Polynomial_2, '.',  Data.SA(Domain_3), Polynomial_3, '.'); 
  hold on;
  plot(Data.SA, Data.FY);
  grid on;
    
  %% polyval
  
  aa = polyval(dd_Polynomial_1, (Data.SA(Domain_1)));
  
  plot(Data.SA(Domain_1), aa);
  
  bb = polyval(dd_Polynomial_2, (Data.SA(Domain_2)));
  
  plot(Data.SA(Domain_2), bb);
  
  cc = polyval(dd_Polynomial_3, (Data.SA(Domain_3)));
  
  plot(Data.SA(Domain_3), cc);
  
  a = polyval(d_Polynomial_1, (Data.SA(Domain_1)));
  
  plot(Data.SA(Domain_1), a);
  
  b = polyval(d_Polynomial_2, (Data.SA(Domain_2)));
  
  plot(Data.SA(Domain_2), b);
  
  c = polyval(d_Polynomial_3, (Data.SA(Domain_3)));
  
  plot(Data.SA(Domain_3), c);
  
  
  %% Plot Normalised FY versus SA
 
  plot(Data.Normalised_SA, Data.Normalised_FY);
  grid on;
  ylabel('Normalised Lateral Force');
  xlabel('Normalised Slip Angle');
  title('Normalised Lateral Force vs Normalised Slip Angle');
  

  %% Plot Normalised and shifted Lateral Force vs slip angle
  
  
  
  
  % Loop for Tire Pressure Indexing
for Index_P = 2 
  
       
        % Loop for Inclination Angle Indexing
        for Index_IA = 2 
                
                        
                % Loop for Vertical Load Indexing
                for N = 1:length(Test.B1464_FZ)
                    
                    
                    %Step 1: Load Data file
                  %-------------------------------------------------------------------
                  
                 
                  % Determine Pressure, Inclination Angle and Vertical Load
                  % from Test Matrix
                  Pressure = Test.P(Index_P);
                  Inclination_Angle = Test.IA(Index_IA);
                  Vertical_Load = Test.FZ(N);

                  %Load file according to run number, pressure, inclination
                  %angle and vertical load
                  filename = sprintf('%d%dpsi%ddeg%dN', runname, Pressure, Inclination_Angle, Vertical_Load);

                  legend_filename{N} = filename;
                  
                  %Plot data
                  %------------------------------------------------------------------------
                                    
                 title('filename');
                 
                 %plot(Data.(filename).AVG_Normalised_SA, Calculate_Pacejka_Model(Data.(filename).AVG_Normalised_SA, Data.(filename).Coefficients));
                 hold on;
                 plot(Data.(filename).AVG_Normalised_SA, Data.(filename).AVG_Normalised_FY);
                 
                    
                end
                
                legend(legend_filename);
                
                
        end
        
        
end
%% Plot Response Surfaces Hoosier_06181007

figure('Name', tireidp, 'NumberTitle', 'off');

subplot(2, 3, 1);
plot(Data.(testname).B, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_B)
zlabel('Pacejka Parameter B');
xlabel('FZ');
ylabel('IA');



subplot(2, 3, 2);
plot(Data.(testname).E, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_E)
zlabel('Pacejka Parameter E');
xlabel('FZ');
ylabel('IA');
title(tireidp, 'FontSize', 16);

subplot(2, 3, 3);
plot(Data.(testname).V_shift, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_V_shift)
zlabel('Vertical Shift');
xlabel('FZ');
ylabel('IA');

subplot(2, 3, 4);
plot(Data.(testname).H_shift, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_H_shift)
zlabel('Horizontal Shift');
xlabel('FZ');
ylabel('IA');

subplot(2, 3, 5);
plot(Data.(testname).MUHat, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_MUHat)
zlabel('Shifter Coefficient of friction(MUHat)');
xlabel('FZ');
ylabel('IA');

subplot(2, 3, 6);
plot(Data.(testname).CSBar, [Data.Stored_IA, Data.Stored_Mean_FZ], Data.Stored_CSBar)
zlabel('Cornering Stiffness (CSBar)');
xlabel('FZ');
ylabel('IA');

set(gcf, '1', 'off', tireid, 'myfigure');