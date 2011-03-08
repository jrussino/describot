function outstr = recursiveregex(instr, varargin)
%RECURSIVEREGEX(STRING,PATTERN_1,REPLACE_1,...,PATTERN_N, REPLACE_N
%
%   Calls regexprep recursively, updating the index string according to
%   each pattern/replace pair.
%
%
%   Joseph A. Russino 12/15/2010

nargs = length(varargin);


argString1 = '';
for i=1:2
    if isnumeric(varargin{i})
        argString1 = [argString1 ',' '''' num2str(varargin{i}) ''''];
    else
        argString1 = [argString1 ',' '''' varargin{i} ''''];
    end
end

if (nargs > 2)      % More than 2 arguments; pass a subset to recursiveregex.
    argString2 = '';
    for i=3:nargs
        if isnumeric(varargin{i})
            argString2 = [argString2 ',' '''' num2str(varargin{i}) ''''];
        else
            argString2 = [argString2 ',' '''' varargin{i} ''''];
        end
    end
    exp = ['outstr = regexprep(recursiveregex(instr' argString2 ')' argString1 ');'];
else
    exp = ['outstr = regexprep(instr' argString1 ');'];
end

eval(exp);


end