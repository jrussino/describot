function [ J ] = genJacobian(dh_parameters,configuration,v,w)
%GETJACOBIAN  Generates end-effector Jacobian
%
%   Given the equations of motion for a robot manipulator, this function
%   returns the Jacobian that relates joint velocities to end-effector
%   velocity, in the frame of the end effector.
%
%
%   Joseph A. Russino 12/6/2009

% Determine the number of joints;
dhsize = size(dh_parameters);
num_joints = dhsize(1);

% Extract prefactors of each joint velocity in v and w to generate the
% Jacobian.
syms J
for i=1:num_joints
    if strmatch(configuration(i),'R')
        joint = [char(dh_parameters(i,4)),'dot'];
    elseif strmatch(configuration(i),'P')
        joint = [char(dh_parameters(i,3)),'dot'];
    end
    J(1:3,i) = jacobian(v{num_joints},joint);
    J(4:6,i) = jacobian(w{num_joints},joint);
end

