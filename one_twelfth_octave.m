
%  one_twelfth_octave.m  ver 1.0  by Tom Irvine

function[fc]=one_twelfth_octave()
            
            fc(1)=10.; 
            fc(end+1)=10.57;
         	fc(end+1)=11.2; 
         	fc(end+1)=11.8; 
         	fc(end+1)=12.5; 
         	fc(end+1)=13.3; 
         	fc(end+1)=14.1;
            fc(end+1)=15.0;
         	fc(end+1)=15.9;
            fc(end+1)=16.9;
         	fc(end+1)=17.9; 
         	fc(end+1)=18.9;
            fc(end+1)=20.;
         	fc(end+1)=21.2; 
         	fc(end+1)=22.4; 
         	fc(end+1)=23.7; 
           	fc(end+1)=25.;
         	fc(end+1)=26.5; 
         	fc(end+1)=28.1; 
         	fc(end+1)=29.8; 
         	fc(end+1)=31.5; 
         	fc(end+1)=33.4; 
         	fc(end+1)=35.5; 
         	fc(end+1)=37.7; 
           	
            fc(end+1)=40.; 
         	fc(end+1)=42.3; 
         	fc(end+1)=44.7;
         	fc(end+1)=47.3; 
           	fc(end+1)=50.;
           	fc(end+1)=53.;
         	fc(end+1)=56.1;
         	fc(end+1)=59.4;
           	fc(end+1)=63.;
         	fc(end+1)=66.9;
           	fc(end+1)=71.;
         	fc(end+1)=75.4;
           	
            fc(end+1)=80.;
         	fc(end+1)=84.6; 
         	fc(end+1)=89.4;
         	fc(end+1)=94.6;            
            
            LF=length(fc);
            
            ijk=LF+1;
            
            fc=fc/100;
            
            for i=1:500
                fc(ijk)=fc(ijk-LF)*10;
                ijk=ijk+1;
            end    
            
            fc=fix_size(fc);