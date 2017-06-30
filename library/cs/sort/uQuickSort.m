function [result, order] = uQuickSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uQuickSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Quicksort (sometimes called partition-exchange sort) is an
%               efficient sorting algorithm, serving as a systematic method
%               for placing the elements of an array in order. Developed by
%               Tony Hoare in 1959[1] and published in 1961,[2] it is still
%               a commonly used algorithm for sorting. When implemented 
%               well, it can be about two or three times faster than its 
%               main competitors, merge sort and heapsor[3].
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
%               O(n^2)       Worst-case performance
%               O(n.logn)    Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 18, 2016
%-------------------------------------------------------------------------
% References:   [1] "Sir Antony Hoare". Computer History Museum.
%               [2] Hoare, C. A. R. (1961). "Algorithm 64: Quicksort". 
%                   Comm. ACM. 4 (7): 321
%               [3] https://en.wikipedia.org/wiki/Quicksort
% -------------------------------------------------------------------------
% Pseudecode :
%
% algorithm quicksort(A, lo, hi) is
%     if lo < hi then
%         p := partition(A, lo, hi)
%         quicksort(A, lo, p – 1)
%         quicksort(A, p + 1, hi)
% 
% algorithm partition(A, lo, hi) is
%     pivot := A[hi]
%     i := lo - 1    
%     for j := lo to hi do
%         if A[j] ≤ pivot then
%             i := i + 1
%             if i ≠ j then
%                 swap A[i] with A[j]
%     return i
%-------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
   
	% Knobs
    kk = 15; % Insertion sort threshold, kk >= 1

    % Quicksort
    n = length(x);
    x = quicksorti(x,1,n,kk);
    
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end

function x = quicksorti(x,ll,uu,kk)
    % Sort x(ll:uu) via quick sort 
    % Note: In practice, x xhould be passed by reference

    % Select pivot and partition data around it
    [x mm] = partition(x,ll,uu);

    % Divide-and-conquer
    if ((mm - ll) <= kk)
        % Sort x(ll:(mm - 1)) via insertion sort 
        x = insertionsorti(x,ll,mm - 1);
    else
        % Sort x(ll:(mm - 1)) via quick sort 
        x = quicksorti(x,ll,mm - 1,kk);
    end
    if ((uu - mm) <= kk)
        % Sort x((mm + 1):uu) via insertion sort 
        x = insertionsorti(x,mm + 1,uu);
    else
        % Sort x((mm + 1):uu) via quick sort 
        x = quicksorti(x,mm + 1,uu,kk);
    end

end

function [x mm] = partition(x,ll,uu)
    % Partition x(ll:uu) around index mm
    % Note: In practice, x xhould be passed by reference

    %--------------------------------------------------------------------------
    % Select pivot
    %--------------------------------------------------------------------------
    % Method 1: Median-of-3 pivot
    pp = medianofthree(x,ll,uu); % Median-of-three pivot index

    % Method 2: Random pivot
    %pp = randi([ll uu]); % Random pivot index
    %--------------------------------------------------------------------------

    % Partition around pivot
    x = swap(x,ll,pp);
    mm = ll;
    for j = (ll + 1):uu
        if (x(j) < x(ll))
            mm = mm + 1;
            x = swap(x,mm,j);
        end
    end
    x = swap(x,ll,mm);

end

function pp = medianofthree(x,ll,uu)
    % Compute median of {x(ll),x(mm),x(uu)}
    % Note: In practice, x xhould be passed by reference

    % Middle element (avoiding overflow)
    mm = ll + floor((uu - ll) / 2);

    % Compute median of {x(ll),x(mm),x(uu)}
    if (x(ll) <= x(mm))
        if (x(uu) >= x(mm))
            pp = mm;
        elseif (x(uu) >= x(ll))
            pp = uu;
        else
            pp = ll;
        end
    else
        if (x(uu) >= x(ll))
            pp = ll;
        elseif (x(uu) >= x(mm))
            pp = uu;
        else
            pp = mm;
        end
    end

end

function x = insertionsorti(x,ll,uu)
    % Sort x(ll:uu) via insertion sort 
    % Note: In practice, x xhould be passed by reference

    % Insertion sort
    for j = (ll + 1):uu
        pivot = x(j);
        i = j;
        while ((i > ll) && (x(i - 1) > pivot))
            x(i) = x(i - 1);
            i = i - 1;
        end
        x(i) = pivot;
    end

end

function x = swap(x,i,j)
    val = x(i);
    x(i) = x(j);
    x(j) = val;
end