function clusterStatsAnalysisPercentileBins(img_suffix,numSamples, clusterStats_perm, clusterStats_orig, megaPatchPrctile)
% clusterStatsAnalysisPercentileBins plots histograms for the number of fibers in either
% singleton patches (size = 1) or mega-patches.

% Inputs:
% 	img_suffix - the suffix for the filanames used for saving images
%	numSamples - number of rounds of stochastic redistribution performed earlier (number of random samples)
%	clusterStats_perm - variable containing the number of patches of each size in the random samples
%	clusterStats_orig - variable containing the number of patches of each size in the original image
%	megaPatchPrctile - the threshold (lower bound) to define what constitutes mega patches
 

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

clc; warning off;
clust_sizes = zeros(numSamples,4);
for j = 1:numSamples
    clust_sizes(j,1) = size(clusterStats_perm{1,j},2);
    clust_sizes(j,2) = size(clusterStats_perm{2,j},2);
    clust_sizes(j,3) = size(clusterStats_perm{3,j},2);
    clust_sizes(j,4) = size(clusterStats_perm{4,j},2);
end

Cyan = zeros(numSamples,max(clust_sizes(:,1)));
Red = zeros(numSamples,max(clust_sizes(:,2)));
Yellow = zeros(numSamples,max(clust_sizes(:,3)));
Green = zeros(numSamples,max(clust_sizes(:,4)));

for j = 1:numSamples
    Cyan(j,1:clust_sizes(j,1)) = cell2mat(clusterStats_perm(1,j));
    Red(j,1:clust_sizes(j,2)) = cell2mat(clusterStats_perm(2,j));
    Yellow(j,1:clust_sizes(j,3)) = cell2mat(clusterStats_perm(3,j));
    Green(j,1:clust_sizes(j,4)) = cell2mat(clusterStats_perm(4,j));
end


col= {'Cyan','Red','Yellow','Green'};
col_int = 0.8;   
plot_colors = col_int * [0 1 1; 1 0 0;1 1 0; 0 1 0];
x_scale = 100;
clustnames = {'single','mega'};

for c = 1:4
    col_index = c;
    eval(['colData = ',col{col_index},';']);
    colData_sum = sum(colData);
    y = colData_sum.*(1:size(colData_sum,2));
    y = y/sum(y);
    y1 = abs(cumsum(y) - (megaPatchPrctile/100));
    megaPatchSize = find(y1 == min(y1)) + 1;
    if megaPatchSize > length(y)
        megaPatchSize = length(y);
    end
    
	if megaPatchSize == 2
        clusts_to_plot = [1 1; 2 length(y)];
    else
        clusts_to_plot = [1 1;megaPatchSize length(y)];
    end
    
    
    orig = cell2mat(clusterStats_orig(col_index,1));
    scaleFact = 1:length(orig);
    orig = orig.*scaleFact;
    orig = orig./sum(orig);
    
    scaleFact2 = repmat(1:size(colData,2),size(colData,1),1);
    scaledData = colData.*scaleFact2;
    scaledData = bsxfun(@times, scaledData, 1./(sum(scaledData, 2)));
   
    for cp = 1:size(clusts_to_plot,1)
        clf;
        clust_start = clusts_to_plot(cp,1);
        clust_end = clusts_to_plot(cp,2);
        [cp clust_start clust_end size(colData,2)];
        if clust_start > size(colData,2)
            continue;
        end
        
        if clust_end > size(colData,2)
            clust_end = size(colData,2);
        end
        
        y2 = [0 cumsum(y)];
        prctiles = 100*[y2(clust_start) y2(clust_end+1)];

        try
            if clust_end > length(orig)
                orig_line = sum(orig(clust_start:end));
            else
                orig_line = sum(orig(clust_start:clust_end));
            end
            data_to_plot = sum(scaledData(:,clust_start:clust_end),2);
           
		   if cp == 1
                numBins = 5;
            else
                numBins = 10;
            end
            
			hist(x_scale*data_to_plot,numBins);
            h = findobj(gca,'Type','patch');
            set(h,'FaceColor',plot_colors(c,:),'EdgeColor','w');
            hold on;
            yl =ylim;
            line(x_scale*[orig_line orig_line],yl,'Color','k','LineWidth',2);
            
            if clust_start == clust_end
                 xlabel(['% of fibers in patches of size ',num2str(clust_start),' : Percentile ',num2str(prctiles(1),'%2.1f'),'-',num2str(prctiles(2),'%2.1f')],'Fontsize',13);
            else
                 xlabel(['% of fibers in patches of size ',num2str(clust_start),'-',num2str(clust_end),' : Percentile ',num2str(prctiles(1),'%2.1f'),'-',num2str(prctiles(2),'%2.1f')],'Fontsize',13);
            end

            ylabel('Frequency','Fontsize',15);
            xlim([0 x_scale]);
            ylim(yl);
            set(gca,'XTick',0:10:100,'FontSize',17,'Box','off');
            filename = [col{col_index},'_',img_suffix,'_',clustnames{cp},'.png'];
            eval(['export_fig -m3 -transparent  ',filename,';']);
        catch
            break;
        end
    end
end
