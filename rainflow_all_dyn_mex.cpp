
//   rainflow_all_dyn_mex.cpp  ver 1.0  by Tom Irvine

//  ASTM E 1049-85 (2005) Rainflow Counting Method


#include <math.h>
#include <matrix.h>
#include <mex.h>

#include <cstdlib>

#include <vector>

     
using namespace std;

void rainflow_cpp(vector<float> &tac1, vector<float> &tac2, vector<float> &tB0, vector<float> &tB1, vector<float> &tB2, vector<float> &tB3, double *y, size_t num)
{
    
    double slope1,slope2;

    float mina,maxa;

    float X,Y;
    float ymax=0.;

    long hold;
    long i,j,k,nn;
    
    long kv=0;


    long last_a;

    long NP=num+1;
//    mexPrintf(" NP=%ld \n",NP);

	vector<float> a;
   
    a.push_back(y[0]);

    for(long i=1;i<(num-1);i++)
	{
	    slope1=(y[i]-y[i-1]);
	    slope2=(y[i+1]-y[i]);
        
//        mexPrintf(" %8.4g  %8.4g  %8.4g \n",y[i-1],y[i],y[i+1]);

    	if( slope1*slope2 <=0. && fabs(slope1) >0.)
		{
        	    a.push_back(y[i]);
		}
         
	}
    a.push_back(y[num-1]);

    last_a=a.size(); 
    
/*
    for(long i=0; i<last_a; i++)
    {
		mexPrintf(" %8.4g \n",a[i]);
    }
*/


//	num=long(maxa-mina)+1;

	nn=0;
	i=0;
	j=1;

	float sum=0;

	kv=0;


	while(1)
	{
    	Y=(fabs(a[i]-a[i+1]));
    	X=(fabs(a[j]-a[j+1]));

//        mexPrintf("%8.4g \t %8.4g \n",Y,X);

    	if(X>=Y && Y>0)
		{
            if(Y>ymax)
            {ymax=Y;}

        	if(i==0)
			{

           		nn=0;
           		sum+=0.5;
  
                tac1.push_back(0.5*Y);
                tac2.push_back(0.5); 
                tB3.push_back(a[i+1]);
                tB2.push_back(a[i]);
                tB1.push_back(0.5);
                tB0.push_back(Y);
                
                kv++;

				a.erase (a.begin());


				last_a--;

           		i=0;
           		j=1;

       //         mexPrintf("p1a \t %8.4g \n",Y);
			}
        	else
			{
           		sum+=1;
               
                tac1.push_back(0.5*Y);
                tac2.push_back(1);  
                tB3.push_back(a[i+1]);
                tB2.push_back(a[i]);
                tB1.push_back(1);
                tB0.push_back(Y); 
                kv++;

           		nn=0;

                a.erase (a.begin()+(i+1));
                a.erase (a.begin()+i);


				last_a-=2;

           		i=0;
           		j=1;

      //          mexPrintf("p1b \t %8.4g \n",Y);
			}


		}
    	else
		{
        	i++;
        	j++;
		}

    	if((j+1)>=last_a)
		{
        	break;
		}
	}


	for(long i=0;i<(last_a);i++)
	{
    	Y=(fabs(a[i]-a[i+1]));
    	if(Y>0)
		{
        	sum+=0.5;
            tac1.push_back(0.5*Y);
            tac2.push_back(0.5);    
            tB3.push_back(a[i+1]);
            tB2.push_back(a[i]);
            tB1.push_back(0.5);
            tB0.push_back(Y);           
            kv++;

  //         mexPrintf("p2 \t %8.4g \n",Y);
		}
        if(Y>ymax)
        {ymax=Y;}
	}
}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

//  mexPrintf(" mexFunction \n");
//  1D arrays

    double *ac1;
    double *ac2;
    double *B0;
    double *B1;
    double *B2;
    double *B3;    
    double *nkv;
    
    double *y;

    size_t m;
    size_t n;
    size_t num;

//    mexPrintf(" ** nlhs=%d  nrhs=%d \n",nlhs,nrhs);
    
    /* Check for proper number of arguments */
    if (nrhs != 1) {
        mexErrMsgTxt("One input argument required.");
    } 

    m = mxGetM(prhs[0]);
    n = mxGetN(prhs[0]);

    num=m;

    if(n>m){num=n;}

    y = mxGetPr(prhs[0]);


//    Call the rainflow_cpp function.

//    mexPrintf(" Call the rainflow_cpp function \n");
                          
    
//*************************************************************************

    vector<float> tac1;
    vector<float> tac2;
    vector<float> tB0; 
    vector<float> tB1; 
    vector<float> tB2; 
    vector<float> tB3;    
  
    rainflow_cpp(tac1,tac2,tB0,tB1,tB2,tB3,y,num);
    
    long kv=tac1.size();
    
//*************************************************************************
        
    /* Create a matrix for the return argument */
    plhs[0]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[1]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[2]= mxCreateDoubleMatrix(kv, 1, mxREAL);   
    plhs[3]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[4]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[5]= mxCreateDoubleMatrix(kv, 1, mxREAL);  
    plhs[6]= mxCreateDoubleMatrix(1, 1, mxREAL);
    
    /* Assign pointers to the various parameters */

    ac1         = mxGetPr(plhs[0]);
    ac2         = mxGetPr(plhs[1]);
    B0          = mxGetPr(plhs[2]);
    B1          = mxGetPr(plhs[3]);    
    B2          = mxGetPr(plhs[4]);    
    B3          = mxGetPr(plhs[5]);    
    nkv         = mxGetPr(plhs[6]);        
    
      
    for(long i=0; i<kv; i++)
    {
          ac1[i]=tac1[i];
          ac2[i]=tac2[i];  
           B0[i]=tB0[i];         
           B1[i]=tB1[i];
           B2[i]=tB2[i];         
           B3[i]=tB3[i];
    }
    
    nkv[0]=kv;
    
}
