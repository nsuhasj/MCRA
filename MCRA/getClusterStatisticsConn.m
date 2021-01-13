function clusterStats = getClusterStatisticsConn(clusters)
% getClusterStatisticsConn 

% Inputs:
% 	clusters - variable containing the ids of fibers in each patch in the image

% Outputs:
%	clusterStats - a variable summarizing the number of patches of each size in an image
 

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

clusterStats = cell(4,size(clusters,2));
for s = 1:size(clusters,2)
    for color = 1:4
        clust = cell2mat(clusters{color,s});
        u = max(clust);
        si_u = 0*(1:u);
        for i = 1:u;
            si_u(i) = length(find(clust==i));
        end
        
        hist_u = 0 *(1:max(si_u));
        for i = 1:max(si_u);
           hist_u(i) = length(find(si_u==i));
        end
        clusterStats(color,s) = {hist_u};
    end
end
end
