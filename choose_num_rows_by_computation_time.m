function [ calls ] = choose_num_rows_by_computation_time()
% input time_available in minutes
% input calls_per_second_average in calls per second
% set for brian's macbook jun 24, 2014
    time = linspace(0,60, 100); %from 0 to five hours
    calls = 1500*time
    plot(time, calls)

end

