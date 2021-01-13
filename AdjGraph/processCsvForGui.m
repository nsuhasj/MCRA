function [adjGraph, centroids, feret_dia, fiberColors] = processCsvForGui(dataFile,threshold,hidelines,noheaders)

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


if nargin > 3 && noheaders
    fiberData = csvread(dataFile);
else
    fiberData = csvread(dataFile,1,0);
end

centroids = fiberData(:,6:7);
feret_dia = fiberData(:,11);
fiberColors = fiberData(:,13:16);

adjGraph = cell(length(feret_dia),1);

for i = 1:length(centroids)
    tmp = [];
    for j = 1:length(centroids)
        if j == i
            continue;
        end
        dist = sqrt(sum((centroids(i,:)-centroids(j,:)).^2));
        sum_radii = (feret_dia(i)+feret_dia(j))/2;
        if dist-sum_radii <= threshold
            tmp = [tmp j];
        end
    end
    warning off;
    adjGraph{i} = num2cell(tmp);
    warning on;
end
end