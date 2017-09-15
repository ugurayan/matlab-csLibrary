function [result, order] = SelectionSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = SelectionSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Selection sort is a sorting algorithm, specifically an 
%               in-place comparison sort. It has O(n2) time complexity,
%               making it inefficient on large lists, and generally
%               performs worse than the similar insertion sort. Selection
%               sort is noted for its simplicity, and it has performance
%               advantages over more complicated algorithms in certain
%               situations, particularly where auxiliary memory is 
%               limited.[1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(n^2)    Best-case performance
%               O(n^2)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(1)-aux  Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         April 1, 2016
%-------------------------------------------------------------------------
% References:   [1] https://en.wikipedia.org/wiki/Selection_sort
% -------------------------------------------------------------------------
% Pseudecode :
%  
% -------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    len = length(x);
    for j = 1:(len - 1)
        % Find jth smallest element
        imin = j;
        for i = (j + 1):len
            if (x(i) < x(imin))
                imin = i;
            end
        end

        % Put jth smallest element in place
        if (imin ~= j)
            x = swap(x,imin,j);
        end
    end
    if strcmp(order, 'ascending') 
            result = x;
        else
            result = fliplr(x);
    end
end


function x = swap(x,i,j)
    val = x(i);
    x(i) = x(j);
    x(j) = val;
end
