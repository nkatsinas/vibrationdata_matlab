
//   range_pair_counting_mex.cpp  ver 1.0  May 11, 2015

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

    //mexPrintf(" ref 1 \n");
    
    for(long i=0;i<MC;i++)
    {    
        ac1[i]=0.;
        ac2[i]=0.;
    }    
    
    //    mexPrintf(" NP=%ld \n",NP);
                      
    //mexPrintf(" ref 2 \n");
    
    DYNAMIC_MATRIX(B,num,4);

    //mexPrintf(" ref 3 \n");    
    
    double slope1,slope2;

    float mina,maxa;

    float X,Y;
    float Xabs,Yabs;
    float ymax;
    
    float a1,a2,a3;
    
    int ione,itwo,ithree;

    long kv;

    long hold;
    long i,j,k,n;

    long nkv=0;
    
    long nn=0;


    long last_a;
    long mm;

    long NP=num+1;
//    mexPrintf(" NP=%ld \n",NP);

	vector<float> a;
    
	k=0;

//	a[k]=y[k];
    a.push_back(y[k]);

	k=1;
    
//        mexPrintf(" ref 4 \n");

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
        
       //     mexPrintf(" ref 5 \n");

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
    
        //mexPrintf(" ref 6 \n");

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
        
     //       mexPrintf(" ref 7 \n");

//	num=long(maxa-mina)+1;

	n=0;
	i=0;
	j=1;

	float sum=0;

	kv=0;

//    mexPrintf("\n percent completed \n");
    
    
//*************************************************************************    

    n=last_a-1;
    mm=n;

    k=1;


    i=1;

    a1=a[0];
    a2=a[1];
    a3=a[2];
    
    ione=0;
    itwo=1;
    ithree=2;
   
   //     mexPrintf(" ref 8 \n");
    
    while(1)
    {
//        mexPrintf("\n ione=%d itwo=%d ithree=%d\n",ione,itwo,ithree);
//        mexPrintf(" a1=%8.4g a2=%8.4g a3=%8.4g \n",a1,a2,a3);
        
        
        Xabs=fabs(a3-a2);
        Yabs=fabs(a2-a1); 
        
//         mexPrintf(" Xabs=%8.4g Yabs=%8.4g \n",Xabs,Yabs);
 
        if( Xabs<Yabs)
        {
            
            if(ione>=(last_a-2) || itwo>=(last_a-1) || ithree>=a.size())
            {
  //              mexPrintf(" reverse \n");
         
                i=0;
            
                std::reverse(std::begin(a), std::end(a));
 
                a1=a[0];
                a2=a[1];
                a3=a[2];
 
                ione=0;
                itwo=1;
                ithree=2;
            }
            
            ione++;
            itwo++;
            ithree++;
           
            a1=a2;  
            a2=a3;             
            a3=a[ithree];
 
//                    mexPrintf("\n      ione=%d itwo=%d ithree=%d\n",ione,itwo,ithree);
            
            
        }
        else
        {
                      
//                    mexPrintf(" Yabs=%8.4g \n",Yabs);
            
            B[kv][3]=a[ione];
            B[kv][2]=a[itwo];
            B[kv][1]=1.;
            B[kv][0]=Yabs;
            ac1[kv]=0.5*B[kv][0];
            ac2[kv]=B[kv][1];      
            kv++;
            
//            if(kv==3){break;}
            
 
            a.erase(a.begin()+itwo); 
            a.erase(a.begin()+ione); 
 
            if(a.size()<3)
            {
                break;
            }
        
 
            a1=a[0];
            a2=a[1];
            a3=a[2];
 
            ione=0;
            itwo=1;
            ithree=2;        
        }
    }
	

    
//*************************************************************************

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
    
 //       mexPrintf(" ref 9 \n");


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
