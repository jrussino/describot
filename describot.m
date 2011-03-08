function describot(varargin)
%DESCRIBOT  Robot characterization, variable, and function generator.
%
%   For a given robot, described by a set of DH parameters and a
%   configuration string, this function characterizes the robot's
%   - Forward Kinematics
%   - Equations of Motion
%   - Jacobian
%   - Dynamics (NOT YET IMPLEMENTED)
%
%   The possible outputs of the function are:
%   - A saved set of variables pertaining to the robot
%   - A LaTeX-formatted report describing the characteristics of the robot
%   - A set of functions related to these characteristics
%       (NOT YET IMPLEMENTED)
%
%   DESCRIBOT(dh_parameters,configuration) Takes the provided DH parameters
%   and configuration description and generates the outputs listed above.
%   dh_parameters is an Nx4 matrix, for which the first column contains the
%   a(i-1) values, the second contains the alpha(i-1) values, the third
%   contains the d(i) values, and the fourth contains the theta(i) values.
%   configuration is an N-character long string, where each character is
%   either an R or a P and indicates whether the corresponding joint is a
%   rotational or prismatic joint. ex - configuration = "RRRPR".
%
%   DESCRIBOT(...,option,value) Performs the above task with the specific
%   option values as indicated.
%   The available options and their default values are:
%   - robotName: A name for the robot, to be used in file names and report.
%       default = generic name formed by 'robot' + date string
%   - saveVars: Whether or not to save characterization variables to a file.
%       default = 'true'
%   - generateReport: Whether or not to generate a LaTeX-formatted report.
%       default = 'false'
%   - buildFunctions: Whether or not to build robot matlab functions.
%       default = 'false'
%   - verbose: If true, displays progress and results while running.
%       default = 'false
%
%
%   Joseph A. Russino 12/6/2009


% Load robot configuration and assign variables.
[dh_parameters,configuration,robotName,saveVars,generateReport,buildFunctions,verbose] = loadRobotConfig(varargin);


% Set progress messages for verbose mode;
if verbose
    semicolon = '';
    progressMessage{1} = 'Generating forward kinematics expressions.';
    progressMessage{2} = 'Generating equations of motion.';
    progressMessage{3} = 'Generating Jacobian.';
    progressMessage{4} = 'Generating dynamic equations.';
    progressMessage{5} = 'Saving variables to file';
    progressMessage{6} = 'Creating report';
    progressMessage{7} = 'Building robot functions';
else
    semicolon = ';';
    progressMessage = cell(1,7);
    for i=1:7
        progressMessage{i} = '';
    end
end


% Generate description of the robot's forward kinematics.
disp(progressMessage{1})
eval(['[T T0_N TMplus1_M] = genFwdKin(dh_parameters)' semicolon]);


% Generate the robot's equations of motion.
disp(progressMessage{2})
eval(['[w v] = genMotionEquations(dh_parameters,TMplus1_M,configuration)' semicolon]);


% Generate the robot's jacobian.
disp(progressMessage{3})
eval(['J = genJacobian(dh_parameters,configuration,v,w)' semicolon]);


% Generate the robot's dynamic equations.
% XXX THIS FEATURE IS NOT YET IMPLEMENTED XXX
% disp(progressMessage{4})


% Save the robot's characterization variables to a file.
if saveVars
    disp(progressMessage{5})
    eval(['save ' robotName 'Vars.mat' ' dh_parameters configuration T T0_N TMplus1_M w v J' semicolon]);
end


% Generate a LaTeX-formatted report describing the robot's
% characterization.
if generateReport
    disp(progressMessage{6})
    %eval(['compileReport(robotName,dh_parameters,configuration, T0_N, w, v, J)' semicolon]);
    compileReport(robotName,dh_parameters,configuration, T0_N, w, v, J)
end


% Generate a set of Kinematics, Jacobian and Dynamics functions.
% % XXX THIS FEATURE IS NOT YET IMPLEMENTED XXX
% if buildFunctions
%   disp(progressMessage{7})
%
% end


end
