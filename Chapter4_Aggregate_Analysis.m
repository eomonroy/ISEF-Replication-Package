% =========================================================================
% Phase 5: Aggregate Mean Entropy Analysis (With Full Export)
% =========================================================================

% Initialize storage for our results
results_list = {};
domain_names = fieldnames(telemetryData);

for d = 1:length(domain_names)
    current_domain = domain_names{d};
    
    % Get all Baseline run IDs in this domain
    runIDs = fieldnames(telemetryData.(current_domain).Baseline);
    
    for r = 1:length(runIDs)
        baseID = runIDs{r};
        gatedID = [baseID, '_ISEF']; % Construct corresponding Gated ID
        
        % Calculate Mean Entropy: Baseline
        base_probs = telemetryData.(current_domain).Baseline.(baseID).Probabilities;
        mean_base = mean(base_probs.Entropy);
        
        % Calculate Mean Entropy: ISEF-Gated
        gated_probs = telemetryData.(current_domain).ISEF_Gated.(gatedID).Probabilities;
        mean_gated = mean(gated_probs.Entropy);
        
        % Calculate the shift (Delta)
        delta = mean_gated - mean_base;
        
        % Store the row data
        results_list(end+1, :) = {current_domain, baseID, mean_base, mean_gated, delta};
    end
end

% 1. Convert to a structured MATLAB Table and display
AggregateResults = cell2table(results_list, ...
    'VariableNames', {'Domain', 'Scenario_ID', 'Mean_Baseline', 'Mean_ISEF', 'Delta'});

disp('=============================================================================');
disp('                  AGGREGATE MEAN ENTROPY SHIFT (12 PAIRED RUNS)              ');
disp('=============================================================================');
disp(AggregateResults);

% 2. Generate a Grouped Bar Chart for visual comparison
fig3 = figure('Name', 'Aggregate Mean Entropy: Baseline vs ISEF', 'Position', [150, 150, 1200, 600]);

% Group the baseline and gated means together for the bar chart
bar_data = [AggregateResults.Mean_Baseline, AggregateResults.Mean_ISEF];
b = bar(bar_data, 'grouped');

% Styling to match previous visuals
b(1).FaceColor = [0 0.4470 0.7410]; % Default Blue
b(2).FaceColor = [0.8500 0.3250 0.0980]; % Default Orange

% Formatting the axes and labels
set(gca, 'xtick', 1:12, 'xticklabel', strrep(AggregateResults.Scenario_ID, '_', '\_'));
xtickangle(45); % Tilt labels for readability
ylabel('Mean Shannon Entropy (Over All Tokens)');
title('Systematic Shift in Mean Token Entropy: Baseline vs. ISEF-Gated', 'Interpreter', 'none');
legend('Baseline', 'ISEF-Gated', 'Location', 'NorthWest');
grid on;

% 3. --- Auto-Save Section (Updated) ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Save the Figure (PNG and FIG)
pngFileName = fullfile(outputDir, 'Aggregate_Entropy_Comparison.png');
figFileName = fullfile(outputDir, 'Aggregate_Entropy_Comparison.fig');
exportgraphics(fig3, pngFileName, 'Resolution', 300);
savefig(fig3, figFileName);

% Save the Data Table as CSV
csvFileName = fullfile(outputDir, 'Aggregate_Entropy_Results.csv');
writetable(AggregateResults, csvFileName);

disp('Aggregate analysis complete.');
disp([' - High-res PNG & raw FIG saved to: ', outputDir]);
disp([' - Data table saved as CSV to: ', csvFileName]);


