disp(' ');
disp(' lord_iso_A_inter.m   ver 1.0   April 7, 2009 ');
disp(' by Tom Irvine ');
disp('                ');
disp(' This is an interactive version of Kent Hardys script ');
disp(' ');
disp(' Enter the mass per isolator (lbm): ');
mass_per_iso=input(' ');
%%%function [trans,isoMPE]=lord_iso(mpe,mass_per_iso);
%
%  function [trans,isoMPE]=lord_iso(mpe,mass_per_iso)
%
%  This function calculates the isolator transmissibility and an
%  isolated MPE level for the Lord 156APLQ-8 isolators which are
%  often used around Orbital.
%
%  INPUT VARIABLES:
%		"mpe" is a two column array with frequency (Hz) in column 1
%			and the MPE magnitude (g^2/Hz) in column 2.  Average MPE
%			must be between 7.5e-5 and 0.01 g^2/Hz below 40 Hz.
%		"mass_per_iso" is the average mass per isolator for the
%			component in question.  This is just a single number.
%		"trans" is a two column array with frequency (Hz) in column 1
%			and transmissibility (g^2/g^2) in column 2.  Frequency
%			resolution is 1.0 Hz.
%		"isoMPE" is a two column vector with frequency (Hz) in
%			column 1 and the isolated MPE (which is the transmissibility
%			multiplied by the input PSD level, of course).  Frequency
%			resolution is 1.0 Hz.

%  Written by Kent Hardy, 5/29/02

%  Revision A by Kent Hardy, 7/16/03.  Realized that my scaling for mass
%  was inherently flawed.  I was simply moving the transmissibility curve
%  up and down (magnitude and frequency), which allows the transmissibility
%  to be less than 1 at low frequency in the wrong set of circumstances.  I
%  tweaked the code to calculate the FRF for the original mass and the new
%  mass, and then used that to create a transfer function between the old
%  and new curves.  The problem is that this now increases the
%  transmissibility curve slightly compared to the previous revision.
%  However, this is the "right" way to do the job, so we will start using
%  it.
%
%  Check the input data to verify it is correct format.
%
disp(' Select data input method: ')
disp('  1=Open external ASCII file    ');
disp('  2=Preloaded input file  ');  
disp('  3=Excel file ');
m = input('');
disp(' ')
clear mpe;
%
if(m~=1 & m~=2 & m~=3)
    m=1;
end
%
if(m==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename); 
    fid = fopen(filename,'r');
    mpe = fscanf(fid,'%g %g',[2 inf]);    
    mpe=mpe';
end
if(m==2)
    disp(' The input file must be pre-loaded into Matlab.')
    disp(' ')
    disp(' The input file must have two columns: frequency(Hz) & accel(G^2/Hz).')
    disp(' ')
    mpe = input(' Enter the input PSD filename:  ');    
end
if(m==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        mpe = xlsread(xfile);              
end
clear m;
%
disp(' ')
%
q1=size(mpe);
if q1(2)~=2; error(['Input MPE array must be 2 columns: ' ...
  'col1=frequency (Hz), col2=PSD (g^2/Hz)']); end
if q1(1)<2; error(['That''s a very strange MPE.  Input must be 2 ' ...
  'columns: col1=frequency (Hz), col2=PSD (g^2/Hz)']); end

q1=size(mass_per_iso);
if q1(1)~=1 | q1(2)~=1; error(['Mass per isolator must be a single' ...
  'number.  No array is allowed.']); end
%
%  Load the FTLU test data which is the basis of this function.
%
load all_FTLU_data
disp(' loaded data?  Press any key to continue.')
uuuu=input(' ');
%  Interpolate the input MPE to 1 Hz delta-f so I can use that data
%  to define the correct isolator curve to start with.
mnf=min(mpe(:,1)); mxf=max(mpe(:,1));
q1=(mnf:1:mxf)';
[mpe2(:,1),mpe2(:,2)]=k_intrp2(mpe(:,1),mpe(:,2),q1);
%  Find the average PSD below 40 Hz to choose the correct curve.
q3=(mpe2(:,1)<=40); 
q2=mean(mpe2(q3,2));
%
out1=sprintf('\n q2=%8.4g \n',q2);
disp(out1);
%
lvl2use=0;
if q2>7.5e-5&q2<=1.5e-4; lvl2use=1; end;
if q2>1.5e-4&q2<=3.0e-4; lvl2use=2; end;
if q2>3.0e-4&q2<=8.0e-4; lvl2use=3; end;
if q2>8.0e-4&q2<=2.0e-3; lvl2use=4; end;
if q2>2.0e-3&q2<=4.5e-3; lvl2use=5; end;
if q2>4.5e-3&q2<=1.0e-2; lvl2use=6; end;
%  Make sure the input PSD is within the accepted range.  If not,
%  the poor user is in trouble.
if (lvl2use==0)
    if(q2<=7.5e-5)
        disp(' Warning: input PSD is low. ');
        lvl2use=1;
    end
    if(q2>1.0e-2)
        disp(' Warning: input PSD is high. ');
        lvl2use=6;
    end  
    disp(' ');
end
%
%  Here's where things change a bit in Revision A.  I start by finding the
%  natural frequency and magnitude of the peak transmissibility in each axis
%  and in the cross axis responses, then work from there
%
disp('Reference 1a')
eval(['xax=x_lvl' num2str(lvl2use) ';']);
eval(['yax=y_lvl' num2str(lvl2use) ';']);
eval(['zax=z_lvl' num2str(lvl2use) ';']);
eval(['ycr=y_crs' num2str(lvl2use) ';']);
eval(['zcr=z_crs' num2str(lvl2use) ';']);
disp('Reference 1b')
%
%  For each in-axis curve, scale the transmissibility based on the mass
%  differences.  FTLU mass per isolator (needed for scaling operations) is
%  1.125 lb per isolator.
%
m0=1.125;
%
inaxis=[xax yax zax];
crsaxs=[ycr zcr];
for k1=1:6;
  q4=max(inaxis(:,k1))*0.9;
  q5=(inaxis(:,k1)>=q4);
  fn_orig=mean(frq(q5));
  Q_orig=max(inaxis(q5,k1));
	%
	%  Calculate the new natural frequency and Q based on the mass shift.
	%
	fn_new=fn_orig*sqrt(m0/mass_per_iso);
	Q_new=Q_orig*(mass_per_iso/m0);
	%
	%  I also want to shift the resulting natural frequency +/- 5% to account
	%  for isolator variability.
	%
	fn_new_1=fn_new*1.05;
	fn_new_2=fn_new*0.95;
	%
	%  So I will be calculating the FRF for the original system and for the 3
	%  new systems...
	%
	zeta_1=1/(2*sqrt(Q_orig));
	frf_orig=sdof_frf(fn_orig,zeta_1,1,1.25,10,2000);
	%
	zeta_2=1/(2*sqrt(Q_new));
	frf_new_0=sdof_frf(fn_new,zeta_2,1,1.25,10,2000);
	frf_new_1=sdof_frf(fn_new_1,zeta_2,1,1.25,10,2000);
	frf_new_2=sdof_frf(fn_new_2,zeta_2,1,1.25,10,2000);
	%
	%  OK.  Now I need to scale the data from "tr_orig" to "tr_new" based on
	%  the various FRF curves.  Remember though that my FRF curves are in G/G,
	%  so I need to square them.
	%
	frf_orig(:,3)=frf_orig(:,2).^2;
	frf_new_0(:,3)=frf_new_0(:,2).^2;
	frf_new_1(:,3)=frf_new_1(:,2).^2;
	frf_new_2(:,3)=frf_new_2(:,2).^2;
  %
  %  "fred" is the new transmissibility data corresponding to
  %  "inaxis(:,k1)".
  %
  fred=[inaxis(:,k1).*frf_new_0(:,3)./frf_orig(:,3) ...
    inaxis(:,k1).*frf_new_1(:,3)./frf_orig(:,3) ...
    inaxis(:,k1).*frf_new_2(:,3)./frf_orig(:,3)];
  inaxis_new(:,k1)=max(fred')';
end
%
%  I want to perform a similar calculation for the cross-axis data, but the
%  cross axis data has two problems that need to be overcome.  First, the
%  data has 2 low-frequency peaks, and so I want to try to scale them
%  independently.  Second, the low frequency part of the transmissibility
%  curves goes to a value much less than 1, so my FRF curves need to be
%  tweaked somewhat to account for that.
%
disp('Reference 2')
% uuuu=input(' ');
for k1=1:4
  if k1==1 | k1==2; fct1=0.005; fct2=0.02; end
  if k1==3 | k1==4; fct1=0.02; fct2=0.08; end
  %
  q1=(frq>20&frq<45); frq1=frq(q1); tr1=crsaxs(q1,k1);
  q2=(frq>45&frq<100); frq2=frq(q2); tr2=crsaxs(q2,k1);
  %
  q3=max(tr1)*0.9; q4=(tr1>=q3); fn1=mean(frq1(q4));
  Q1=max(tr1(q4))/fct1; zeta1=1/(2*sqrt(Q1));
  q5=max(tr2)*0.9; q6=(tr2>=q5); fn2=mean(frq2(q6));
  Q2=max(tr2(q6))/fct2; zeta2=1/(2*sqrt(Q2));
  %
  frf1=sdof_frf(fn1,zeta1,1,1.25,10,2000); frf1(:,3)=fct1*frf1(:,2).^2;
  frf2=sdof_frf(fn2,zeta2,1,1.25,10,2000); frf2(:,3)=fct2*frf2(:,2).^2;

  %loglog(frq,crsaxs(:,k1),frf1(:,1),frf1(:,3),frf2(:,1),frf2(:,3)); grid; set(gca,'xlim',[10 200]);
  %pause
  frf_orig=[frf1(:,1) max([frf1(:,3) frf2(:,3)]')'];
	%
	%  Calculate the new natural frequency and Q based on the mass shift.
	%
	fn1a=fn1*sqrt(m0/mass_per_iso);
	fn2a=fn2*sqrt(m0/mass_per_iso);
	Q1a=Q1*(mass_per_iso/m0); zeta1a=1/(2*sqrt(Q1a));
	Q2a=Q2*(mass_per_iso/m0); zeta2a=1/(2*sqrt(Q2a));
  frf1=sdof_frf(fn1a,zeta1a,1,1.25,10,2000); frf1(:,3)=fct1*frf1(:,2).^2;
  frf2=sdof_frf(fn2a,zeta2a,1,1.25,10,2000); frf2(:,3)=fct2*frf2(:,2).^2;
  frf_new_0=[frf1(:,1) max([frf1(:,3) frf2(:,3)]')'];
	%
	%  I also want to shift the resulting natural frequency +/- 5% to account
	%  for isolator variability.
	%
	fn1b=fn1a*1.05; fn2b=fn2a*1.05;
  frf1=sdof_frf(fn1b,zeta1a,1,1.25,10,2000); frf1(:,3)=fct1*frf1(:,2).^2;
  frf2=sdof_frf(fn2b,zeta2a,1,1.25,10,2000); frf2(:,3)=fct2*frf2(:,2).^2;
  frf_new_1=[frf1(:,1) max([frf1(:,3) frf2(:,3)]')'];
  %
	fn1c=fn1a*0.95; fn2c=fn2a*0.95;
  frf1=sdof_frf(fn1c,zeta1a,1,1.25,10,2000); frf1(:,3)=fct1*frf1(:,2).^2;
  frf2=sdof_frf(fn2c,zeta2a,1,1.25,10,2000); frf2(:,3)=fct2*frf2(:,2).^2;
  frf_new_2=[frf1(:,1) max([frf1(:,3) frf2(:,3)]')'];
  %
  %  "fred" is the new transmissibility data corresponding to
  %  "inaxis(:,k1)".
  %
  fred=[crsaxs(:,k1).*frf_new_0(:,2)./frf_orig(:,2) ...
    crsaxs(:,k1).*frf_new_1(:,2)./frf_orig(:,2) ...
    crsaxs(:,k1).*frf_new_2(:,2)./frf_orig(:,2)];
  crsaxs_new(:,k1)=max(fred')';
end
disp('Reference 3')
%% uuuu=input(' ');
%
%  The overall transmissibility curve is here, but not in the right format.
%
tr_new=[frq max([inaxis_new crsaxs_new]')'];
%
%  Next, I need to figure out where the transmissibility curve first falls
%  below 0.05 g^2/g^2, so I can define the curve to be equal to 0.05 above
%  that frequency.  This matches the basic Taurus approach.
%
q7a=(frq<200); tr_lo=tr_new(q7a,:);
q7b=(frq>=200); tr_hi=tr_new(q7b,:);
%
q8=(tr_lo(:,2)<0.05); tr_lo(q8,2)=0.05*ones(sum(q8),1);
tr_hi(:,2)=0.05*ones(size(tr_hi(:,2)));
%
tr_new2=[tr_lo; tr_hi];
%
%  Now, I want to convert the transmissibility curve to 1 Hz resolution to
%  match what I did with "mpe2".
%
disp('Reference 4')
%
[trans(:,1),trans(:,2)]=k_intrp2(tr_new2(:,1),tr_new2(:,2),(10:1:2000)');
%
%  Calculate isolated MPE as well.  Need to interpolate the input
%  MPE to the correct delta-f, and then multiply the curves.
%
clear AAAQ;
clear BBBQ;
%
AAAQ=tr_new2;
BBBQ=mpe2;
%
%%tr_new2(:,1)
%%tr_new2(:,2)
%%mpe2(:,1)
%
[qq1,qq2]=k_intrp2(tr_new2(:,1),tr_new2(:,2),mpe2(:,1));
disp('Reference 5')
isoMPE=[mpe2(:,1) mpe2(:,2).*qq2];
disp('Reference 6')
%
disp(' ');
disp(' The power transmissibilty array is:  trans ');
%
disp(' Write transmissibility array to ASCII text file? ');
disp(' 1=yes 2=no ');
%
ita=input(' ');
%
if(ita==1)
        [writefname, writepname] = uiputfile('*','Save transmissibility data as');
	    writepfname = fullfile(writepname, writefname);
	    writedata = [trans(:,1),trans(:,2)];
	    fid = fopen(writepfname,'w');
	    fprintf(fid,'  %g \t %g \n',writedata');
	    fclose(fid);
end   
%
disp(' ');
disp(' The isolated MPE array is:  isoMPE ');
%
disp(' Write isolated MPE to ASCII text file? ');
disp(' 1=yes 2=no ');
%
ita=input(' ');
%
if(ita==1)
        [writefname, writepname] = uiputfile('*','Save isolated MPE data as');
	    writepfname = fullfile(writepname, writefname);
	    writedata = [isoMPE(:,1),isoMPE(:,2)];
	    fid = fopen(writepfname,'w');
	    fprintf(fid,'  %g \t %g \n',writedata');
	    fclose(fid);
end 
%
clear f;
clear a;
f=isoMPE(:,1);
a=isoMPE(:,2);
%
[s,grms]=calculate_PSD_slopes(f,a);
out5 = sprintf('\n Overall Acceleration = %10.3g GRMS',grms);
disp(out5);
grms_resp=grms;
[s,grms]=calculate_PSD_slopes(mpe(:,1),mpe(:,2));
grms_input=grms;
%
plot(f,a,mpe(:,1),mpe(:,2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
fmin=min(f);
fmax=max(f);
%
for(i=1:20)
    for(j=1:9)
        level = j*10^(i-10);
        fmax=level;
        if(level>=max(f))
            break;
        end
    end
    if(level>=max(f))
        break;
    end
end
%
for(i=1:20)
    for(j=1:9)
        level = j*10^(i-10);
        fmin=level;
        if(min(f)<=level)
            break;
        end
    end
    if(min(f)<=level)
            break;
    end  
end
%
if(fmin<10)
    fmin=10;
end
%
ymax=max(a);
ymin=min(a);
%
for(i=1:20)
    level = 10^(i-10);
    if(min(a) > level)
        ymin=level;
    end
end
%
for(i=1:20)
    level = 10^(10-i);
    if(max(a) < level)
        ymax=level;
    end
end
%
axis([fmin,fmax,ymin,(ymax*1.01)]);
%
ylabel('Accel (G^2/Hz)');   
xlabel('Frequency (Hz)');
out=sprintf(' Power Spectral Density ');
title(out);
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(fmin==20.)
    set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
else
    set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
end
%
ya=ymin;
k=1;
for(i=1:10)
    for(j=1:9)
        ytickn(k)=j*ya; 
        k=k+1;
    end
    ya=ya*10.;
    ytickn(k)=ya; 
%    
    if(ya>ymax)
        break;
    end
end
%
set(gca,'ytick',ytickn);
%
nd=fix(log10(ymax/ymin));
%
string1=num2str(ymin);
string2=num2str(10*ymin);
string3=num2str(100*ymin);
string4=num2str(1000*ymin);
string5=num2str(10000*ymin);
string6=num2str(100000*ymin);
string7=num2str(1000000*ymin);
%
if(nd==1)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2})
end
if(nd==2)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3})
end
if(nd==3)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4})
end
if(nd==4)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5})
end
if(nd==5)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6})
end
if(nd==6)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6;'';'';'';'';'';'';'';'';string7})
end
%
outL=sprintf('response %7.3g GRMS ',grms_resp);
outI=sprintf('input    %7.3g GRMS ',grms_input);
%
legend (outL,outI);       
%
disp(' ');
disp(' See Figure ');
%