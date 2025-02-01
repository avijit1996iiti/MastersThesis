%Dataset Loading
clc;
clear all;
close all;
file1 = fopen('L_IFTSVM_finalresultf.txt','a+');


for load_file =1:15%%[72,73,35,38,39,59,60,64,63,71,56,76,38,39]%[40,41,19,75,69,33,37,47,61]%[40,41,19,75,69,33,37,47]%[56,76,60]%73%59%[56,76,60]%[40,41,19,75,69,33,37,47]

   
    %% to load file
    switch load_file
       case 1
file='iono';
	min_C1=1000;	min_C2=1000;
	mew=4;
	case 2
	file='wdbc';
	min_C1=10;
	min_C2=1e-05	;mew=2;

case 3
	
file='wpbc';
	min_C1=10;	min_C2=100	;mew=32;
	case 4
file='heart-stat';	min_C1=1e-05;	min_C2=10;	mew=4;
case 5
file='pima';min_C1=1e-05;	min_C2=100;		mew=2;
case 6
file='aus';
min_C1=10000;	min_C2=10000;	mew=2;
case 7

file='bupa or liver-disorders';	min_C1=100;	min_C2=100000;	mew=4;
case 8

file ='sonar';		min_C1=10;	min_C2=1e-05;	mew=4;
case 9 
file ='cmc';	min_C1=1000;	min_C2=1e-05;	mew=32;
case 10 
file ='crossplane130';	min_C1=1e-05;	min_C2=1e-05	;mew=2;
case 11

file ='crossplane150';	min_C1=1e-05;	min_C2=1e-05	;mew=2;
case 12 
file='brwisconsin';min_C1=10000;	min_C2=1e-05;mew=4;
case 13

file='vehicle 1';	min_C1=0.1;	min_C2=100	;mew=2;
case 14

file='vehicle2';	min_C1=0.1;	min_C2=10;	mew=4;
case 15

file='cleve';
	min_C1=100;	min_C2=1e-05;	mew=8;
	case 16
	
file='haberman';		min_C1=1e-05;	min_C2=10;	mew=4;
case 17

file='votes';	min_C1=1e-05;	min_C2=1000;	mew=2;
case 18
file='transfusion';	min_C1=10000;	min_C2=10000;	mew=8;
case 19
file='checkerboard_Data';	min_C1=10000;	min_C2=10000;	mew=2;
case 20
file='monk2';		min_C1=1e-05;	min_C2=100;	mew=4;
case 21
file='monk3';		min_C1=100;	min_C2=10;	mew=4;
case 22
file='ripley';	min_C1=1000;	min_C2=1e-05;	mew=8;
case 23
file='acute-inflammation_R';	min_C1=1e-05;	min_C2=1e-05;	mew=2;
case 24
file='acute-nephritis_R';		min_C1=1e-05;	min_C2=1e-05; mew=2;
case 25
file='breast-cancer_R';		min_C1=1000;	min_C2=10;mew=32;
case 26

file='breast-cancer-wisc_R'	;min_C1=1000;	min_C2=1e-05;mew=2;
case 27

file='breast-cancer-wisc-prog_R';	min_C1=100;	min_C2=1e-05;	mew=16;
case 28
file='credit-approval_R';		min_C1=1e-05;	min_C2=0.1;	mew=32;
case 29
file='echocardiogram_R';min_C1=0.01;	min_C2=10;	mew=2;
case 30

file='haberman-survival_R';	min_C1=100;	min_C2=10;	mew=2;
case 31
file='heart-hungarian_R';	min_C1=1000;	min_C2=1e-05;	mew=32;
case 32
file='hepatitis_R';		min_C1=100;	min_C2=100;	mew=2;
case 33

file='mammographic_R';	min_C1=1000;	min_C2=100000;	mew=2;
case 34
file='planning_R';	min_C1=1e-05;	min_C2=100;	mew=2;
case 35

file='parkinsons_R';		min_C1=0.1;	min_C2=1e-05;	mew=2;
case 36

file='molec-biol-promoter_R';	min_C1=10;	min_C2=100	;mew=8;


            
            
        otherwise
            continue;
    end

%loading data from the source folder
filename = strcat('./newd/',file,'.txt');
filename
A = load(filename);
%A=A(:,2:end);
%A = A(randperm(size(A, 1)), :);
[m,n] = size(A);
%ratio of train test split
test_start=m*0.5;
%define the class level +1 or -1 (label_encoder)

    for i=1:m
        if A(i,n)==0
            A(i,n)=-1;
        end
    end
%split the data into training and testing dataset 

    test = A(test_start:m,:);
    train = A(1:test_start-1,:);
%separate the class labels and features 
[no_input,no_col] = size(train);
x1 = train(:,1:no_col-1);
y1 = train(:,no_col);

    [no_test,no_col] = size(test);
    xtest0 = test(:,1:no_col-1);
    ytest0 = test(:,no_col);
%to add noise uncomment the below lines 
%[m,n] = size(x1);
    %noise=wgn(m,n,1);
    %x1=x1+noise;
%normalize the training and testing data
[M,D]=size(x1);
m=mean(x1);std_dev=std(x1);
for d=1:D%centre data
    if(std_dev(d)~=0)
        x1(:,d) = (x1(:,d) - m(d))/std_dev(d);
        xtest0(:, d) = (xtest0(:, d) - m(d))/std_dev(d);
    end
end
%Combining all the column in one variable
    A=[x1 y1];    %training data
    [m,n] = size(A);
    A_test=[xtest0,ytest0];    %testing data
 %% initializing crossvalidation variables

  [accuracy,alpha_d,mew,sensitivity,specificity,training_time]=L_IFLSTWSVMf(A,A_test,min_C1,min_C2,mew);
  fprintf(file1,'%s\taccuracy=%g\tmin_C1=%g\tmin_C2=%g\talpha_d=%g\tmew=%g\tsensitivity=%g\tspecificity=%g\ttraining_time=%g\n',file,accuracy,min_C1,min_C2,alpha_d,mew,sensitivity,specificity,training_time);

end

  


    
    
    
    
