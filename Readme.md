# README

This folder contains the scripts that are part of the MonteCarloRedistributionAlgorithm (MCRA) algorithm.
Following is the list of folders and files in this package.

## List of files

### AdjGraph

This folder contains the following files

1) *adjGraph.m* - The file to run the adjGraph GUI. The GUI can accomplish the following
	. Importing image files and the corresponding csv files (obtained using feature extraction). Samples provided
	. Creating a temporary adjacency network that can be adjusted manually by removing or adding neighbor links
	. Saving the information as a mat file that can be used for further processing.

2) adjGraph.fig - The fig file for the adjGraph GUI

3) overlayLabels.m - used to overlay fiber IDs on the images, within the GUI

4) processCsvForGui.m - used to parse the imported csv file to extract relevant information.

5) sampleImage.jpg - sample image to be used as input to adjGraph.m

6) sampleCsv.csv - sample csv to be used as input to adjGraph.m

### Combine Data

1) *combineDataMultipleImages.m* - The file to combine data from multiple micropscopy images

2) getMaxFiberIndexInAdj.m - supporting file for combineDataMultipleImages.m

3) updateAdjByconstantVal.m - supporting file for combineDataMultipleImages.m

### MCRA

1) *runMCRA.m* - the main file to be run to perform the MCRA for confetti images.

2) checkClustersConn.m - supporting file for runMCRA.m

3) findNeighborsWithoutColor.m - supporting file for runMCRA.m

4) getClusterStatisticsConn.m - supporting file for runMCRA.m

5) portOldAdjToNew.m - supporting file for runMCRA.m

6) saveVars.m - supporting file for runMCRA.m

3) clusterStatsAnalysisPercentileBins - used to generate the histogram figures from using the saved data from saveVars.m


## Usage
Run the runMCRA.m file making the appropriate changes to numSamples (number of permutations to perform), the range for lambda values - lambda_vals (if using a poisson distribution to approximate the number of neighboring fibers affected by a satellite cell), and loading the data file obtained from either a single image (adjGraph.m) or from combining multiple images (combineDataMultipleImages.m)

## License
[GPLv3](https://choosealicense.com/licenses/gpl-3.0/)