function [ro1,ro2,k]=linear_W_interclass_weights(A,mew,K)
k=K;
[m,n]=size(A)
A1=[];
B1=[];
for i=1:m
if A(i,n)==1
    A1=[A1;A(i,:)];
else 
    B1=[B1;A(i,:)];
end 
end

N = size(A1,1);
ro1=[];
for i=1:N
    W=[];
    dists = zeros(N,1);
    for j = 1 : N
     diff= norm(A1(j,size(A1,2)-1) - A1(i,size(A1,2)-1));
     dists(j)=diff;%using the distance measure from IFTWSVM
end

[d,ind] = sort(dists);
t=mew;%t is hot kernel parameter, Weighted least square projection with twin svm with local information
for j=1:k
    z=d(j)*d(j)/t;
    z=1/exp(z);%eqn no 20 above mentioned paper 
    W=[W z];
end
    ro1=[ro1;sum(W)];
end
M = size(B1,1);
ro2=[];
for i=1:M
    W=[];
    dists = zeros(M,1);
    for j = 1 : M
    diff= norm(B1(j,size(B1,2)-1) - B1(i,size(B1,2)-1));
    dists(j)=diff;
end

[d,ind] = sort(dists);
for j=1:k
    z=d(j)*d(j)/t;
    z=1/exp(z);
    W=[W z];
end
    ro2=[ro2;sum(W)];
end