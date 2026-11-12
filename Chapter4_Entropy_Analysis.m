% =========================================================================
% Phase 4a: Shannon Entropy Comparison (Baseline vs. ISEF-Gated)
% =========================================================================

domain = 'Medical';
baseID = 'MED_SYN_001';
gatedID = 'MED_SYN_001_ISEF';

% 1. Extract the Probability Tables from the struct
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% 2. Extract Entropy arrays and Step indices
base_step = baseline_probs.Step;
base_entropy = baseline_probs.Entropy;

gated_step = gated_probs.Step;
gated_entropy = gated_probs.Entropy;

% 3. Create the comparative line figure
fig2 = figure('Name', ['Entropy Comparison: ', baseID], 'Position', [150, 150, 1000, 600]);

% Plot both vectors on the same axes
plot(base_step, base_entropy, '-o', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'Baseline');
hold on;
plot(gated_step, gated_entropy, '-s', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'ISEF-Gated');
hold off;

% 4. Formatting and Labels
grid on;
xlabel('Generation Step (Output Token Index)');
ylabel('Shannon Entropy');
% Using Interpreter = 'none' to prevent subscript formatting issues
title(['LLaMA-3.3-70B Generation Entropy: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');
legend('Location', 'best');

% 5. --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.fig']);

exportgraphics(fig2, pngFileName, 'Resolution', 300);
savefig(fig2, figFileName);

disp(['Entropy figure saved successfully to: ', outputDir]);

% =========================================================================
% Autonomous Vehicles
% Phase 4b: Shannon Entropy Comparison (Baseline vs. ISEF-Gated)
% =========================================================================

% 1. Updated for the Autonomous Vehicles Domain
domain = 'Autonomous_Vehicles';
baseID = 'AV_SYN_001';
gatedID = 'AV_SYN_001_ISEF';

% 2. Extract the Probability Tables from the struct
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% 3. Extract Entropy arrays and Step indices
base_step = baseline_probs.Step;
base_entropy = baseline_probs.Entropy;

gated_step = gated_probs.Step;
gated_entropy = gated_probs.Entropy;

% 4. Create the comparative line figure
fig2 = figure('Name', ['Entropy Comparison: ', baseID], 'Position', [150, 150, 1000, 600]);

% Plot both vectors on the same axes
plot(base_step, base_entropy, '-o', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'Baseline');
hold on;
plot(gated_step, gated_entropy, '-s', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'ISEF-Gated');
hold off;

% 5. Formatting and Labels
grid on;
xlabel('Generation Step (Output Token Index)');
ylabel('Shannon Entropy');
% Using Interpreter = 'none' to prevent subscript formatting issues
title(['LLaMA-3.3-70B Generation Entropy: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');
legend('Location', 'best');

% 6. --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.fig']);

exportgraphics(fig2, pngFileName, 'Resolution', 300);
savefig(fig2, figFileName);

disp(['Entropy figure saved successfully to: ', outputDir]);

% =========================================================================
% Agentic Workflows
% Phase 4c: Shannon Entropy Comparison (Baseline vs. ISEF-Gated)
% =========================================================================

% Target updated for Agentic Workflows
domain = 'Agentic_Workflows';
baseID = 'AGT_SYN_001';
gatedID = 'AGT_SYN_001_ISEF';

% Extract the Probability Tables
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% Extract Entropy arrays and Step indices
base_step = baseline_probs.Step;
base_entropy = baseline_probs.Entropy;

gated_step = gated_probs.Step;
gated_entropy = gated_probs.Entropy;

% Create the comparative line figure
fig2 = figure('Name', ['Entropy Comparison: ', baseID], 'Position', [150, 150, 1000, 600]);

% Plot both vectors on the same axes
plot(base_step, base_entropy, '-o', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'Baseline');
hold on;
plot(gated_step, gated_entropy, '-s', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', 'ISEF-Gated');
hold off;

% Formatting and Labels
grid on;
xlabel('Generation Step (Output Token Index)');
ylabel('Shannon Entropy');
title(['LLaMA-3.3-70B Generation Entropy: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');
legend('Location', 'best');

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Entropy_Comparison.fig']);

exportgraphics(fig2, pngFileName, 'Resolution', 300);
savefig(fig2, figFileName);

disp(['Entropy figure saved successfully to: ', outputDir]);