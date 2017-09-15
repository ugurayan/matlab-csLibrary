function W = Huber(res, scale, param)
%--------------------------------------------------------------------------
% Syntax:       W = Huber(res, scale, param);
% 
% Definition:   Computes Huber's weight function for robust regression:
%               min( 1, param/(|res|/scale) )
%               
% Inputs:       [res] : vector of residuals
%               scale : robust estimate of scale, such as MAD
%               param : parameter of the Huber function; the
%                       default value is 2.5
%               
% Outputs:      [W] Huber's weight function
%                             
% Complexity:   
%
% Dependencies  No dependency.
%               
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%               
% Date:         May 1, 2017
%
% Refrences     

p = 2.5;        % default parameter
if (nargin == 3)
    if (param > 0)
        p = param;
    else
        error('parameter must be positive')
    end
end

unit = ones(size(res));
res(res == 0 ) = p*scale*unit(res==0);
W = min(unit, scale*p*(abs(res)).^(-1));
return;
end

