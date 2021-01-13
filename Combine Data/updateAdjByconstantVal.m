function adj = updateAdjByconstantVal(adj,offset)
% updateAdjByconstantVal updates the fiber id values by a fixed offset. This is of use
% when multiple images are combined and hence the fiber ids of the second image are increased by
% a set value so as to avoid duplicate numbering with the first image

% Inputs:
% 	adj - adjacency information as a list (cell) with n*1 rows (n = number of fibers in image). Each element is an array of neighbors of the particular fiber
% 	offset - the value by which the fiber ids are to be increased.

% Output :
%	adj - adjacency information with updated fiber ids, as a list (cell) with n*1 rows (n = number of fibers in image). Each element is an array of neighbors of the particular fiber
 

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

for i = 1:length(adj)
    m = cell2mat(adj{i});
    m = m+offset;
    adj{i} = num2cell(m);
end

end