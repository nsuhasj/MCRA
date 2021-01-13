%%
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

% This is the working code to run the random sampling analysis of the MCRA


numSamples = 1000;
lambda_vals = 0.05:0.05:0.25;
numFibers = length(data.fiberColors);
adj_mat_conn = portOldAdjToNew(data.adj);
clusters_orig = checkClustersConn(adj_mat_conn,data.fiberColors);
clusterStats_orig = getClusterStatisticsConn(clusters_orig);

tic;
for l = 1:length(lambda_vals)
    clusters_perm = cell(4,numSamples);
    lambda = lambda_vals(l);
    savefilename = ['PatchAnalysis_',num2str(lambda*100),'.mat'];
    for s = 1:numSamples
        if mod(s,100)==0
            fix([l s clock])
            if mod(s,100)==0
                clusterStats_perm = getClusterStatisticsConn(clusters_perm);
                saveVars(savefilename,clusterStats_perm,clusters_perm,clusterStats_orig,clusters_orig);
            end
        end
        
        
        tmp_fiber_cols = zeros(numFibers,4);
        for c = 1:4
            numFibersToColor = sum(data.fiberColors(:,c));
            numFibersLeft = numFibersToColor;
            while numFibersLeft > 0
                fibersToColor = findNeighborsWithoutColor(lambda,numFibersLeft,tmp_fiber_cols(:,c),data.adj,1);
                tmp_fiber_cols(fibersToColor,c) = 1;
                numFibersLeft = numFibersToColor - sum(tmp_fiber_cols(:,c));
            end
            sum(tmp_fiber_cols(:,c));
        end
        clusters_perm(:,s) = checkClustersConn(adj_mat_conn,tmp_fiber_cols);
    end
    clusterStats_perm = getClusterStatisticsConn(clusters_perm);
    saveVars(savefilename,clusterStats_perm,clusters_perm,clusterStats_orig,clusters_orig);
end
timeTaken = toc