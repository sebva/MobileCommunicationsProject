addpath('./mobility_patterns/');
addpath('./estimation_functions/');
addpath('./filters/');

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
        for filter = filters;
            errors{i} = test_function(...
                estimation_function{1}, mob_pattern{1}, filter{1}, ...
                base_stations, mob_patterns_parameters_map(...
                func2str(mob_pattern{1})), alpha, mu, sigma, P_0, d_0...
                );
            i = i + 1;
        end;
    end;
end;

% Graph plotting stuff
% 2 figures containing many subplots

close all

nb_est_func = size(estimation_functions, 2);
nb_mob_patterns = size(mob_patterns, 2);
nb_filters = size(filters, 2);

% Colormap
cc = lines(max(nb_est_func * nb_filters, nb_mob_patterns));

figure('Name', 'Estimation functions')
for i = 1:nb_est_func;
    for j = 1:nb_filters;
        subplot(nb_est_func * nb_filters, 1, (i -1) * nb_filters + j)

        for k = 1:nb_mob_patterns;
            h = cdfplot(errors{(i -1) * nb_filters + (k -1) * nb_est_func * nb_filters + j});
            set(h, 'DisplayName', func2str(mob_patterns{k}), 'Color', cc(k, :))
            hold on
        end;
        
        hold off
        xlabel('Localization error [m]')
        ylabel('CDF')
        legend('show')
        funcname = func2str(estimation_functions{i});
        if(~isnumeric(filters{j}));
            funcname = strcat(funcname, {' with '}, func2str(filters{j}));
        end;
        title(funcname)
    end;
end;

figure('Name', 'Mobility patterns')
for i = 1:nb_mob_patterns;
    subplot(nb_mob_patterns, 1, i)
    for j = 1:nb_est_func;
        for k = 1:nb_filters;
            h = cdfplot(errors{(i -1) * nb_est_func * nb_filters + (j -1) * nb_filters + k});
            funcname = func2str(estimation_functions{j});
            if(~isnumeric(filters{k}));
                funcname = char(strcat(funcname, {' with '}, func2str(filters{k})));
            end;
            set(h, 'DisplayName', funcname, 'Color', cc((j -1) * nb_filters + k, :))
            hold on
        end;
    end;
    hold off
    xlabel('Localization error [m]')
    ylabel('CDF')
    legend('show')
    title(func2str(mob_patterns{i}))
end;