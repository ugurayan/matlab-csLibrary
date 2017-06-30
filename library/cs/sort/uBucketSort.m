function [result, order] = uBucketSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uBucketSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Bucket sort, or bin sort, is a sorting algorithm that works
%               by distributing the elements of an array into a number of 
%               buckets. Each bucket is then sorted individually, either 
%               using a different sorting algorithm, or by recursively 
%               applying the bucket sorting algorithm. It is a distribution
%               sort, and is a cousin of radix sort in the most to least 
%               significant digit flavour. Bucket sort is a generalization 
%               of pigeonhole sort. Bucket sort can be implemented with 
%               comparisons and therefore can also be considered a 
%               comparison sort algorithm. The computational complexity 
%               estimates involve the number of buckets [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   Ω(n+k)    Best-case performance
%               Θ(n+k)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(n.k)    Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         May 8, 2016
%-------------------------------------------------------------------------
% References:   [1] https://en.wikipedia.org/wiki/Bucket_sort
% -------------------------------------------------------------------------
    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Default load factor
    alpha = 0.75; % alpha = n / m

    % Find min and max elements of x
    len = length(x);
    [minx maxx] = minmax(x,len);

    % Insert elements into m equal width buckets, each containing a doubly
    % linked list
    m = round(len / alpha);
    dw = (maxx - minx) / m;
    head = nan(1,m); % pointers to heads of bucket lists
    prev = nan(1,len); % previous element pointers
    next = nan(1,len); % next element pointers
    last = nan(1,m); % temporary storage
    for i = 1:len
        % hack to make max(x) fall in last bucket
        j = min(floor((x(i) - minx) / dw) + 1,m); 
        if isnan(head(j))
            head(j) = i;
        else
            prev(i) = last(j);
            next(last(j)) = i;
        end
        last(j) = i;
    end

    % Bucket sort
    sx = zeros(size(x)); % sorted array
    kk = 0;
    for j = 1:m
        % Check if jth bucket is nonempty
        if ~isnan(head(j))
            % Sort jth bucket
            x = insertionsort(x,prev,next,head(j));

            % Insert sorted elements into sorted array
            jj = head(j);
            while ~isnan(jj)
                kk = kk + 1;
                sx(kk) = x(jj);
                jj = next(jj);
            end
        end
    end

    
    if strcmp(order, 'ascending') 
        result = sx;
    else
        result = fliplr(sx);
    end
    
end

function x = insertionsort(x,prev,next,head)
    % Insertion sort for doubly-linked lists
    % Note: In practice, x xhould be passed by reference

    j = next(head); % start at second element
    while ~isnan(j)
        pivot = x(j);
        i = j;
        while (~isnan(prev(i)) && (x(prev(i)) > pivot))
            x(i) = x(prev(i));
            i = prev(i);
        end
        x(i) = pivot;
        j = next(j);
    end

end

function [min max] = minmax(x,n)
    % Efficient algorithm for finding the min AND max elements of an array

    % Initialize
    if ~mod(n,2)
        % n is even
        if (x(2) > x(1))
            min = x(1);
            max = x(2);
        else
            min = x(2);
            max = x(1);
        end
        i = 3;
    else
        % n is odd
        min = x(1);
        max = x(1);
        i = 2;
    end

    % Process elements in pairs
    while (i < n)
        if (x(i + 1) > x(i))
            mini = x(i);
            maxi = x(i + 1);
        else
            mini = x(i + 1);
            maxi = x(i);
        end
        if (mini < min)
            min = mini;
        end
        if (maxi > max)
            max = maxi;
        end
        i = i + 2;
    end

end
