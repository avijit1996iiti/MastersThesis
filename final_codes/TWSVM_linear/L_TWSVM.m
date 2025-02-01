function [accuracy]=L_TWSVM(A,A_test,C1)
C2=C1;
[no_input,no_col]=size(A);[m_test,n_test]=size(A_test);
x0=A(:,1:no_col-1);y0=A(:,no_col);
xtest0=A_test(:,1:n_test-1);ytest0=A_test(:,n_test);
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

%----------------Training-------------
% A=x0(find(y0(:,1)>0),:);B=x0(find(y0(:,1)<=0),:);

m1=size(A1,1);m2=size(B1,1);m3=size(C,1);eps=10^-7;
e1=ones(m1,1);e2=ones(m2,1);
P=[B1 e2];%fprintf("size of T is %d",size(T))
PtP=P'*P;%fprintf("size of TtT is %d",size(TtT))
R=[A1 e1];%fprintf("size of R is %d",size(R))
RtR=R'*R;%fprintf("size of RtR is %d",size(RtR))
I=eye(size(RtR,1));%fprintf("size of I is %d",size(I))
%fprintf("size of e2 is %d",size(e2))
%fprintf("size of T' is %d",size(T'))
%fprintf("size of S1 is %d",size(S1))
%size(T'*S2*e2);
H=(P/(RtR+eps.*I))*P';f=-e2;
X0=[];
opts = optimset('Algorithm','interior-point-convex');
alpha=quadprog(H,f,[],[],[],[],zeros(m2,1),C2.*e2,X0,opts);
%dlmwrite(strcat(file,'alpha','.csv'),alpha,'-append');
u1=-(RtR+eps*I)\P'*alpha;
%dlmwrite(strcat(file,'u1','.csv'),u1,'-append');
I=eye(size(PtP,1));
H=(R/(PtP+eps.*I))*R';f=-e1;
opts = optimset('Algorithm','interior-point-convex');
X0=[];
beta=quadprog(H,f,[],[],[],[],zeros(m1,1),C1.*e1,X0,opts);
%dlmwrite(strcat(file,'beta','.csv'),beta,'-append');
u2=(PtP+eps.*I)\R'*beta;
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
    preY2=(xtest0*u2(1:size(u2,1)-1,:)+u2(size(u2,1),:));
    preY1=(xtest0*u1(1:size(u1,1)-1,:)+u1(size(u1,1),:));


predicted_class=[];
for i=1:no_test
    if abs(preY1(i))< abs(preY2(i))
        predicted_class=[predicted_class;1];
    else
        predicted_class=[predicted_class;-1];
    end

end
 err = sum(predicted_class ~= ytest0);
 accuracy=((no_test-err)/(no_test))*100
 

return
end
