function [ OUT_struct ] = Resize_struct_function(Data, Start_point, End_point)
%This function takes as input a structure, a new startpoint and a new endpoint and
%outputs a resized structure to the new start and end points.

      Data.ET = Data.ET(Start_point : End_point);
      Data.FX = Data.FX(Start_point : End_point);
      Data.FY = Data.FY(Start_point : End_point);
      Data.FZ = Data.FZ(Start_point : End_point);
      Data.IA = Data.IA(Start_point : End_point);
      Data.MX = Data.MX(Start_point : End_point);
      Data.MZ = Data.MZ(Start_point : End_point);
      Data.NFX = Data.NFX(Start_point : End_point);
      Data.NFY = Data.NFY(Start_point : End_point);
      Data.P = Data.P(Start_point : End_point);
      Data.RE = Data.RE(Start_point : End_point);
      Data.RL = Data.RL(Start_point : End_point);
      Data.RST = Data.RST(Start_point : End_point);
      Data.SA = Data.SA(Start_point : End_point);
      Data.SL = Data.SL(Start_point : End_point);
      Data.SR = Data.SR(Start_point : End_point);
      Data.TSTC = Data.TSTC(Start_point : End_point);
      Data.TSTI = Data.TSTI(Start_point : End_point);
      Data.TSTO = Data.TSTO(Start_point : End_point);
      Data.V    = Data.V(Start_point : End_point);
      Data.AMBTMP = Data.AMBTMP(Start_point : End_point);

      OUT_struct = Data;
                  
end

