function overlayLabels(data,hidelines)

centroids = data.centroids;
adj = data.adj;

if hidelines == 1
    for i = 1:length(centroids)
        for j = 1:length(adj{i})
            k = adj{i}{j};
            line([centroids(i,1),centroids(k,1)],[centroids(i,2),centroids(k,2)],'Color','w','LineWidth',1.5)
        end
    end
end

for i = 1:length(centroids)
    text(centroids(i,1), centroids(i,2),num2str(i),'Color','w','FontWeight','bold')
end

end