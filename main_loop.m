addpath('./mobility_patterns/');
addpath('./estimation_functions/');

% Load parameters from external file
params;

% Check the correctness of the base_stations matrix
assert(size(base_stations, 2) == 2);

% Map each function name to the parameters that we need to pass
mob_patterns_parameters_map = containers.Map(...
    cellfun(@(x) func2str(x), mob_patterns, 'UniformOutput', false),...
    mob_patterns_parameters);
errors = cell(size(mob_patterns, 2) * size(estimation_functions, 2));

i = 1;
for mob_pattern = mob_patterns;
    for estimation_function = estimation_functions;
        errors{i} = test_function(...
            estimation_function{1}, mob_pattern{1}, base_stations,...
            mob_patterns_parameters_map(...
            func2str(mob_pattern{1})), alpha, mu, sigma, P_0, d_0...
            );
        i = i + 1;
    end;
end;

% Graph plotting stuff
% 2 figures containing many subplots

close all

nb_est_func = size(estimation_functions, 2);
nb_mob_patterns = size(mob_patterns, 2);

% Colormap
cc = lines(max(nb_est_func, nb_mob_patterns));

<<<<<<< HEAD
    for func_idx = 1:size(functions, 2);
        %estimate the coordinates using all algorithms
        %(currently implemented algorithms: LLS, WLS)
        estimated_coord{func_idx}(i, :) = functions{func_idx}(base_stations, estimated_dist);
=======
figure('Name', 'Estimation functions')
for i = 1:nb_est_func;
    subplot(nb_est_func, 1, i)
    for j = 1:nb_mob_patterns;
        h = cdfplot(errors{i + (j -1) * nb_est_func});
        set(h, 'DisplayName', func2str(mob_patterns{j}), 'Color', cc(j, :))
        hold on
>>>>>>> 7e33a1367b834ff693252b00779e4d3b96880020
    end;
    hold off
    xlabel('Localization error [m]')
    ylabel('CDF')
    legend('show')
    title(func2str(estimation_functions{i}))
end;

figure('Name', 'Mobility patterns')
for i = 1:nb_mob_patterns;
    subplot(nb_mob_patterns, 1, i)
    for j = 1:nb_est_func;
        h = cdfplot(errors{(i -1) * nb_mob_patterns + j});
        set(h, 'DisplayName', func2str(estimation_functions{j}), 'Color', cc(j, :))
        hold on
    end;
    hold off
    xlabel('Localization error [m]')
    ylabel('CDF')
    legend('show')
    title(func2str(mob_patterns{i}))
end;