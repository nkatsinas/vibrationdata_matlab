%
disp(' ');
disp(' pseudo_inverse.m  ver 1.1  January 11, 2010 ');
disp(' by Tom Irvine ');
disp(' ');
disp(' Pseudo Inverse of a Semidefinite Symmetric Matrix  ');
disp(' ');
%
%  References:
%  http://web.mit.edu/be.400/www/SVD/Singular_Value_Decomposition.htm
%  http://www.cse.unr.edu/~bebis/MathMethods/SVD/lecture.pdf
%  http://www.mathworks.com/access/helpdesk/help/techdoc/ref/svd.html
%  http://www.ling.ohio-state.edu/~kbaker/pubs/Singular_Value_Decomposition_Tutorial.pdf
%  http://www.miislita.com/information-retrieval-tutorial/singular-value-de
%  composition-fast-track-tutorial.pdf
%  http://www.cs.iastate.edu/~cs577/handouts/svd.pdf
%  http://www.ee.ic.ac.uk/hp/staff/dmb/matrix/decomp.html
%  http://www.utdallas.edu/~herve/Abdi-SVD2007-pretty.pdf
%
%  Note that Matlab already has a built-in function:
%  [U,S,V] = svd(X)
%
%  This script is meant to demonstate the underlying calculation.
%
clear A;
clear W1;
clear W2;
clear S;
clear U;
clear V;
clear yhat;
clear temp;
%
A = input(' Enter matrix name ');
%
sz=size(A);
nr=sz(1);
nc=sz(2);
%
if(nr~=nc)
    disp(' Error: matrix must be square ');
else
%
disp(' ');
disp(' ********** Method 1:  SVD ********** ');
disp(' ');
%
%
    W1=zeros(nr,nr);
    W2=zeros(nc,nc);
    S=zeros(nr,nc);
    U=zeros(nr,nr);
    V=zeros(nc,nc);
%
    W1=A*A';
    W2=A'*A;
%
% Calculate U
%
    [MS2,Eig2]=eig(W2)
%
    for(i=1:nc)
        j=nc+1-i;
        U(:,i)=MS2(:,j);
    end
%
    for(i=1:nc)
        k=nc+1-i;
        S(i,i)=sqrt(Eig2(k,k));
    end
%
    A
    U
    S
    U*S*U'
    error1=A-U*S*U'
%
    clear SS;
    SS=zeros(nc,nc);
    for(i=1:nc)
        if(abs(S(i,i))>1.0e-04)
            SS(i,i)=1/S(i,i);
        end
    end
    disp(' pseudo-inverse matrix ');    
    PI=U*SS*U'
    PIA=PI*A
    error2=A-(A*PI*A);
%
    disp(' ');
    disp(' ********** Method 2:  Ben-Israel & Cohen ********** ');
    disp(' ');
%
    sz=size(A);
    n=sz(1);
    clear Ap;
    bb=max(max(A));
    scale=2/bb;
    scale=scale/10;
    Ap=scale*A;
%
    error_before=0.;
    for(i=1:1000)    
        Ap=(2*Ap)-((Ap*A)*Ap);
        
        error=0.;
        
        temp=Ap*A;
        for(j=1:n)
           error=error+abs(temp(j,j)-1.);
        end
        
        if(abs(error-error_before)<0.001 && i>5)
           break;
        end    
        error_before=error;
    end
    disp(' pseudo-inverse matrix ');
    Ap
end