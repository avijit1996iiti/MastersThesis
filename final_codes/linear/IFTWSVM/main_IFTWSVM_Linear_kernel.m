%Dataset Loading
clc;
clear all;
close all;
file1 = fopen('L_IFTSVM_final_last.txt','a+');


for load_file =111:115%%[72,73,35,38,39,59,60,64,63,71,56,76,38,39]%[40,41,19,75,69,33,37,47,61]%[40,41,19,75,69,33,37,47]%[56,76,60]%73%59%[56,76,60]%[40,41,19,75,69,33,37,47]

   
    %% to load file
    switch load_file
        case 101
file='acute-inflammation_R';


case 102
file='acute-nephritis_R';



case 103
file='breast-cancer_R';


case  104
file='breast-cancer-wisc_R';


case  105 
file='breast-cancer-wisc-prog_R';



case  106
file='credit-approval_R';




case   107
file='echocardiogram_R';




case  108
file='haberman-survival_R';

case  109
file='heart-hungarian_R';
case  110
file= 'heart-switzerland_R';

case 111
file= 'hepatitis_R';

case 112
file= 'mammographic_R';


case  113
file= 'planning_R';


case   114 
file= 'parkinsons_R';


case 115
file= 'molec-biol-promoter_R';

        
        
        case 79
            file='ndc1k';
        case 78
            file='avijit';
          
        case 77
            file='avijits_selfmade_dataset';
        case 73
            file='crossplane150';           
        case 74
            file='glass5';

        case 75
             file='heart-stat';
    
        case 76
             file='monk3';
    
        case 61
            file = 'cmc';
            
        case 57
            file = 'ecoli-0-1_vs_2-3-5';
        case 7
            file = 'ecoli-0-1_vs_5';
            test_start =121;
            cvs1=10;
            mus=32;
            
       case 65
            file = 'ecoli-0-1-4-7_vs_5-6';
            test_start =151;
            cvs1=10;
            mus=8;
       case 58
            file = 'ecoli-0-2-3-4_vs_5';
            test_start =101;
            cvs1=10;
            mus=2;
       case 62
            file = 'ecoli-0-2-6-7_vs_3-5';
            test_start =111;
            cvs1=10;
            mus=0.5;
       case 9
            file = 'ecoli-0-3-4-6_vs_5';
            test_start =101;
            cvs1=1e-005;
            mus=8;
       case 5
            file = 'ecoli-0-4-6_vs_5';
            test_start =101;
            cvs1=1;
            mus=2;
       case 3
            file = 'ecoli-0-6-7_vs_3-5';
            test_start =111;
            cvs1=10;
            mus=4;
       case 10
            file = 'ecoli-0-6-7_vs_5';
            test_start =111;
            cvs1=10;
            mus=4;
      case 6
            file = 'ecoli4';
            test_start =151;
            cvs1=10;
            mus=4;
      %case 30
       %     file = 'glass-0-1-4-6_vs_2';
        %    test_start =101;
         %   cvs1=10;
          %  mus=4;
      %case 13
       %     file = 'glass-0-1-5_vs_2';
        %    test_start =81;
         %   cvs1=10;
          %  mus=4;
    % case 14
     %       file = 'glass-0-1-6_vs_2';
      %      test_start =101;
       %     cvs1=10;
        %    mus=4;
     case 15
            file = 'segment0';
            test_start =501;
            cvs1=10;
            mus=4;
     %case 16
      %      file = 'glass-0-1-6_vs_5';
       %     test_start =91;
        %    cvs1=10;
         %   mus=4;
     %case 17
      %      file = 'glass-0-4_vs_5';
       %     test_start =51;
        %    cvs1=10;
         %   mus=4;
    % case 18
          %  file = 'glass-0-6_vs_5';
           % test_start =51;
            %cvs1=10;
            %mus=4;
     case 4
            file = 'glass2';
            test_start =101;
            cvs1=10;
            mus=4;
    %case 20
     %       file = 'heart-stat';
      %      test_start =131;
       %     cvs1=10;
        %    mus=4;
    case 21
            file = 'led7digit-0-2-4-5-6-7-8-9_vs_1';
            test_start =221;
            cvs1=10;
            mus=4;
     case 22
             file = 'ripley';
             test_start =601;
             cvs1=10;
             mus=4;
    %case 23
     %       file = 'shuttle-c0-vs-c4';
      %      test_start =901;
       %     cvs1=10;
           % mus=4;
    case 24
            file = 'yeast-0-2-5-6_vs_3-7-8-9';
            test_start =501;
            cvs1=10;
            mus=4;
    case 25
            file = 'yeast-0-2-5-7-9_vs_3-6-8';
            test_start =501;
            cvs1=10;
            mus=4;
    case 26
            file = 'yeast-0-3-5-9_vs_7-8';
            test_start =251;
            cvs1=10;
            mus=4;  
   case 27
            file = 'yeast-0-5-6-7-9_vs_4';
            test_start =251;
            cvs1=10;
            mus=4;  
  case 28
            file = 'yeast-2_vs_4';
            test_start =251;
            cvs1=10;
            mus=4;        
            
   case 29
            file = 'ecoli-0-1-4-6_vs_5';
            test_start =151;
            cvs1=10;
            mus=4;    
    case 12
            file = 'ecoli-0-1-4-7_vs_2-3-5-6 ';
            test_start =151;
            cvs1=10;
            mus=4; 
            
    case 31
             file = 'haber';
             test_start =201;
             cvs1=1;
             mus=32;
       case 32
            file = 'ecoli2';
            test_start =151;
            cvs1=10;
            mus=32;
       case 2
            file = 'glass4';
            test_start =151;
            cvs1=10;
            mus=32;
            
%        case 34
%             file = 'vowel';
%             test_start =501;
%             cvs1=10;
%             mus=8;
       case 35
            file = 'brwisconsin';
            test_start =301;
            cvs1=10;
            mus=2;
       case 36
            file = 'ecoli3';
            test_start =151;
            cvs1=10;
            mus=0.5;
       case 8
            file = 'abalone9-18';
            test_start =351;
            cvs1=1e-005;
            mus=8;
       case 38
            file = 'vehicle 1';
            test_start =401;
            cvs1=1;
            mus=2;
       case 39
            file = 'vehicle2';
            test_start =401;
            cvs1=10;
            mus=4;
       case 1
            file = 'shuttle-6_vs_2-3';
            test_start =101;
            cvs1=10;
            mus=4;
      case 69
            file = 'pima';
            test_start =536;
            cvs1=10;
            mus=4;
        case 70
            file = 'new-thyroid1';
           test_start =101;
  %          cvs1=10;
   %         mus=4;
      case 43
            file = 'yeast3';
            test_start =501;
            cvs1=10;
            mus=4;
     case 44
            file = 'yeast1';
            test_start =501;
            cvs1=10;
            mus=4;
%      case 45
%             file = 'segment0';
%             test_start =501;
%             cvs1=10;
%             mus=4;
     case 46
            file = 'yeast1vs7';
            test_start =201;
            cvs1=10;
            mus=4;
     case 11
            file = 'yeast2vs8';
            test_start =251;
            cvs1=10;
            mus=4;
     case 48
            file = 'ecoli0137vs26';
            test_start =181;
            cvs1=10;
            mus=4;
     case 49
            file = 'yeast5';
            test_start =501;
            cvs1=10;
            mus=4;
%     case 50
%             file = 'cleve';
%             test_start =151;
%             cvs1=10;
%             mus=4;
%     case 51
%             file = 'wpbc';
%             test_start =101;
%             cvs1=10;
%             mus=4;
%     case 52
%             file = 'votes';
%             test_start =301;
%             cvs1=10;
%             mus=4;
%     case 53
%             file = 'aus';
%             test_start =301;
%             cvs1=10;
%             mus=4;
%     case 54
%             file = 'transfusion';
%             test_start =351;
%             cvs1=10;
%             mus=4;
%     case 55
%             file = 'iono';
%             test_start =201;
%             cvs1=10;
%             mus=4;
    case 56
            file = 'monk2';
            test_start =301;
            cvs1=10;
            mus=4;  
        
           case 33
            file = 'aus';
            test_start =501;
            cvs1=1;
       case 37
            file = 'bupa or liver-disorders';
            test_start =251;
            cvs1=1;
       case 59
            file = 'cleve';
            test_start =151;
            cvs1=1;
        case 60
             file = 'haberman';
             test_start =201;
             cvs1=0.01;
       case 40
            file = 'iono';
            test_start =251;
            cvs1=0.01;
       case 47
            file = 'sonar';
            test_start =180;
            cvs1=10;
       case 63
            file = 'transfusion';
            test_start =501;

       case 64
            file = 'votes';
            test_start =301;
            cvs1=10;
       case 19
            file = 'wpbc';
            test_start =131;
            cvs1=1;
       case 66
            file = 'vowel';
            test_start =501;
            cvs1=10;
            mus=8;
       case 67
            file = 'brwisconsin';
            test_start =301;
            cvs1=10;
            mus=2;     
             case 68
            file = 'ripley';
            test_start =401;
            cvs1=10;
            mus=2;
           
              case 41
            file = 'wdbc';
            test_start =401;
            cvs1=10;
            mus=2;
        case 71
            file='checkerboard_Data';
test_start=480;

        case 72

file='crossplane130';
test_start=90;
        case 73
file='crossplane150';
test_start=105;
            
            
        otherwise
            continue;
    end
%No of Crossvalidation
    no_part = 5.0;
%hyperparameters
%mew_=2;
%C1_=1,C2_=1;
C1_=[10^-5,10^-4,10^-3,10^-2,10^-1,10,10^2,10^3,10^4,10^5];
C2_=[10^-5,10^-4,10^-3,10^-2,10^-1,10,10^2,10^3,10^4,10^5];
%C2_=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%C1_=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];
%alpha_d1=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
%2^-10,2^-9,2^-8,2^-7,2^-6, ,2^6,2^7,2^8,2^9,2^10 2^-5,2^-4,2^-3,2^-2, 2^-1,
%mew_=[2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10]
mew_=[2,2^2,2^3,2^4,2^5];
%mew_=[2^-1,2,2^2,2^3,2^4,2^5]
%loading data from the source folder
filename = strcat('./newd/',file,'.dat');
filename
A = load(filename);
A=A(:,2:end);
A = A(randperm(size(A, 1)), :);
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

    [lengthA,n] = size(A);
    max_accuray = -10^-10.;
   
    
for al=1:length(mew_)
    mew=mew_(al);
    
  for C1 = 1:length(C1_)
            C1 = C1_(C1);
            C3=C1;
            
             for C2 = 1:length(C2_)
           
                C2 = C2_(C2);
               C4=C2;
                    avgaccuracy = 0;
                    block_size = lengthA/(no_part*1.0);
                    part = 0;
                    t_1 = 0;
                    t_2 = 0;
                    while ceil((part+1) * block_size) <= lengthA
                   %% seprating testing and training datapoints for
                   % crossvalidation
                                t_1 = ceil(part*block_size);
                                t_2 = ceil((part+1)*block_size);
                                B_t = [A(t_1+1 :t_2,:)];
                                Data = [A(1:t_1,:); A(t_2+1:lengthA,:)];
                                [accuracy_1,alpha_d,mew]=L_IFLSTWSVM(Data,B_t,C1,C2,mew);
                                avgaccuracy = avgaccuracy + accuracy_1;
                                part = part+1
                    end
%% updating optimum C1,C2
           if avgaccuracy > max_accuray
               max_accuray = avgaccuracy;
               min_C1 = C1;
               min_C2=C2;
               %min_alpha_d=alpha_d;
               min_mew=mew;
           end
             end
  end
  end
  [accuracy,alpha_d,mew]=L_IFLSTWSVM(A,A_test,min_C1,min_C2,min_mew);
  fprintf(file1,'%s\tsize(A,1)=%g\tsize(A_test,1)=%g\taccuracy=%g\tmin_C1=%g\tmin_C2=%g\talpha_d=%g\tmew=%g\n',file,size(A,1),size(A_test,1),accuracy,min_C1,min_C2,alpha_d,mew);

end

  


    
    
    
    
