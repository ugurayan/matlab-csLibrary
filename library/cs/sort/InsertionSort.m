function [result, order] = InsertionSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = InsertionSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Insertion sort is a simple sorting algorithm that builds 
%               the final sorted array (or list) one item at a time. It is
%               much less efficient on large lists than more advanced 
%               algorithms [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(n)      Best-case performance
%               O(n^2)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(n)      Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 21, 2016
%-------------------------------------------------------------------------
% References:   [1] https://en.wikipedia.org/wiki/Insertion_sort
% -------------------------------------------------------------------------
% Pseudecode :
%  
% for i = 1 to length(A)
%     j ← i
%     while j > 0 and A[j-1] > A[j]
%         swap A[j] and A[j-1]
%         j ← j - 1
%     end while
% end for
% -------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end

    len = length(x);
    for j = 2:len
        pivot = x(j);
        i = j;
        while ((i > 1) && (x(i - 1) > pivot))
            x(i) = x(i - 1);
            i = i - 1;
        end
        x(i) = pivot;
    end
    
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end
