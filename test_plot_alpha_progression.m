muscles_of_interest = [13 14 16 18 19 20 21 23 25 27 30 5];
load('output/C_13_14_16_18_19_20_21_23_25_30_27_5_both.mat')
for i = 1:5
    C{1,i} = (0.1*i + 0.4)
end
plot_alpha_progression(C, 'normal', muscles_of_interest)
load('output/C_scaled_13_14_16_18_19_20_21_23_25_30_27_5_both.mat')
for i = 1:5
    C{1,i} = (0.1*i + 0.4)
end
plot_alpha_progression(C, 'peroneus_scaled', muscles_of_interest)


%mini
muscles_of_interest = [13 14 16 18 19 20 21 23 25 27 30 5];
load('output/C_13_14_16_18_19_20_21_23_25_30_27_5_both.mat')
for i = 1
    C{1,i} = (0.1*i + 0.4)
end
plot_alpha_progression(C, 'normal', [30])