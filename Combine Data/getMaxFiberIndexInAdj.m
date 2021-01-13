function maxNum  = getMaxFiberIndexInAdj(adj)

% getMaxFiberIndexInAdj is a program that parses the adjacency list of an image with n fibers and returns the highest value of id in the list

% Inputs:
% 	adj- adjacency information as a list (cell) with n*1 rows (n = number of fibers in image). Each element is an array of neighbors of the particular fiber

% Outputs:
%	maxNum - the highest fiber ID value among all fibers in the image
 

%{
  This file is part of MonteCarloRedistributionAlgorithm (MCRA)
  Copyright (C) 2020  N. Suhas Jagannathan
  MCRA is free software: you can redistribute it and/or modify it 
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  MCRA is distributed in the hope that it will be useful,but WITHOUT 
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
  for more details.You should have received a copy of the GNU General 
  Public License along with MCRA.  If not, see <https://www.gnu.org/licenses/>.
%}

maxNum = 0;
for i = 1:length(adj);
    tmp = cell2mat(adj{i,1});
    if isempty(tmp)
        continue;
    end
    
    if max(tmp) > maxNum
        maxNum = max(tmp);
    end
    
end

if length(adj) > maxNum
    maxNum = length(adj);
end
end