
//   rainflow_basic_dyn_mex.cpp  ver 1.0  by Tom Irvine

//  ASTM E 1049-85 (2005) Rainflow Counting Method


#include <math.h>
#include <matrix.h>
#include <mex.h>

#include <cstdlib>

#include <vector>

     
using namespace std;

void rainflow_cpp(vector<float> &tac1, vector<float> &tac2, double *y, size_t num)
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
    
	k=0;

    a.push_back(y[k]);

	k=1;

    for(long i=1;i<(NP-1);i++)
	{
	    slope1=(y[i]-y[i-1]);
	    slope2=(y[i+1]-y[i]);

    	if( slope1*slope2 <=0. && fabs(slope1) >0.)
		{
       // 	a[k]=y[i];
        	    a.push_back(y[i]);
        	k++;
		}

	}

	last_a=k-1;

	hold=last_a;


//	a[k]=y[NP-1];
	a.push_back(y[NP-1]);

/*
    for(long i=0; i<=last_a; i++)
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

    	if((j+1)>last_a)
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
    double *nkv;
    
    double *y;

    size_t m;
    size_t n;
    size_t num;

//    mexPrintf(" ** nlhs=%d  nrhs=%d \n",nlhs,nrhs);
    
    /* Check for proper number of arguments */
    if (nrhs != 1) {
        mexErrMsgTxt("One input argument required.");
    } else if (nlhs != 3) {
        mexErrMsgTxt("Incorrect number of output arguments.");
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
  
    rainflow_cpp(tac1,tac2,y,num);
    
    long kv=tac1.size();
    
//*************************************************************************
        
    /* Create a matrix for the return argument */
    plhs[0]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[1]= mxCreateDoubleMatrix(kv, 1, mxREAL);
    plhs[2]= mxCreateDoubleMatrix(1, 1, mxREAL);
    
    /* Assign pointers to the various parameters */

    ac1         = mxGetPr(plhs[0]);
    ac2         = mxGetPr(plhs[1]);
    nkv         = mxGetPr(plhs[2]);        
    
      
    for(long i=0; i<kv; i++)
    {
        ac1[i]=tac1[i];
        ac2[i]=tac2[i];  

    }
    
    nkv[0]=kv;
    
}
