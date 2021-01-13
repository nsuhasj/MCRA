function adj_mat_conn = portOldAdjToNew(adjMat)
% portOldAdjToNew is a program that convers adjacency information from a list form to a matrix form

% Inputs:
% 	adjMat - adjacency information as a list (cell) with n*1 rows (n = number of fibers in image). Each element is an array of neighbors of the particular fiber

% Outputs:
%	adj_mat_conn - adjacency information as an n*n matrix with elements taking the value 1 for pairs of fibers that are nighbors of each other, and 0 otherwise.
 

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

l = length(adjMat);
adj_mat_conn = zeros(l);

for i = 1:l
    tmp = cell2mat(adjMat{i,1});
    adj_mat_conn(i,tmp) = 1;
end

assert(isequal(adj_mat_conn,adj_mat_conn'),'Resulting Adjacency matrix is not symmetric');
end