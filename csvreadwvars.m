function data = csvreadwvars(filename)
%   Read a csv file with header containing the variable names
%
%   You can filter the data using the variable names specified in the
%   original header. Thus, there's no need to remember the order in which
%   the data is structured. You only need to know the names of the
%   variables.
%
%   Author: Pieter Jan Kerstens, 2015
%
%   data = csvreadwvars(filename)
%       filename: name of the csv file
%
%       data: matrix where the numeric content in filename is stored
%
%   Example: A csv file called 'toyexample.csv' containing:
%       'var1,var2,var3,var4,var5'
%       10,11,12,13,14
%       20,21,22,23,24
%
%   Calling 
%       data = csvreadwvars('toyexample.csv');
%   results in a matrix
%       data = [10,11,12,13,14;
%                   20,21,22,23,24];
%   and variables called var1 = 1, var2 = 2, var3 = 3 and var4 = 4.
%   You can then extract data by
%       data(:,var1)
%
%   See also: csvread, textscan

    % Read the numeric data excluding the header
    data = csvread(filename,1,0);

    % Read in the name of all variables
    fid = fopen(filename);
    vars = textscan(fid,'%s',1);
    fclose(fid);
    vars = vars{1}{1};
    
    % Determine the indices of all variables of interest according to their
    % name found in 'vars'
    remain = vars;
    k = 1;
    while(~isempty(remain))
        [newvar,remain] = strtok(remain,','); %#ok<STTOK>  
        evalin('caller',sprintf('%s = %i;',newvar,k));
        k = k + 1;
    end
end