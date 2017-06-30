function [result, order] = uShellSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uShellSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Heapsort is a comparison-based sorting algorithm. Heapsort
%               can be thought of as an improved selection sort: like that
%               algorithm, it divides its input into a sorted and an 
%               unsorted region, and it iteratively shrinks the unsorted 
%               region by extracting the largest element and moving that to
%               the sorted region. The improvement consists of the use of a
%               heap data structure rather than a linear-time search to 
%               find the maximum [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(n.logn)    Best-case performance
%               O(n.logn)    Average-case performance
%               O(n.logn)    Worst-case performance
%               O(1)-aux     Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 18, 2016
%-------------------------------------------------------------------------
% References:   [1] https://en.wikipedia.org/wiki/Heapsort
% -------------------------------------------------------------------------
% Pseudecode :
%  
%--------------------------------------------------------------------------
    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Compute gap sequence
    % Note: In practice, one should preallocate memory for gaps
    len = length(x);
    gap = 1;
    gaps = [];
    while (ceil(gap) <= len)
        gaps = [gaps ceil(gap)]; %#ok
        gap = 2.25 * gap + 1; % Tokuda's gap sequence
    end
    Ngaps = length(gaps);

    % Insertion sort
    for k = Ngaps:-1:1
        % Perform insertion sort with gap = gaps(k)
        x = insertionsorti(x,gaps(k),len);    
    end
    
    if strcmp(order, 'ascending')
        result = x;
    else
        result = fliplr(x);
    end
end

function x = insertionsorti(x,gap,n)
    % Perform insertion with given gap
    % Note: In practice, x xhould be passed by reference

    % Performs insertion sort with given gap
    for j = (gap + 1):n
        pivot = x(j);
        i = j;
        while ((i > gap) && (x(i - gap) > pivot))
            x(i) = x(i - gap);
            i = i - gap;
        end
        x(i) = pivot;
    end

end