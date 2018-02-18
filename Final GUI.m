clc;
clear all;
close all;
repeat=1;
while(repeat==1)
   choice=menu('EMOTION DETECTION VIA SPEECH','TRAIN & VALIDATE DATABASE','TEST DATA','Exit');
switch choice 
   case 1
       FIRST_create_training_values
       
       case 2
           Second_neural_svm_new_data_class
        case 3
               repeat =0;
               clear all;
               close all;
               clc;
end 
    
    
end