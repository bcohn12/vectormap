function [] = pdfs_alpha_progression(C, num_muscles, label)
%C is the cell array, where 1st row shows the alpha labels, 2nd row is
%lowerbound, 3rd row is upperbound. each column is at a given alpha level.
bound = ['lowerbound_'; 'upperbound_'];
for musclenum = 1:num_muscles
    for boundnum = [1,2]
        for scale_i = 1:2
        for alpha_i = 1:length(C)
            measured_value_string =  strcat( label, 'm', num2str(musclenum),...
                                     bound(boundnum,:),...
                                    'alpha', num2str(alpha_i+4))
            task_scatter(C{boundnum+1,alpha_i}, musclenum, false)
            disp('plotted, onto saving now')
            pdf_with_name(strcat('figs/', measured_value_string, 'vectormap'));
            disp('done saving. endloop')
            close
        end
    end
    end
end
end
