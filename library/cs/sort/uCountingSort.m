function [result, order] = uCountingSort(x, r, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uCountingSort(x, r, o);
%-------------------------------------------------------------------------
% Definition:   Counting sort is an algorithm for sorting a collection of
%               objects according to keys that are small integers; that is,
%               it is an integer sorting algorithm [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len in the range [1,...,r]
%               'r' is an upper bound on max(x)
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(k)      Best-case performance
%               O(n+k)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(k)      Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies  No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 12, 2016
%-------------------------------------------------------------------------
% References    [1] https://en.wikipedia.org/wiki/Counting_sort
% -------------------------------------------------------------------------
    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Compute histogram
    len = numel(x);
    C = zeros(r,1);
    for j = 1:len
        C(x(j)) = C(x(j)) + 1;
    end

    % Convert to cumulative values
    for i = 2:r
        C(i) = C(i) + C(i - 1);
    end

    % Sort the array
    sx = nan(len,1);
    for j = len:-1:1
        sx(C(x(j))) = x(j);
        C(x(j)) = C(x(j)) - 1;
    end

    if strcmp(order, 'ascending') 
        result = sx;
    else
        result = fliplr(sx);
    end
end