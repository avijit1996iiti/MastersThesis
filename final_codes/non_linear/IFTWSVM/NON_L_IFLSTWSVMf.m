function [accuracy,alpha_d,mew,sensitivity,specificity,training_time]=NON_L_IFLSTWSVMf(A,A_test,C1,C2,mew)
tic
C3=C1;C4=C2;
[no_input,no_col]=size(A);[m_test,n_test]=size(A_test);
x0=A(:,1:no_col-1);y0=A(:,no_col);
xtest0=A_test(:,1:n_test-1);ytest0=A_test(:,n_test);
[S1,S2,alpha_d,mew]=linear_score_values1(A,mew);
%writematrix(S1,'S1.csv');
%dlmwrite(strcat(file,'S1','.csv'),S1,'-append');
%dlmwrite(strcat(file,'S2','.csv'),S2,'-append');
%writematrix(S2,'S2.csv');
%[ro1,ro2]=Non_linear_interclass_weights(A,mew);
Y_Test=A_test(:,n_test);
X_Test=A_test(:,n_test-1);  


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
P=[K2 e2];%fprintf("size of T is %d",size(T))
PtP=P'*P;%fprintf("size of TtT is %d",size(TtT))
R=[K1 e1];%fprintf("size of R is %d",size(R))
RtR=R'*R;%fprintf("size of RtR is %d",size(RtR))
I=eye(size(RtR,1));%fprintf("size of I is %d",size(I))
%fprintf("size of e2 is %d",size(e2))
%fprintf("size of T' is %d",size(T'))
%fprintf("size of S1 is %d",size(S1))
%size(T'*S2*e2);
H=(P/(RtR+C1*I))*P';f=-e2;
X0=[];
opts = optimset('Algorithm','interior-point-convex');
alpha=quadprog(H,f,[],[],[],[],zeros(m2,1),C2*S2,X0,opts);
%dlmwrite(strcat(file,'alpha','.csv'),alpha,'-append');
u1=-(RtR+C1*I)\P'*alpha;
%dlmwrite(strcat(file,'u1','.csv'),u1,'-append');
I=eye(size(PtP,1));
H=(R/(PtP+C3*I))*R';f=-e1;
opts = optimset('Algorithm','interior-point-convex');
X0=[];
beta=quadprog(H,f,[],[],[],[],zeros(m1,1),C4*S1,X0,opts);
%dlmwrite(strcat(file,'beta','.csv'),beta,'-append');
u2=(PtP+C3*I)\R'*beta;
training_time=toc;
%dlmwrite(strcat(file,'u2','.csv'),u2,'-append');

%---------------Testing---------------

no_test=size(xtest0,1);
preY1=[];
preY2=[];
%for i=1:no_test
 %   py1=abs(u1(1:size(u1,1)-1,:)*xtest0(i,:) + u1(size(u1,1),:))/norm(u1(1:size(u1,1)-1,:));
  %  py2=abs(u2(1:size(u2,1)-1,:).*xtest0(i,:) + u2(size(u2,1),:))/norm(u2(1:size(u2,1)-1,:));
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
 accuracy=((no_test-err)/(no_test))*100;
 tp=sum((predicted_class==1)&(ytest0==1));
fp=sum((predicted_class==1)&(ytest0==-1));
tn = sum((predicted_class == -1) & (ytest0==-1));
fn = sum((predicted_class == -1) & (ytest0== 1));
sensitivity = tp/(tp + fn) ; %TPR;
specificity = tn/(tn + fp)  ;%TNR;



return
end
