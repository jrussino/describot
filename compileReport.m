function compileReport(name, dh_parameters, configuration, T0_N, w, v, J)
%makeLaTeXfile  Generates a LaTeX-formatted report.
%
%   This function takes as its input the dh_parameters and configuration
%   string for a robot manipulator, as well as the symbolic representations
%   of the robot's forward and inverse kinematics and jacobian and the
%   images depicting the robot's workspace. It converts the symbolic values
%   to LaTeX format, and inserts all of the information into a report
%   template.
%
%
%   Joseph A. Russino 12/19/2009



% Create report file and open it.
fid1 = fopen([name ' Report.tex'],'w');


% Load template.
fid2 = fopen('report_template.tex');
template = textscan(fid2,'%s','Delimiter','!!!');
fclose(fid2);


% Convert the symbolic variables to LaTeX format.
pat1 = '(th\d+)dot';
pat2 = 'th(\d+)';

n = length(T0_N);
T0_N_tex = recursiveregex(latex(T0_N{n}), pat2, '\\theta_$1', pat1, '\\dot $1');
w_tex = recursiveregex(latex(w{n}), pat2, '\\theta_$1', pat1, '\\dot $1');
v_tex = recursiveregex(latex(v{n}), pat2, '\\theta_$1', pat1, '\\dot $1');
J_tex = recursiveregex(latex(J), pat2, '\\theta_$1', pat1, '\\dot $1');

dh_params_tex = '\begin{tabular}{|c|c|c|c|c|}\hline$i$&$\alpha_{i-1}$&$a_{i-1}$&$d_i$&$\theta_i$\\\hline';
for i=1:size(dh_parameters,1)
    dh_params_tex = [dh_params_tex '$' num2str(i) '$&$' char(dh_parameters(i,1)) '$&$' char(dh_parameters(i,2)) '$&$' char(dh_parameters(i,3)) '$&$' char(dh_parameters(i,4)) '$\\\hline'];
end
dh_params_tex = recursiveregex([dh_params_tex '\end{tabular}'],pat2, '\\theta_$1', pat1, '\\dot $1', 'pi','\\pi');


% Write the report file, inserting formatted expressions and matrices in
% the appropriate places

for line=1:length(template{:})
    
    switch template{:}{line}
        case 'DHPARAM'
            fprintf(fid1,'%s\n',dh_params_tex);
        case 'TRANSMAT'
            fprintf(fid1,'%s\n',T0_N_tex);
        case 'LINV'
            fprintf(fid1,'%s\n',v_tex);
        case 'ROTV'
            fprintf(fid1,'%s\n',w_tex);
        case 'JACOB'
            fprintf(fid1,'%s\n',J_tex);
        otherwise
            fprintf(fid1,'%s\n',recursiveregex(template{:}{line}, 'CONFIG', configuration, 'RNAME', name, 'NUM', n));
    end
end


% Close the file.
fclose(fid1);

end

