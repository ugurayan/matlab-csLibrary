function [result, order] = uCombSort(x,o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uCombSort(x,o)
%-------------------------------------------------------------------------
% Definition:   Comb sort is a relatively simple sorting algorithm 
%               originally designed by Włodzimierz Dobosiewicz in 1980 [1].
%               Later it was rediscovered by Stephen Lacey and Richard Box 
%               in 1991 [2]. Comb sort improves on bubble sort [3].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   Θ(n.logn)   Best-case performance
%               Ω(n^2/2^p)  Average-case performance
%               O(n^2)      Worst-case performance
%               O(1)        Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies  No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 10, 2016
%-------------------------------------------------------------------------
% References    [1] Brejová, B. (15 September 2001). "Analyzing variants of
%                   Shellsort". Inform. Process. Lett. 79 (5): 223–227.
%               [2] "A Fast Easy Sort", Byte Magazine, April 1991.
%               [3] https://en.wikipedia.org/wiki/Comb_sort
% -------------------------------------------------------------------------
% Pseudocode:
% 
%    function combsort(array input)
%     gap := input.size // Initialize gap size
%     shrink := 1.3 // Set the gap shrink factor
%     sorted := false
%     loop while sorted = false
%         // Update the gap value for a next comb
%         gap := floor(gap / shrink)
%         if gap > 1
%             sorted := false // We are never sorted as long as gap > 1
%         else
%             gap := 1
%             sorted := true 
%             // If there are no swaps this pass, we are done
%         end if
%         // A single "comb" over the input list
%         i := 0
%         loop while i + gap < input.size 
%         // See Shell sort for a similar idea
%             if input[i] > input[i+gap]
%                 swap(input[i], input[i+gap])
%                 sorted := false
%                 // If this assignment never happens within the loop,
%                 // then there have been no swaps and the list is sorted.
%              end if
%              i := i + 1
%          end loop
%          
%      end loop
%  end function
%-------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Knobs
    shrink = 1.3; % shrink > 1

    % Comb sort
    len = length(x);
    gap = len;
    swapped = true;
    while ((gap > 1) || (swapped == true))
        % Update gap
        gap = max(floor(gap / shrink),1);

        % Bubble sort with given gap
        i = 1;
        swapped = false;
        while ((i + gap) <= len)
            if (x(i) > x(i + gap))
                x = swap(x,i,i + gap);
                swapped = true;
            end
            i = i + 1;
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