function [similarity] = CosineSimilarity(x1,x2)
%--------------------------------------------------------------------------
% Syntax:       [similarity] = CosineSimilarity(x1,x2);
% 
% Definition:   Cosine similarity is a measure of similarity between two
%		non-zero vectors of an inner product space that measures 
%		the cosine of the angle between them. The cosine of 0° is 
%		1, and it is less than 1 for any other angle. It is thus a
%		judgment of orientation and not magnitude: two vectors 
%		with the same orientation have a cosine similarity of 1, 
%		two vectors at 90° have a similarity of 0, and two vectors
%		diametrically opposed have a similarity of -1, independent
%		of their magnitude. Cosine similarity is particularly used
%		in positive space, where the outcome is neatly bounded in
%		[0,1]. The name derives from the term "direction cosine":
%		in this case, note that unit vectors are maximally 
%		"similar" if they're parallel and maximally "dissimilar"
%		if they're orthogonal (perpendicular). This is analogous 
%		to the cosine, which is unity (maximum value) when the 
%		segments subtend a zero angle and zero (uncorrelated) 
%		when the segments are perpendicular.[1].
%               
% Inputs:       [x1] is a vector
%		[x2] is a vector
%               
% Outputs:      [similarity] is between 0 and 1
%                             
% Complexity:   No
%
% Dependencies  No dependency.
%               
% Author:       Ugur Ayan, PhD
%               ugur.ayan@ugurayan.com.tr
%               http://www.ugurayan.com.tr
%               
% Date:         May 15, 2016
%
% Refrences     [1] https://en.wikipedia.org/wiki/Cosine_similarity
%--------------------------------------------------------------------------
if ( length (x1) == length(x2) )
    similarity = sum(x1.*x2) / (norm(x1) * norm(x2));
else
   disp('Vectors dimensions does  not match'); 
end
