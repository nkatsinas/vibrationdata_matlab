
% sn_nrspl.m  ver 1.0  by Tom Irvine

function[sn,nrspl,num]=sn_nrspl()
  
ref  = 1.0e-12;
    
       sn(2)=0.002;
	nrspl(2)=-1.;
    
 	   sn(3)=0.005;
	nrspl(3)=8.;   
    
    noct32=log(sn(3)/sn(2))/log(2);
    initial_slope=(nrspl(3)-nrspl(2))/noct32;
        
       sn(1)=1.0e-06;
    
       noct21=log(sn(2)/sn(1))/log(2);   
	nrspl(1)=nrspl(2)-initial_slope*noct21;


	   sn(4)=0.01;
	nrspl(4)=10.;

	   sn(5)=0.02;
	nrspl(5)=11.;

	   sn(6)=0.03;
	nrspl(6)=10.5;

	   sn(7)=0.05;
	nrspl(7)=9.;

	   sn(8)=0.1;
	nrspl(8)=6.;

	   sn(9)=0.2;
	nrspl(9)=1.;

	   sn(10)=0.5;
	nrspl(10)=-7.5;

	   sn(11)=1.;
	nrspl(11)=-13.5;

	   sn(12)=2.;
	nrspl(12)=-20.;

	   sn(13)=5.0;
	nrspl(13)=-27.;

    
    noct1312=log(sn(13)/sn(12))/log(2);
    end_slope=(nrspl(13)-nrspl(12))/noct1312;
    
       sn(14)=100;
    
       noct1413=log(sn(14)/sn(13))/log(2);   
	nrspl(14)=nrspl(13)+end_slope*noct1413;
    

	num=length(nrspl);

    for i=1:num
		nrspl(i)=ref* 10^(0.1*nrspl(i));
    end