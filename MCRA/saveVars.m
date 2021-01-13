function saveVars(filename,clusterStats_perm,cluster_perm,clusterStats_orig,cluster_orig)
% saveVars saves the variables clusterStats_perm, cluster_perm, clusterStats_orig and cluster_orig

% Inputs:
% 	filename - The name of the file to which the 4 variables are to be saved
%	clusterStats_perm - variable indicating the number of patches of different sizes in the random samples
%	cluster_perm - variable indicating the ids of fibers in each patch in the random samples
%	clusterStats_orig - variable indicating the number of patches of different sizes in the original images
%	cluster_orig - variable indicating the ids of fibers in each patch in the original images
 

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

    save(filename,'clusterStats_perm','cluster_perm','clusterStats_orig','cluster_orig');
end