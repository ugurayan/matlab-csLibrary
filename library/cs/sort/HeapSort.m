function [result, order] = HeapSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = HeapSort(x, o);
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
% procedure heapsort(a, count) is
%     input: an unordered array a of length count
%  
%     (Build the heap in array a so that largest value is at the root)
%     heapify(a, count)
% 
%     (The following loop maintains the invariants that a[0:end] is a heap 
%      and every element beyond end is greater than everything before it 
%     (so a[end:count] is in sorted order))
%     end ← count - 1
%     while end > 0 do
%         (a[0] is the root and largest value. The swap moves it in front 
%          of the sorted elements.)
%         swap(a[end], a[0])
%         (the heap size is reduced by one)
%         end ← end - 1
%         (the swap ruined the heap property, so restore it)
%         siftDown(a, 0, end)
%         
% (Put elements of 'a' in heap order, in-place)
% procedure heapify(a, count) is
%     (start is assigned the index in 'a' of the last parent node)
%     (the last element in a 0-based array is at index count-1; find the 
%      parent of that element)
%     start ← iParent(count-1)
%     
%     while start ≥ 0 do
%         (sift down the node at index 'start' to the proper place such 
%          that all nodes below the start index are in heap order)
%         siftDown(a, start, count - 1)
%         (go to the next parent node)
%         start ← start - 1
%     (after sifting down the root all nodes/elements are in heap order)
% 
% (Repair the heap whose root element is at index 'start', assuming the 
%  heaps rooted at its children are valid)
% 
%  procedure siftDown(a, start, end) is
%     root ← start
% 
%     while iLeftChild(root) ≤ end do (While root has at least one child)
%         child ← iLeftChild(root)   (Left child of root)
%         swap ← root                (Keeps track of child to swap with)
% 
%         if a[swap] < a[child]
%             swap ← child
%         (If there is a right child and that child is greater)
%         if child+1 ≤ end and a[swap] < a[child+1]
%             swap ← child + 1
%         if swap = root
%             (The root holds the largest element. Since we assume the 
%              heaps rooted at the
%              children are valid, this means that we are done.)
%             return
%         else
%             swap(a[root], a[swap])
%             root ← swap            
%             (repeat to continue sifting down the child now)        
% -------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    %  Build max-heap from x
    len = length(x);
    x = buildmaxheap(x,len);

    % Heapsort
    heapsize = len;
    for i = len:-1:2
        % Put (n + 1 - i)th largest element in place
        x = swap(x,1,i);

        % Max-heapify x(1:heapsize)
        heapsize = heapsize - 1;
        x = maxheapify(x,1,heapsize);
    end

    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end

function x = buildmaxheap(x,n)
    % Build max-heap out of x
    % Note: In practice, x xhould be passed by reference

    for i = floor(n / 2):-1:1
        % Put children of x(i) in max-heap order
        x = maxheapify(x,i,n);
    end

end

function x = maxheapify(x,i,heapsize)
    % Put children of x(i) in max-heap order
    % Note: In practice, x xhould be passed by reference

    % Compute left/right children indices
    ll = 2 * i; % Note: In practice, use left bit shift
    rr = ll + 1; % Note: In practice, use left bit shift, then add 1 to LSB

    % Max-heapify
    if ((ll <= heapsize) && (x(ll) > x(i)))
        largest = ll;
    else
        largest = i;
    end
    if ((rr <= heapsize) && (x(rr) > x(largest)))
        largest = rr;
    end
    if (largest ~= i)
        x = swap(x,i,largest);
        x = maxheapify(x,largest,heapsize);
    end

end

function x = swap(x,i,j)
    val = x(i);
    x(i) = x(j);
    x(j) = val;
end
