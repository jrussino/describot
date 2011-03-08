% describe_SCORBOT.M
% Sample - Runs describot with the dh paramaters and configuration 
% corresponding to the SCORBOT-ER V robot.
%
%   Joseph A. Russino, Kamini Balaji, and Alex Burtness 12/6/2009

clc
syms L0 L1 L2 L3 th1 th2 th3 th4 th5 real;
dh_parameters = [0 0 L0 th1; 0 pi/2 0 th2; L1 0 0 th3;L2 0 0 th4; 0 pi/2 L3 th5]
configuration = 'RRRRR'

% Note that if you want to specify a robot name, you need to put it in two
% layers of quotes. This is dumb, but not worth fixing right now.
describot(dh_parameters,configuration,'robotName','''SCORBOT''','verbose','true','generateReport','true');

load SCORBOTVars.mat
disp('***************')
disp('*** RESULTS ***')
disp('***************')
disp('T05 = ')
disp(T)
disp('5w5 =')
disp(w{5})
disp('5v5 =')
disp(v{5})
disp('Jacobian =')
disp(J)