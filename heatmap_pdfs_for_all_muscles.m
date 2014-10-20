function [  ] = heatmap_pdfs_for_all_muscles( MAT, measured_value_string )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%show the muscle activation vector maps for each muscle
for muscle = 1:31
    figure1 = figure;
    axes1 = axes('Parent',figure1);
    muscle_scatter(MAT, muscle, false);
    plotsettings_xyz_axes();
    titlename = full_muscle_name(muscle, false);
    title(titlename)
    colormap Jet
    colorbar('peer',axes1,'EastOutside','YLim',[0.0 1.0]);
    pdf_with_name(strcat('figs/', measured_value_string, 'vectormap',...
        num2str(muscle)))
    
end

end

