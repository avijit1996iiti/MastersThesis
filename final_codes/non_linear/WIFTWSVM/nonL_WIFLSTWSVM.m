function [accuracy,alpha_d,k]=nonL_WIFLSTWSVM(A,A_test,C1,C2,mew,K)
C3=C1;C4=C2;
[no_input,no_col]=size(A);[m_test,n_test]=size(A_test);
x0=A(:,1:no_col-1);y0=A(:,no_col);
xtest0=A_test(:,1:n_test-1);ytest0=A_test(:,n_test);
Cf=[x0 y0];
tic
[S1,S2,alpha_d]=linear_score_values1(A,mew);
[ro1,ro2,k]=linear_W_interclass_weights(A,mew,K);
time1=toc;
%  C=nufuzz(Cf,c0);
%[no_input,no_col]=size(C);
 % mem=C(:,no_col);
 % C=C(:,1:no_col-1);
 
%  [no_input,no_col]=size(C);

%  obs = C(:,no_col);    
  A1 = [];
 B1 = [];
 
 for i = 1:no_input
    if(y0(i)== 1)
        A1=[A1;A(i,1:no_col-1)];
    else
        B1=[B1;A(i,1:no_col-1)];
    end
 end
C=[A1;B1];
[x y]=size(A1);
[x1 y1]=size(B1);
K1 = zeros (x,x+x1);
K2 = zeros (x1,x1+x);
K3=zeros(size(A_test,1),x+x1);
K4=zeros(x+x1,x+x1);               %       (repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))-2*(u*v')+repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)));
K1 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A1.^2,2).^2),1,size(A,1))-2*(A1*A(:,1:end-1)')+repmat(sqrt(sum(A(:,1:end-1).^2,2)'.^2),size(A1,1),1)));
K2 = exp(-(1/(mew^2))*(repmat(sqrt(sum(B1.^2,2).^2),1,size(A,1))-2*(B1*A(:,1:end-1)')+repmat(sqrt(sum(A(:,1:end-1).^2,2)'.^2),size(B1,1),1)));    
K3 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A_test(:,1:end-1).^2,2).^2),1,size(A,1))-2*(A_test(:,1:end-1)*A(:,1:end-1)')+repmat(sqrt(sum(A(:,1:end-1).^2,2)'.^2),size(A_test,1),1)));    
K4 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A(:,1:end-1).^2,2).^2),1,size(A,1))-2*(A(:,1:end-1)*A(:,1:end-1)')+repmat(sqrt(sum(A(:,1:end-1).^2,2)'.^2),size(A,1),1)));


%----------------Training-------------
% A=x0(find(y0(:,1)>0),:);B=x0(find(y0(:,1)<=0),:);

m1=size(A1,1);m2=size(B1,1);m3=size(C,1);
e1=ones(m1,1);e2=ones(m2,1);

%S1=diag(S1);%fprintf("size of S1 is %d",size(S1))
%ro1=diag(ro1);ro2=diag(ro2);
%S2=diag(S2);%fprintf("size of S2 is %d",size(S2))
T=[S2.*K2 S2.*e2];%fprintf("size of T is %d",size(T))
TtT=T'*T;%fprintf("size of TtT is %d",size(TtT))
R=[ro1.*K1 ro1.*e1];%fprintf("size of R is %d",size(R))
RtR=R'*R;%fprintf("size of RtR is %d",size(RtR))
I=eye(size(RtR,1));%fprintf("size of I is %d",size(I))
%fprintf("size of e2 is %d",size(e2))
%fprintf("size of T' is %d",size(T'))
%fprintf("size of S1 is %d",size(S1))
%size(T'*(S2.*e2));
u1=-(C1.*TtT+RtR+C2.*I)\T'*(S2.*e2);
T=[ro2.*K2 ro2.*e2];
TtT=T'*T;
R=[S1.*K1 S1.*e1];RtR=R'*R;
I=eye(size(RtR,1));
u2=(C3.*TtT+RtR+C4.*I)\R'*(S1.*e1);


% mem1=ones(size(mem,1),1)-mem;
% u1=-inv(HTH+(diag(1./(c*[mem; 1])).*GTG)+(1e-5*speye(size(HTH,1))))*H'*e2;
% u2=inv(GTG+(diag(1./(c*[mem; 1])).*HTH)+(1e-5*speye(size(GTG,1))))*G'*e1;

% u1=-inv(HTH+(1/c*GTG)+(1e-5*speye(size(HTH,1))))*H'*e2;
% u2=inv(GTG+(1/c*HTH)+(1e-5*speye(size(GTG,1))))*G'*e1;
train_Time=time1+toc;
%---------------Testing---------------

no_test=size(xtest0,1);
preY1=[];
preY2=[];
%for i=1:no_test
 %   py1=norm(u1(1:size(u1,1)-1,:).*xtest0(i,:) + u1(size(u1,1),:))/norm(u1(1:size(u1,1)-1,:));
  %  py2=norm(u2(1:size(u2,1)-1,:).*xtest0(i,:) + u2(size(u2,1),:))/norm(u2(1:size(u2,1)-1,:));
   % preY1=[preY1;py1];
    %preY2=[preY2;py2];
%end    
     preY2=(K3*u2(1:size(u2,1)-1,:)+u2(size(u2,1),:))/sqrt(u2(1:size(u2,1)-1,:)'*K4*u2(1:size(u2,1)-1,:));
    preY1=(K3*u1(1:size(u1,1)-1,:)+u1(size(u1,1),:))/sqrt(u1(1:size(u1,1)-1,:)'*K4*u1(1:size(u1,1)-1,:));
predicted_class=[];
for i=1:no_test
    if abs(preY1(i))< abs(preY2(i))
        predicted_class=[predicted_class;1];
    else
        predicted_class=[predicted_class;-1];
    end

end
 err = sum(predicted_class ~= ytest0);
 accuracy=(no_test-err)/(no_test)*100
 %%%%%%%Imbalance accuracy

return
end
