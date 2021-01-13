function fiberList = findNeighborsWithoutColor(use_lambda,lambda,numFibersLeft,fiberColors,adj,allowOverlap)
% findNeighborsWithoutColor 

% Inputs:
% 	use_lambda - variable to toggle between choosing one neighbor or a few neighbors froma  poisson distribution
%	lambda - mean value of the poisson distribution from which the number of neighbors 
%	numFibersLeft - number of fibers yet to be assigned a particular color
%	fiberColors - a vector of length n*1 (n = number of fibers in image), with 1 for fibers containing the color and 0 for those without 
%	adj - the adjacency network indicating neighbor-neighbor relationship between fibers
%	allowOverlap - variable to toggle between allowing same fibers to be chosen again or not

% Outputs:

%	fiberList - a vector of length n*1 (n = number of fibers in image), with 1 for fibers to be assigned the color during random sampling
 

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

if nargin < 6
    allowOverlap = 1;
end

numFibers = length(fiberColors);
s = 1;
inner_index = 0;

while ~s==0
    if mod(inner_index,100) == 0
        n = numFibers+1;
        while n > numFibersLeft
			if use_lambda
				n = poissrnd(lambda)+1;
			else
				n = 1;
			end
        end
    end
    
    inner_index = inner_index + 1;
    fiberList = zeros(n,1);
    f = randi(numFibers,1);
    fiberList(1,1) = f;
    
    if n > 1
        for i = 2:n
            neigh = cell2mat(adj{f});
            if(isempty(neigh))
                inner_index = 0;
                break;
            end
            
            doubleInnerIndex = 0;

                repeatedFiber = 1;
                while repeatedFiber
                    r = randi(length(neigh),1);
                    repeatedFiber = ~isempty(find(fiberList==neigh(r),1));
                    doubleInnerIndex = doubleInnerIndex + 1;
                    if doubleInnerIndex == 100
                        break;
                    end
                end
                     
            if doubleInnerIndex == 100
                inner_index = 0;
                break;
            end
            
            f = neigh(r);
            fiberList(i,1) = f;
        end
    end
    
    if fiberList(n) > 0
        if allowOverlap == 0
            cols = fiberColors(fiberList);
            s = sum(cols);
        else
            s = 0;
        end
    end
end

end