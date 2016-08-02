function [num,txt,raw] = xlsreadwvars(file,sheet,varargin)
%   Read a xls file with header containing the variable names
%
%   You can filter the data using the variable names specified in the
%   original header. Thus, there's no need to remember the order in which
%   the data is structured. You only need to know the names of the
%   variables.
%
%   Author: Pieter Jan Kerstens, 2015
%
%   [num,txt,raw] = xlsreadwvars(file,sheet,range) reads from the specified SHEET
%   and RANGE in the Microsoft Excel spreadsheet file named FILE and returns the numeric
%   data in array NUM. Optionally, returns the text fields in cell array
%   TXT, and the unprocessed data (numbers and text) in cell array RAW.
%   Specify RANGE using the syntax 'C1:C2', where C1 and C2 are opposing corners of the region.
%   Not supported for XLS files in BASIC mode.
%
%   Example: A xls file called 'toyexample.xls' containing:
%       'var1,var2,var3,var4,var5'
%       10,11,12,13,14
%       20,21,22,23,24
%
%   Calling 
%       num = xlsread('toyexample.xls','Sheet1');
%   results in a matrix
%       num = [10,11,12,13,14;
%                   20,21,22,23,24];
%   and variables called var1 = 1, var2 = 2, var3 = 3 and var4 = 4.
%   You can then extract data by
%       num(:,var1)
%
%   See also: xlsread

    defopt = {''};
    defopt(1:length(varargin)) = varargin;
    [range] = defopt{:};

    % Read the numeric data
    [num,txt,raw] = xlsread(file,sheet,range);
    
    % Determine the indices of all variables of interest according to their
    % name found in the first line of 'txt'
    for k=1:size(num,2)
        %regexprep(txt{1,k},'[ :&-./=]','_')
        evalin('caller',sprintf('%s = %i;',regexprep(txt{1,k},'[ :&-./=]','_'),k));
    end
end