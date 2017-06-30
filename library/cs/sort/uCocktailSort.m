function [result, order] = uCocktailSort(x, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = uCocktailSort(x, o);
%-------------------------------------------------------------------------
% Definition:   Cocktail shaker sort, also known as bidirectional bubble 
%               sort, cocktail sort, shaker sort (which can also refer to 
%               a variant of selection sort), ripple sort, shuffle sort,or
%               shuttle sort, is a variation of bubble sort that is both a 
%               stable sorting algorithm and a comparison sort. The 
%               algorithm differs from a bubble sort in that it sorts in 
%               both directions on each pass through the list. This sorting
%               algorithm is only marginally more difficult to implement 
%               than a bubble sort, and solves the problem of turtles in 
%               bubble sorts. It provides only marginal performance 
%               improvements, and does not improve asymptotic performance; 
%               like the bubble sort, it is not of practical interest 
%               (insertion sort is preferred for simple sorts), though it 
%               finds some use in education [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(n)      Best-case performance
%               Θ(n+k)    Average-case performance
%               O(n^2)    Worst-case performance
%               O(1)      Worst-case space complexity
%-------------------------------------------------------------------------
% Dependencies  No dependency.
%--------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%--------------------------------------------------------------------------               
% Date:         May 7, 2016
%--------------------------------------------------------------------------
% Refrences     [1] https://en.wikipedia.org/wiki/Cocktail_shaker_sort
%--------------------------------------------------------------------------

    if nargin == 1
        order = 'ascending'; %default
    else
        order = o;
    end
    
    % Cocktail sort
    len = length(x);
    ll = 0;
    uu = len - 1;
    swapped = true;
    while (swapped == true)
        % Forward bubble sort pass
        swapped = false;
        ll = ll + 1;
        for i = ll:uu
            if (x(i) > x(i + 1))
                x = swap(x,i,i + 1);
                swapped = true;
            end
        end
        if (swapped == true)
            % Backwards bubble sort pass
            swapped = false;
            uu = uu - 1;
            for i = uu:-1:ll
                if (x(i) > x(i + 1))
                    x = swap(x,i,i + 1);
                    swapped = true;
                end
            end
        end
    end
    
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end

function x = swap(x,i,j)
    % Swap x(i) and x(j)
    % Note: In practice, x xhould be passed by reference

    val = x(i);
    x(i) = x(j);
    x(j) = val;
end