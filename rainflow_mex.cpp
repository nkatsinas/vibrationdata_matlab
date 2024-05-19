
//   rainflow_mex.cpp  ver 1.7  Aug 28, 2015

#include <math.h>
#include <matrix.h>
#include <mex.h>

#include <cstdlib>

#include <vector>


// Dynamic Memory Allocation for 2D Arrays

#define ZERO(Q,nrows,ncols) \
 for(long i=0; i<nrows; i++)\
 { for(long j=0; j<ncols; j++)\
 {Q[i][j]=0.;}}

#define DYNAMIC_MATRIX(Q,nrows,ncols) \
 double **Q;\
 Q =new double* [nrows];\
 for(long row=0;row<nrows;row++) {Q[row]=new double[ncols]; }\
 ZERO(Q,nrows,ncols)

#define DELETE_MATRIX(aaa,nrows)\
 for (long i = 0; i < nrows; i++)\
 {delete(aaa[i]);}\
 delete(aaa); \
         
      


#define NB 14    // number of bins

#define NB_m1 NB-1
         
#define MC 1000000            


using namespace std;

void rainflow_cpp(double *L,double *C,double *AverageAmp,double *MaxAmp,
                     double *MinMean,double *AverageMean,double *MaxMean,
                     double *MinValley,double *MaxPeak,
                     double *D,double *ac1,double *ac2,double *cL,
                     double *y,double *dchoice,double *exponent,size_t num)
{
    

//  ASTM E 1049-85 (2005) Rainflow Counting Method

    for(long i=0;i<MC;i++)
    {    
        ac1[i]=0.;
        ac2[i]=0.;
    }    
                      
    DYNAMIC_MATRIX(B,num,4);

    double slope1,slope2;

    float mina,maxa;

    float X,Y;
    float ymax=0.;

    long kv;

    long hold;
    long i,j,k,n;

    long nkv=0;


    long last_a;

    long NP=num+1;
//    mexPrintf(" NP=%ld \n",NP);

	vector<float> a;
    
	k=0;

//	a[k]=y[k];
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

	mina=100000;
	maxa=-mina;

	for(long i=0;i<=last_a;i++)
	{
		if(a[i]<mina)
		{
			mina=a[i];
		}
		if(a[i]>maxa)
		{
			maxa=a[i];
		}
	}

//	num=long(maxa-mina)+1;

	n=0;
	i=0;
	j=1;

	float sum=0;

	kv=0;

//    mexPrintf("\n percent completed \n");

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

           		n=0;
           		sum+=0.5;
                B[kv][3]=a[i+1];
                B[kv][2]=a[i];
                B[kv][1]=0.5;
                B[kv][0]=Y;
                ac1[kv]=0.5*B[kv][0];
                ac2[kv]=B[kv][1];    
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
                B[kv][3]=a[i+1];
                B[kv][2]=a[i];
                B[kv][1]=1.;
                B[kv][0]=Y;
                ac1[kv]=0.5*B[kv][0];
                ac2[kv]=B[kv][1];      
                kv++;

           		n=0;

                a.erase (a.begin()+(i+1));
                a.erase (a.begin()+i);


				last_a-=2;

           		i=0;
           		j=1;

      //          mexPrintf("p1b \t %8.4g \n",Y);
			}


			nkv++;

			if(nkv==3000)
			{
	//		   mexPrintf(" %8.4g \n",(sum/(hold/2))*100.);
			   nkv=0;
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
            B[kv][3]=a[i+1];
            B[kv][2]=a[i];
            B[kv][1]=0.5;
            B[kv][0]=Y;
            ac1[kv]=0.5*B[kv][0];
            ac2[kv]=B[kv][1];     
            kv++;

  //         mexPrintf("p2 \t %8.4g \n",Y);
		}
        if(Y>ymax)
        {ymax=Y;}
	}
    


    L[1]=0;
    L[2]=2.5;
    L[3]=5;
    L[4]=10;
    L[5]=15;
    L[6]=20;
    L[7]=30;
    L[8]=40;
    L[9]=50;
    L[10]=60;
    L[11]=70;
    L[12]=80;
    L[13]=90;
    L[14]=100;


    for(int ijk=1;ijk<=NB;ijk++)
    {
        L[ijk]*=ymax/100.;

        C[ijk]=0.;
        
        MaxMean[ijk]=-1.0e+20;
        MinMean[ijk]= 1.0e+20;        

        AverageMean[ijk]=0.;
        
        MaxPeak[ijk]=-1.0e+20;
        MinValley[ijk]= 1.0e+20;

        MaxAmp[ijk]=-1.0e+20;
        AverageAmp[ijk]= 1.0e+20;

//     printf("  L[%ld]=%g \n",ijk,L[ijk]);
    }
    
    if(kv>MC)
    {
        mexErrMsgTxt("Number of cycles is > 1 million.");
    }
    
    cL[0]=double(kv);

    kv--;

    for(int ijk= NB_m1;ijk>=0;ijk--)
    {
        AverageAmp[ijk]=0.;
    }
    
    double bm;
    
    for(long i=0;i<=kv;i++)
    {
        Y=B[i][0];

 //    mexPrintf("i=%d Y=%g \n",i,Y);


        for(int ijk= NB_m1;ijk>=0;ijk--)
        {

            if(Y>=L[ijk] && Y<=L[ijk+1])
            {
                bm=(B[i][2]+B[i][3])/2.;
                
                if( bm > MaxMean[ijk])
                {    
                    MaxMean[ijk]=bm;
                }
                if( bm < MinMean[ijk])
                {    
                    MinMean[ijk]=bm;
                }

                C[ijk]=C[ijk]+B[i][1];
                AverageMean[ijk]+=B[i][1]*(B[i][3]+B[i][2])*0.5; // weighted average

                if(B[i][3]>MaxPeak[ijk])
                {
                    MaxPeak[ijk]=B[i][3];
                }
                if(B[i][2]>MaxPeak[ijk])
                {
                    MaxPeak[ijk]=B[i][2];
                }

                if(B[i][3]<MinValley[ijk])
                {
                    MinValley[ijk]=B[i][3];
                }
                if(B[i][2]<MinValley[ijk])
                {
                    MinValley[ijk]=B[i][2];
                }

                if(Y>MaxAmp[ijk])
                {
                    MaxAmp[ijk]=Y;

  //                  mexPrintf("ijk=%d Y=%g \n",ijk,MaxAmp[ijk]);
                }

                AverageAmp[ijk]+=B[i][1]*Y*0.5;

                break;
            }
        }
    }

    for(int ijk=1;ijk<=NB;ijk++)
    {
        if(C[ijk]>0)
        {
            AverageMean[ijk]/=C[ijk];
             AverageAmp[ijk]/=C[ijk];
        }
        MaxAmp[ijk]/=2.;

        if(C[ijk]<0.5)
        {
            AverageAmp[ijk]=0.;
            MaxAmp[ijk]=0.;
            AverageMean[ijk]=0.;
            MinValley[ijk]=0.;
            MaxPeak[ijk]=0.;
        }

//          mexPrintf(" ** ijk=%d MaxAmp[ijk]=%g \n",ijk,MaxAmp[ijk]);
    }


    
//    printf("\n Amplitude = (peak-valley)/2 \n");

//   L,C,AverageAmp,MaxAmp,AverageMean,MinValley,MaxPeak

    D[0]=0.;

    double yy;
    double b;

    if(dchoice[0]>0.)
    {
            for(long i=0;i<kv;i++)
            {
                yy=double(0.5*B[i][0]);
                b=double(exponent[0]);

                D[0]+=B[i][1]*pow(yy,b);
            }
    }
    DELETE_MATRIX(B,num)
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

//    mexPrintf(" mexFunction \n");

    // 1D arrays

    double *L;
    double *C;
    double *AverageAmp;
    double *MaxAmp;
    double *MinMean;    
    double *AverageMean;
    double *MaxMean;    
    double *MinValley;
    double *MaxPeak;
    double *D;
    double *ac1;
    double *ac2;     
    double *cL;

    double *y;
    double *dchoice;
    double *exponent;

    size_t m;
    size_t n;
    size_t num;

//    mexPrintf(" ** nlhs=%d  nrhs=%d \n",nlhs,nrhs);
    
    /* Check for proper number of arguments */
    if (nrhs != 3) {
        mexErrMsgTxt("One input argument required.");
    } else if (nlhs != 13) {
        mexErrMsgTxt("Incorrect number of output arguments.");
    }

    m = mxGetM(prhs[0]);
    n = mxGetN(prhs[0]);

    num=m;

    if(n>m){num=n;}

    /* Create a matrix for the return argument */
    plhs[0]= mxCreateDoubleMatrix(NB+1, 1, mxREAL);
    plhs[1]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[2]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[3]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[4]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[5]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[6]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[7]= mxCreateDoubleMatrix(NB, 1, mxREAL);
    plhs[8]= mxCreateDoubleMatrix(NB, 1, mxREAL); 
    plhs[9]= mxCreateDoubleMatrix(1, 1, mxREAL);
    plhs[10]= mxCreateDoubleMatrix(MC, 1, mxREAL);
    plhs[11]= mxCreateDoubleMatrix(MC, 1, mxREAL);
    plhs[12]= mxCreateDoubleMatrix(1, 1, mxREAL);
    
    /* Assign pointers to the various parameters */


    L           = mxGetPr(plhs[0]);
    C           = mxGetPr(plhs[1]);
    AverageAmp  = mxGetPr(plhs[2]);
    MaxAmp      = mxGetPr(plhs[3]);
    MinMean     = mxGetPr(plhs[4]);    
    AverageMean = mxGetPr(plhs[5]);
    MaxMean     = mxGetPr(plhs[6]);   
    MinValley   = mxGetPr(plhs[7]);
    MaxPeak     = mxGetPr(plhs[8]);
    D           = mxGetPr(plhs[9]);
    ac1         = mxGetPr(plhs[10]);
    ac2         = mxGetPr(plhs[11]);
    cL          = mxGetPr(plhs[12]);

    y = mxGetPr(prhs[0]);
    dchoice = mxGetPr(prhs[1]);
    exponent= mxGetPr(prhs[2]);

    /* Call the rainflow_cpp function. */
//    mexPrintf(" Call the rainflow_cpp function \n");

    rainflow_cpp(L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,cL,y,dchoice,exponent,num);
}
