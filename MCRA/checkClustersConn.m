function clusters = checkClustersConn(adj_mat_conn,fiberColors)
% checkClustersConn extracts connected components (distinct patches)
% of each color from the adjacency graph of the fiber neighbor-neighbor network.

% Inputs:
% 	adj_mat_conn - an nxn matrix that contains 1 for fibers that are neighbors of each other
% 	fiberColors - an nx4 matrix with each column representing one color (Cyan, Red, Yellow, Green) and the elements being 1 if a fiber has a color, or 0 otherwise

% Outputs:
% 	clusters - a list of patches with the ids of all fibers in each patch/cluster

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

clusters = cell(4,1);
for color = 1:4
    tmp = adj_mat_conn;
    nc = find(fiberColors(:,color) == 0);
    tmp(nc,:) = [];
    tmp(:,nc) = [];
    [~,c] = graphconncomp(sparse(tmp),'Directed',false);
    clusters{color,1} = num2cell(c);
end
end

