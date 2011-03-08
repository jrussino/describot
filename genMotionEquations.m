function [w v] = genMotionEquations(dh_parameters,TMplus1_M,configuration)
%GENMOTIONEQUATIONS  Generates equations of motion.
%   This function iteratively computes the equations of motion for each
%   link of the robot, and then returns these equations in the cell arrays
%   w and v.
%
%
%   Joseph A. Russino 12/6/2009


% Initialize output variables.
dhsize = size(dh_parameters);
w = cell(dhsize(1),1);
v = cell(dhsize(1),1);


% Iteratively generate the equations of motion.
for i=1:dhsize(1)
    % Determine joint type (R=rotationa, P=prismatic) from config string.
    joint_type = configuration(i);
    % Extract the current theta and d from the dh parameters. Note that
    % these are expected to be variables; they will be used to generate the
    % variable names for the angular and linear velocity, respectively, by
    % appending 'dot' to the end.
    if strcmp(joint_type,'R')
        theta = char(dh_parameters(i,4));
        eval(['syms ' strcat(theta,'dot') ' real;']);
        eval(strcat('thetadot = ',strcat(theta,'dot'),';'));
        ddot = 0;
    elseif strcmp(joint_type,'P')
        d = char(dh_parameters(i,3));
        eval(['syms ',strcat(d,'dot'), ' real;']);
        eval(strcat('ddot = ',strcat(d,'dot;')));
        thetadot = 0;
    end
    % Extract R and p from the current transformation matrix.
    T = TMplus1_M{i};
    R = T(1:3,1:3)';
    p = T(1:3,4);
    % Generate the expressions for the angular and linear velocity.
    if i == 1
        w{i} = thetadot*[0;0;1];
        v{i} = ddot*[0;0;1];
    else
        w{i} = simplify(R*w{i-1} + thetadot*[0;0;1]);
        v{i} = simplify(R*(v{i-1} + cross(w{i-1},p)) + ddot*[0;0;1]);
    end
end


end

