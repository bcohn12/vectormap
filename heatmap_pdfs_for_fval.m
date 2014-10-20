function [  ] = heatmap_pdfs_for_fval( MAT, measured_value_string)

    figure1 = figure;
    axes1 = axes('Parent',figure1);
    fval_scatter(MAT, false);
    plotsettings_xyz_axes();
    titlename = measured_value_string;
    title(titlename)
    colormap Jet
    colorbar('peer',axes1,'EastOutside');
    pdf_with_name(strcat('figs/', measured_value_string, 'vectormap'))
    


end

