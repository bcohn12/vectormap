function [  ] = heatmap_pdfs_for_specific_column( MAT, col, measured_value_string)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%show the muscle activation vector maps for each muscle
    figure1 = figure;
    axes1 = axes('Parent',figure1);
    muscle_scatter(MAT, col, false);
    plotsettings_xyz_axes();
    titlename = measured_value_string
    title(titlename)
    colormap Jet
    colorbar('peer',axes1,'EastOutside','YLim',[0.0 1.0]);
    pdf_with_name(strcat('figs/', measured_value_string, 'vectormap',...
        num2str(muscle)))
    
end

end

