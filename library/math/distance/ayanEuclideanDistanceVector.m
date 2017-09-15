function [Distance] = EuclideanDistanceVector(x1,x2)
%--------------------------------------------------------------------------
% Syntax:       [Distance] = EuclideanDistanceVector(x1,x2);
% 
% Definition:   Euclidean distance or Euclidean metric is the "ordinary" 
%		straight-line distance between two points in Euclidean 
%		space. With this distance, Euclidean space becomes a metric
%		space. The associated norm is called the Euclidean norm[1].
%               
% Inputs:       [x1] is a vector 
%		[x2] is a vector              
%  
% Outputs:      [Distance] 
%                             
% Complexity:   No
%
% Dependencies  No dependency.
%               
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%               
% Date:         May 25, 2016
%
% Refrences     [1] https://en.wikipedia.org/wiki/Euclidean_distance
%--------------------------------------------------------------------------

if ( length (x1) == length(x2) )
    distance = norm(x1-x2);
else
   disp('Vectors dimensions does not match'); 
end
