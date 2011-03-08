function [T T0_N  TMplus1_M] = genFwdKin(dh_parameters)
%GENFWDKIN  Generates a description of the robot's forward kinematics.
%   This function iteratively computes the transformation that maps each
%   link of the robot to the previous link, and then returns these
%   transformation matrices in the cell array TMplus1_M.
%       For example, TMplus1_M{2} returns the transformation matrix that
%       describes the position and orientation of joint frame 2 with
%       respect to joint frame 1.
%
%   It then applies the transformations sequentially in order to determine
%   the transformation that describes each joint frame with respect to the
%   base frame, and returns these in the cell array T0_N.
%       For Example, T0_N{2} returns the transformation matrix that
%       describes the position and orientation of joint frame 2 with
%       respect to the base frame (frame 0).
%
%   Finally, the most interesting of these transformations, the
%   transformation matrix which describes the position and orientation of
%   the last frame with respect to the base frame, T0_N{length(T0_N)}, is
%   saved and returned in a separate variable T.
%
%
%   Joseph A. Russino 12/6/2009


% Initialize output variables.
dhsize = size(dh_parameters);
TMplus1_M = cell(dhsize(1),1);
T0_N = cell(dhsize(1),1);


% Compute transformations.
for i=1:dhsize(1)
    % Extract the values from the current line of the DH parameters.
    a = dh_parameters(i,1);
    alpha = dh_parameters(i,2);
    d = dh_parameters(i,3);
    theta = dh_parameters(i,4);
    % Calculate the transformation matrices.
    TMplus1_M{i} = iterateFwdKin(a,alpha,d,theta);
    if i == 1
        T0_N{i} = TMplus1_M{i};
    else
        T_temp = T0_N{i-1}*TMplus1_M{i};
        T0_N{i} = simplify(T_temp);
    end
end
T = T0_N{length(T0_N)};

end

