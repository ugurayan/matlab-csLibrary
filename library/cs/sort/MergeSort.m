function [result, order] = MergeSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = MergeSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Merge sort (also commonly spelled mergesort) is an 
%               efficient, general-purpose, comparison-based sorting 
%               algorithm. Most implementations produce a stable sort, 
%               which means that the implementation preserves the input 
%               order of equal elements in the sorted output. Mergesort is 
%               a divide and conquer algorithm that was invented by John 
%               von Neumann in 1945.[1] A detailed description and analysis
%               of bottom-up mergesort appeared in a report by Goldstine 
%               and Neumann as early as 1948[2], [3].
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
%               O(n)-aux     Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 18, 2016
%-------------------------------------------------------------------------
% References:   [1] Cormen, Thomas H.; Leiserson, Charles E.; Rivest, 
%                   Ronald L.; Stein, Clifford (2009) [1990]. Introduction 
%                   to Algorithms (3rd ed.). MIT Press and McGraw-Hill.
%               [2] Katajainen, Jyrki; Pasanen, Tomi; Teuhola, Jukka (1996)
%                   "Practical in-place mergesort". Nordic Journal of 
%                   Computing. 3. pp. 27–40.
%               [3] https://en.wikipedia.org/wiki/Merge_sort
% -------------------------------------------------------------------------
% Pseudecode :
%
% // Array A[] has the items to sort; array B[] is a work array.
% TopDownMergeSort(A[], B[], n)
% {
%     CopyArray(A, 0, n, B);           // duplicate array A[] into B[]
%     TopDownSplitMerge(B, 0, n, A);   // sort data from B[] into A[]
% }
% 
% // Sort the given run of array A[] using array B[] as a source.
% // iBegin is inclusive; iEnd is exclusive (A[iEnd] is not in the set).
% TopDownSplitMerge(B[], iBegin, iEnd, A[])
% {
%     if(iEnd - iBegin < 2)                       // if run size == 1
%         return;                                 //   consider it sorted
%     // split the run longer than 1 item into halves
%     iMiddle = (iEnd + iBegin) / 2;              // iMiddle = mid point
%     // recursively sort both runs from array A[] into B[]
%     TopDownSplitMerge(A, iBegin,  iMiddle, B);  // sort the left  run
%     TopDownSplitMerge(A, iMiddle,    iEnd, B);  // sort the right run
%     // merge the resulting runs from array B[] into A[]
%     TopDownMerge(B, iBegin, iMiddle, iEnd, A);
% }
% 
% //  Left source half is A[ iBegin:iMiddle-1].
% // Right source half is A[iMiddle:iEnd-1   ].
% // Result is            B[ iBegin:iEnd-1   ].
% TopDownMerge(A[], iBegin, iMiddle, iEnd, B[])
% {
%     i = iBegin, j = iMiddle;
%     
%     // While there are elements in the left or right runs...
%     for (k = iBegin; k < iEnd; k++) {
%         // If left run head exists and is <= existing right run head.
%         if (i < iMiddle && (j >= iEnd || A[i] <= A[j])) {
%             B[k] = A[i];
%             i = i + 1;
%         } else {
%             B[k] = A[j];
%             j = j + 1;    
%         }
%     } 
% }
% 
% CopyArray(A[], iBegin, iEnd, B[])
% {
%     for(k = iBegin; k < iEnd; k++)
%         B[k] = A[k];
% }
% -------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Knobs
    kk = 15; % Insertion sort threshold, k >= 1

    % Mergesort
    len = length(x);
    x = mergesorti(x,1,len,kk);
    
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
    
end

function x = mergesorti(x,ll,uu,kk)
    % Sort x(ll:uu) via merge sort 
    % Note: In practice, x xhould be passed by reference

    % Compute center index
    mm = floor((ll + uu) / 2);

    % Divide...
    if ((mm + 1 - ll) <= kk)
        % Sort x(ll:mm) via insertion sort
        x = insertionsorti(x,ll,mm);
    else
        % Sort x(ll:mm) via insertion sort
        x = mergesorti(x,ll,mm,kk);
    end
    if ((uu - mm) <= kk)
        % Sort x((mm + 1):uu) via insertion sort
        x = insertionsorti(x,mm + 1,uu);
    else
        % Sort x((mm + 1):uu) via merge sort
        x = mergesorti(x,mm + 1,uu,kk);
    end

    % ... and conquer
    % Combine sorted arrays x(ll:mm) and x((mm + 1):uu)
    x = merge(x,ll,mm,uu);
end

function x = insertionsorti(x,ll,uu)
    % Sort x(ll:uu) via insertion sort 
    % Note: In practice, x xhould be passed by reference

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

function x = merge(x,ll,mm,uu)
    % Combine sorted arrays x(ll:mm) and x((mm + 1):uu)
    % Note: In practice, x xhould be passed by reference

    % Note: In practice, use memcpy() or similar
    L = x(ll:mm);

    % Combine sorted arrays
    i = 1;
    j = mm + 1;
    k = ll;
    while ((k < j) && (j <= uu))
        if (L(i) <= x(j))
            x(k) = L(i);
            i = i + 1;
        else
            x(k) = x(j);
            j = j + 1;
        end
        k = k + 1;
    end

    % Note: In practice, use memcpy() or similar
    x(k:(j - 1)) = L(i:(i + j - k - 1));

end
    
