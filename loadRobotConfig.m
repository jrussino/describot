function [dh_parameters,configuration,robotName,saveVars,generateReport,buildFunctions,verbose] = loadRobotConfig(varargin)
%LOARDOBOTCONFIG  Loads a robot configuration.
%   This function loads robot configuration variables and the various
%   options for the function describot.m and returns the appropriate
%   variables.
%
%   Joseph A. Russino 12/6/2009


% Define option variable names and their default values.
options = {'robotName','saveVars','generateReport','buildFunctions','verbose'};
default_name = ['robot' datestr(now,'yyyymmddTHHMMSS')];
defaults = {'char(default_name)','true','false','false','false'};
for i=1:length(options)
    eval(strcat(options{i},'=',defaults{i},';'));
end



% Assign variables based on funtion inputs or configuration file.
ARGS = varargin{1};
nargs = length(varargin{1});

% If there are two or more inputs, set dh_paramethers and configuration
% values and use the provided values for each of the specified options.
if nargs > 1
    %elseif nargs > 1 && mod(nargs,2)
    dh_parameters = ARGS{1};
    configuration = ARGS{2};
    for i=3:2:nargs
        if sum(strcmp(ARGS{i},options)) > 0
            
            eval(strcat(ARGS{i},'=',ARGS{i+1},';'));
        else
            warning('JAR:loadRobotConfig:invalidParameter','One or more of input options was not recognized. This value was not set.')
        end
    end
else
    error('Wrong number of input arguments.');
end


end
