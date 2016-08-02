function [J, f] = gradient_fi(x, fun)
%   Gradient of a function using the complex-step derivative approximation
%   ('imaginary trick'). This method yields significantly more accurate
%   results than ordinary forward or central differences approximations.
%
%   The method is described in Martins, Sturdza and Alonso, "The
%   Complex-Step Derivative Approximation", ACM Transactions on
%   Mathematical Software, 2003
%
%   Author: Pieter Jan Kerstens, 2010
%
%   function [J,f] = GRADIENT_FI(x,fun)
%       x: evaluation point
%       fun: function for which to compute the gradient in x
%
%       J: gradient of fun at x
%       f: fun evaluated at x
%
%   See also: gradient_f
    
    % Evaluate fun in x
    f = fun(x);
    
    % Determining some constants
    t = 10^-100;
    m = length(f);
    n = length(x);
    
    % Compute gradient of fun at x
    J = zeros(m,n);
    for k=1:n
        p = x;
        p(k) = p(k) + t*1i;
        J(:,k) = imag(fun(p))/t;
    end
end