function X = randsimplex(N,D)
%   Draw N uniform samples from the D-dimensional unit simplex
%
%   Copyright: Pieter Jan Kerstens, 2016
%
%   X = randsimplex(N,D)
%       N: number of samples
%       D: dimension of the unit simplex
%
%       X: (N x D) matrix such that sum(X,2) = 1
%

    X = -log(rand(N,D)); % Sample from exponential distribution
    X = bsxfun(@rdivide,X,sum(X,2)); % Normalize samples
end