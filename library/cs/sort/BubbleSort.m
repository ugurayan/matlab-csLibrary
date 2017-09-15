function [result, order] = BubbleSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = BubbleSort(x, o);
% 
% Definition:   Bubble sort, sometimes referred to as sinking sort, is a 
%               simple sorting algorithm that repeatedly steps through the 
%               list to be sorted, compares each pair of adjacent items and
%               swaps them if they are in the wrong order. The pass through
%               the list is repeated until no swaps are needed, which 
%               indicates that the list is sorted. The algorithm, which is 
%               a comparison sort, is named for the way smaller or larger 
%               elements "bubble" to the top of the list. Although the 
%               algorithm is simple, it is too slow and impractical for 
%               most problems even when compared to insertion sort.
%               It can be practical if the input is usually in sorted order
%               but may occasionally have some out-of-order elements nearly
%               in position [1].
%               
% Inputs:       [x] is a vector of length 'len'
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending'  
%               
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%                             
% Complexity:   O(n)      Best-case performance
%               O(n^2)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(1)-aux  Worst-case space complexity
%
% Dependencies  No dependency.
%               
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%               
% Date:         May 5, 2016
%
% Refrences     [1] https://en.wikipedia.org/wiki/Bubble_sort
%--------------------------------------------------------------------------


    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end

    % Bubble sort
    len = length(x);
    while (len > 0)
        % Iterate through x

        newValue = 0;
        for i = 2:len
            % Swap elements in wrong order
            if (x(i) < x(i - 1))
                x = swap(x,i,i - 1);
                newValue = i;
            end
        end
        len = newValue;
    end
    
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end

function x = swap(x,i,j)
	temp = x(i);
	x(i) = x(j);
	x(j) = temp;
end
