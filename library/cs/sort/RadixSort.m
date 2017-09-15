function [result, order] = RadixSort(x, r, o)
%--------------------------------------------------------------------------
% Syntax:       [result, order] = RadixSort(x, r, o);
%-------------------------------------------------------------------------
% Definition:   Radix sort is a non-comparative integer sorting algorithm 
%               that sorts data with integer keys by grouping keys by the
%               individual digits which share the same significant position
%               and value. A positional notation is required, but because 
%               integers can represent strings of characters (e.g., names 
%               or dates) and specially formatted floating point numbers, 
%               radix sort is not limited to integers. Radix sort dates 
%               back as far as 1887 to the work of Herman Hollerith on
%               tabulating machines. [1].
%-------------------------------------------------------------------------
% Inputs:       [x] is a vector of length len
%               'r' is the desired radix. The default value is r = 16
%               'o' is order ('ascending' or 'descending'), 
%                   default is 'ascending' 
%-------------------------------------------------------------------------
% Outputs:      [result] is the sorted version of x
%               'order' is the order type 'ascending' or 'descending' 
%-------------------------------------------------------------------------
% Complexity:   O(d.(n+r))   Best-case performance
%               O(d.(n+r))   Average-case performance
%               O(d.(n+r))   Worst-case performance
%               O(n)-aux     Worst-case space complexity
%              
%               where, for floating point inputs:
%               
%               d = ceil(eb / log2(r)) + ceil(fb / log2(r));
%               
%               +----------+----+----+
%               | class(x) | eb | fb |
%               +----------+----+----+
%               | 'single' |  8 | 23 |
%               | 'double' | 11 | 52 |
%               +----------+----+----+
%               
%               and, for integer inputs:
%               
%               d = ceil(b / log2(r))
%               
%               +----------+-----+
%               | class(x) |  b  |
%               +----------+-----+
%               | 'int8'   |  7  |
%               | 'uint8'  |  8  |
%               | 'int16'  |  15 |
%               | 'uint16' |  16 |
%               | 'int32'  |  31 |
%               | 'uint32' |  32 |
%               | 'int64'  |  63 |
%               | 'uint64' |  64 |
%               +----------+-----+
%-------------------------------------------------------------------------
% Dependencies: No dependency.
%-------------------------------------------------------------------------
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%-------------------------------------------------------------------------
% Date:         August 1, 2016
%-------------------------------------------------------------------------
% References:   [1] https://en.wikipedia.org/wiki/Radix_sort
% -------------------------------------------------------------------------
% Note:         Because of not supporting low-level operations such as bit
%               shifting, this method is nor efficient.
% -------------------------------------------------------------------------
% Pseudecode :
%
% -------------------------------------------------------------------------

    if nargin == 1 
        order = 'ascending';    % Default order
        r = 16;                 % Default radix
    elseif nargin > 1 && isnumeric(r) 
        order = 'ascending';    % Default order
    elseif ischar(r)
        order = r;
        r = 16;
    end
    
    % Parse inputs
    if (nargin == 1)
        
    end

    % Convert x to radix-r array
    dims = size(x);
    x = x(:);
    [rx n d] = array2baser(x,r); % rx is an (n x d) matrix
    rx = rx + 1;

    % Radix sort
    % Note: In practice, one would have to devise a scheme that avoids
    %       leveraging MATLAB's array indexing capabilities
    idx = (1:n)';
    for i = 0:(d - 2)
        % Sort by ith least-significant digit 
        idx = idx(countingsort(rx(idx,d - i),n,r));
    end
    pos = (rx(idx,1) >= 1); % nonnegative numbers
    x = [x(flipud(idx(logical(1 - pos))));x(idx(pos))]; % put negative numbers at beginning
    x = reshape(x,dims);
      
    if strcmp(order, 'ascending') 
        result = x;
    else
        result = fliplr(x);
    end
end

function idx = countingsort(x,n,r)
    % Elements of x assumed to be integers in the range [1,...,r]
    % Note: In practice, x xhould be passed by reference

    % Compute histogram
    C = zeros(r,1);
    for j = 1:n
        C(x(j)) = C(x(j)) + 1;
    end

    % Convert to cumulative histogram
    for i = 2:r
        C(i) = C(i) + C(i - 1);
    end

    % Return sorted indices
    idx = nan(n,1);
    for j = n:-1:1
        idx(C(x(j))) = j;
        C(x(j)) = C(x(j)) - 1;
    end

end

function [rx n d] = array2baser(array,r)
    % Converts array into its base-r format

    % Process x based on its class
    if isinteger(array)
        % Integer array
        switch class(array)
            case 'int8'
                b = 7;   % integer bits
            case 'uint8'
                b = 8;   % integer bits
            case 'int16'
                b = 15;  % integer bits
            case 'uint16'
                b = 16;  % integer bits
            case 'int32'
                b = 31;  % integer bits
            case 'uint32'
                b = 32;  % integer bits
            case 'int64'
                b = 63;  % integer bits
            case 'uint64'
                b = 64;  % integer bits
        end
        d = ceil(b / log2(r)) + 1; % number of base-r digits

        % Convert numbers to base-r
        n = length(array);
        rx = zeros(n,d);
        for i = 1:n
            % Convert array(i) to base-r
            rx(i,:) = [sign(array(i)) int2baser(abs(array(i)),r,d - 1)];
        end
    elseif isfloat(array)
        % Floating point array
        switch class(array)
            case 'single'
                eb = 8;  % exponent bits
                fb = 23; % fraction bits
            case 'double'
                eb = 11; % exponent bits
                fb = 52; % fraction bits
        end
        de = ceil(eb / log2(r)); % number of base-r exponent digits
        df = ceil(fb / log2(r)); % number of base-r fractional digits
        d = de + df + 1; % total number of base-r digits

        % Convert numbers to base-r
        n = length(array);
        rx = zeros(n,d);
        for i = 1:n
            % Convert array(i) to base-r
            rx(i,:) = float2baser(array(i),r,eb,de,d);
        end
    else
        error('Array must be floating point or integer');
    end

end

function hx = float2baser(x,r,eb,de,d)
    % Converts floating point number x to its biased exponent base-r format

    % Express x as abs(x) = f * 2^e, and then scale (e,f) so that
    % 1) e >= 0
    % 2) f in [0,r]
    if (abs(x) < realmin(class(x)))
        e = 0;
        f = r * abs(x) / realmin(class(x));
    else
        [f e] = log2(abs(x));    % abs(x) = f * 2^e, with 0.5 <= f < 1
        bias = 2^(eb - 1) - 2;
        e = e + bias;            % e >= 0
        f = r * (2 * (f - 0.5)); % f in [0,r]
    end

    % Convert to (e,f) to base-r with de base-r digits for the exponent and 
    % (d - de) base-r digits for the fraction (plus one sign digit at beginning)
    hx = zeros(1,d);
    hx(1) = sign(x);
    hx(2:(de + 1)) = int2baser(e,r,de);
    for j = (de + 2):d
        hx(j) = floor(f);
        f = r * rem(f,1);
    end

end

function rx = int2baser(x,r,d)
    % Converts an integer x in [0,...,r^d - 1] to base-r with exactly d digits

    rx = zeros(1,d);
    x = double(x);
    rx(d) = rem(x,r);
    while ((x > 0) && (d > 1))
        d = d - 1;
        x = floor(x / r);
        rx(d) = rem(x,r);
    end

end 
    