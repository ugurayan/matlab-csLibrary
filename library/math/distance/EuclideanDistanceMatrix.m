function [Distance] = EuclideanDistanceMatrix(M)
%--------------------------------------------------------------------------
% Syntax:       [Distance] = EuclideanDistanceMatrix(M);
% 
% Definition:   Euclidean distance or Euclidean metric is the "ordinary" 
%		straight-line distance between two points in Euclidean 
%		space. With this distance, Euclidean space becomes a metric
%		space. The associated norm is called the Euclidean norm[1].
%               
% Inputs:       [M] is a matrix ( document x  features)
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

[d, f] = size(M); % d is the rows/documents and f is the features
 % Calculate distance matrix
 Distance=zeros(d,d);
 for i=1:d
     for j=i+1:d
         if ( i==j )
             Distance(i,j)= 0;
         else
             Distance(i,j) = norm(M(i,:)-M(j,:));
             Distance(j,i)=Distance(i,j);
         end
     end
 end
 % distance is calculated
