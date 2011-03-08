function T = iterateFwdKin(a,alpha,d,theta)
% ITERATEFWDKIN  Computes one step of a robot's forward kinematics.
%
%   Joseph A. Russino and Alex Burtness 12/6/2009


% Generate the transformation matrix
syms T;
T = [cos(theta),            -sin(theta),             0,           a;
    sin(theta)*cos(alpha),  cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
    sin(theta)*sin(alpha),  cos(theta)*sin(alpha),  cos(alpha),  cos(alpha)*d;
    0,                      0,                      0,           1];

end