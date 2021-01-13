%%
% combineDataMultipleImages is a program that can help combine the data mat files
% corresponding to multiple images (each of which is obtained by using the adjGraph  program.
% The mat files to be combined are selected through a file selet gui seen when this script is run.
% The final output is a variable called "data" that contains fiber information from all selected images.

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


clear; clc;
matFiles = uigetfile('*.mat','Select the INPUT DATA FILE(s)','MultiSelect','on');

combinedData2.adj = {};
combinedData2.centroids = [];
combinedData2.feret_dia = [];
combinedData2.fiberColors = [];
total_size = 0;

for i = 1:length(matFiles)
    clear data combinedData;
    eval(['load ''',matFiles{i},''';']);
    if exist('combinedData','var')
        data = combinedData;
    end
    combinedData2.centroids = [combinedData2.centroids; data.centroids];
    combinedData2.feret_dia = [combinedData2.feret_dia; data.feret_dia];
    combinedData2.fiberColors = [combinedData2.fiberColors; data.fiberColors];
    combinedData2.adj = [combinedData2.adj; updateAdjByconstantVal(data.adj,total_size)];
    total_size = total_size + getMaxFiberIndexInAdj(data.adj);
end

clear data;
data = combinedData2
clear combinedData2;