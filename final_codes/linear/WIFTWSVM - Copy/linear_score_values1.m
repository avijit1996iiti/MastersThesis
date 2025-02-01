function [S1,S2,alpha_d,mew]=linear_score_values1(A,mew)
[no_input,no_col]=size(A);
obs = A(:,no_col);    
 A1 = [];
 B1 = [];
for i = 1:no_input
    if(obs(i) == 1)
        A1 = [A1;A(i,1:no_col-1)];
    else
        B1 = [B1;A(i,1:no_col-1)];
    end
end
[x y]=size(A1);
[x1 y1]=size(B1);
K1 = zeros (x,x);
K2 = zeros (x1,x1);
mew1=1/(mew^2);
K1 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A1.^2,2).^2),1,size(A1,1))-2*(A1*A1')+repmat(sqrt(sum(A1.^2,2)'.^2),size(A1,1),1)));
K2 = exp(-(1/(mew^2))*(repmat(sqrt(sum(B1.^2,2).^2),1,size(B1,1))-2*(B1*B1')+repmat(sqrt(sum(B1.^2,2)'.^2),size(B1,1),1)));    
K3 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A(:,1:end-1).^2,2).^2),1,size(A,1))-2*(A(:,1:end-1)*A(:,1:end-1)')+repmat(sqrt(sum(A(:,1:end-1).^2,2)'.^2),size(A,1),1)));    
%for i =1:x 
 %   for j =1:x
  %     nom = norm(A1(i ,:)-A1(j ,:));
   %    K1(i,j)=exp(-mew1*nom*nom);
   %end
%end
%for i =1:x1 
 %   for j =1:x1
  %     nom = norm(B1(i ,:)- B1(j ,:));
   %    K2(i,j)=exp(-mew1*nom*nom);
   %end
%end

%C=[A1;B1];
%        s = sum(K1,1)/x; 
%        h = sum(K2,1)/x1;
%distancec1=zeros(x,1);
%distancec2=zeros(x1,1);

 
%for i = 1:x1
 %  %diff = norm(K2(i,1:no_col-1) - h(1:no_col-1));
  % diff=sqrt(2-2*exp(-(norm(K2(i,1:end) - h(1:end))^2)*mew1));
   %distancec2(i)=diff;
   %end

%for i = 1:x
 %  %diff = norm(K1(i,1:no_col-1) - s(1:no_col-1));
  % diff=sqrt(2-2*exp(-(norm(K1(i,1:end) - s(1:end))^2)*mew1));
   %distancec1(i)=diff;
%end
 radiusxp=sqrt(1-2*mean(K1,2)+mean(mean(K1)));%||k(xi+)-kcen+||^2
 radiusmaxxp=max(radiusxp);
  radiusxn=sqrt(1-2*mean(K2,2)+mean(mean(K2)));  %||k(xi-)-kcen-||^2
  radiusmaxxn=max(radiusxn);
%l=(size(K2,1));
%sum_all=sum(K2,'all')/l^2;
%r2=sqrt(K2+sum_all-2*sum(K2,2)/l);
%r2=max(distancec2);
%l=(size(K1,1));
%sum_all=sum(K1,'all')/l^2;
%r1=sqrt(K1+sum_all-2*sum(K1,2)/l);
%r1=max(distancec1);
alpha_d=max(radiusmaxxn,radiusmaxxp);
%alpha_min=min(r1,r2)/2;
%alpha_d=alpha_max;
%alpha_d=8;
mem1=[];
mem2=[];
for i=1:x
    mem1=[mem1;(1-radiusxp(i)/(radiusmaxxp+10^-7))];%IFTWSVM paper 22 no equation , calculating membership values for class 1 
end
for i=1:x1
    mem2=[mem2;(1-radiusxn(i)/(radiusmaxxn+10^-7))];%IFTWSVM paper 22 no equation , calculating membership values for class 2
end
ro=[];%non membership function values will be stored in ro 
%alpha is an adjustable parameter 
for i=1:no_input
    B1=[];%all points in the neighbourhood of x_i will be stored in B1
    for j=1:no_input
        %dis=sqrt(2-2*exp(-(mew1*(norm(A(i,1:no_col-1)-A(j,1:no_col-1))^2))));
        dis=sqrt(K3(i,i)+K3(j,j)-2*K3(i,j));
        if dis<= alpha_d
            B1=[B1;A(j,:)];
        end
    end    
    [x3,x4]=size(B1);
    count=0;
    for k=1:x3
        if A(i,no_col)~=B1(k,no_col)
            count=count+1;% counting number of inharmonious points in the neighbourhood 
        end
    end    
    x5=count/x3;
    ro=[ro;x5];
end

A2=[A(:,no_col) ro];
ro1=[];
ro2=[];
for i=1:no_input
    if A2(i,1)==-1
        ro2=[ro2;A2(i,2)];
    else
        ro1=[ro1;A2(i,2)];
    end    
end 

%dlmwrite(strcat(file,'ro2','.csv'),ro2,'-append');
%dlmwrite(strcat(file,'ro1','.csv'),ro1,'-append');
v1=[];
v2=[];
for i=1:size(mem1,1)
    v1=[v1;(1-mem1(i))*ro1(i)];%calculating nonmembership values 
end 
for i=1:size(mem2,1)
    v2=[v2;(1-mem2(i))*ro2(i)];
end
%dlmwrite(strcat(file,'v2','.csv'),v2,'-append');
%dlmwrite(strcat(file,'v1','.csv'),v1,'-append');
S1=[];
S2=[];
for i=1:size(v1,1)
    if v1(i)==0
        S1=[S1;mem1(i)];
    elseif (mem1(i)<=v1(i))
        S1=[S1;0];
    else 
        S1=[S1;(1-v1(i))/(2-mem1(i)-v1(i))];
    end
end
for i=1:size(v2,1)
    if v2(i)==0
        S2=[S2;mem2(i)];
    elseif (mem2(i)<=v2(i))
        S2=[S2;0];
    else 
        S2=[S2;(1-v2(i))/(2-mem2(i)-v2(i))];
    end
end      
end