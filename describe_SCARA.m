% describe_SCARA.M
% Sample - runs describot with the dh paramaters and configuration 
% corresponding to the SCARA robot.
%
%   Joseph A. Russino, Kamini Balaji, and Alex Burtness 12/6/2009

clc
syms L0 L1 L2 d3 L4 th1 th2 th3 th4 real;
dh_parameters = [0 0 0 th1; L1 0 0 th2; L2 pi d3 0;0 0 L4 th4]
configuration = 'RRPR'

% Note that if you want to specify a robot name, you need to put it in two
% layers of quotes. This is dumb, but not worth fixing right now.
describot(dh_parameters,configuration,'robotName','''SCARA''','verbose','true','generateReport','true');

load SCARAVars.mat
disp('***************')
disp('*** RESULTS ***')
disp('***************')
disp('T04 = ')
disp(T)
disp('4w4 =')
disp(w{4})
disp('4v4 =')
disp(v{4})
disp('Jacobian =')
disp(J)