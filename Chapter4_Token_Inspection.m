% =========================================================================
% Medical
% Phase 4a: High-Entropy Token Inspection (With CSV Export)
% =========================================================================

domain = 'Medical';
baseID = 'MED_SYN_001';
gatedID = 'MED_SYN_001_ISEF';

% Extract the Probability Tables
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% Sort Baseline by Entropy descending and grab top 5
sortedBase = sortrows(baseline_probs, 'Entropy', 'descend');
top5Base = sortedBase(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', baseID, ' (Baseline)']);
disp('====================================================');
disp(top5Base);

% Sort ISEF-Gated by Entropy descending and grab top 5
sortedGated = sortrows(gated_probs, 'Entropy', 'descend');
top5Gated = sortedGated(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', gatedID, ' (ISEF-Gated)']);
disp('====================================================');
disp(top5Gated);

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Create a 'Phase' label column for distinction in the combined CSV
PhaseBase = repmat({'Baseline'}, 5, 1);
PhaseGated = repmat({'ISEF-Gated'}, 5, 1);

% Append the Phase column to the tables
top5Base.Phase = PhaseBase;
top5Gated.Phase = PhaseGated;

% Reorder columns so Phase is first for better readability in Excel
top5Base = movevars(top5Base, 'Phase', 'Before', 'Step');
top5Gated = movevars(top5Gated, 'Phase', 'Before', 'Step');

% Combine the two tables vertically
combinedTop5 = [top5Base; top5Gated];

% Save the combined data to CSV
csvFileName = fullfile(outputDir, [baseID, '_Top5_HighEntropy_Tokens.csv']);
writetable(combinedTop5, csvFileName);

disp(['Top 5 tokens table successfully saved to: ', csvFileName]);

% =========================================================================
% Autonomous Vehicles
% Phase 4b: High-Entropy Token Inspection (With CSV Export)
% =========================================================================

% Target updated for Autonomous Vehicles
domain = 'Autonomous_Vehicles';
baseID = 'AV_SYN_001';
gatedID = 'AV_SYN_001_ISEF';

% Extract the Probability Tables
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% Sort Baseline by Entropy descending and grab top 5
sortedBase = sortrows(baseline_probs, 'Entropy', 'descend');
top5Base = sortedBase(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', baseID, ' (Baseline)']);
disp('====================================================');
disp(top5Base);

% Sort ISEF-Gated by Entropy descending and grab top 5
sortedGated = sortrows(gated_probs, 'Entropy', 'descend');
top5Gated = sortedGated(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', gatedID, ' (ISEF-Gated)']);
disp('====================================================');
disp(top5Gated);

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Create a 'Phase' label column for distinction in the combined CSV
PhaseBase = repmat({'Baseline'}, 5, 1);
PhaseGated = repmat({'ISEF-Gated'}, 5, 1);

% Append the Phase column to the tables
top5Base.Phase = PhaseBase;
top5Gated.Phase = PhaseGated;

% Reorder columns so Phase is first for better readability in Excel
top5Base = movevars(top5Base, 'Phase', 'Before', 'Step');
top5Gated = movevars(top5Gated, 'Phase', 'Before', 'Step');

% Combine the two tables vertically
combinedTop5 = [top5Base; top5Gated];

% Save the combined data to CSV
csvFileName = fullfile(outputDir, [baseID, '_Top5_HighEntropy_Tokens.csv']);
writetable(combinedTop5, csvFileName);

disp(['Top 5 tokens table successfully saved to: ', csvFileName]);

% =========================================================================
% Agentic Workflows
% Phase 4c: High-Entropy Token Inspection (With CSV Export)
% =========================================================================

% Target updated for Agentic Workflows
domain = 'Agentic_Workflows';
baseID = 'AGT_SYN_001';
gatedID = 'AGT_SYN_001_ISEF';

% Extract the Probability Tables
baseline_probs = telemetryData.(domain).Baseline.(baseID).Probabilities;
gated_probs = telemetryData.(domain).ISEF_Gated.(gatedID).Probabilities;

% Sort Baseline by Entropy descending and grab top 5
sortedBase = sortrows(baseline_probs, 'Entropy', 'descend');
top5Base = sortedBase(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', baseID, ' (Baseline)']);
disp('====================================================');
disp(top5Base);

% Sort ISEF-Gated by Entropy descending and grab top 5
sortedGated = sortrows(gated_probs, 'Entropy', 'descend');
top5Gated = sortedGated(1:5, {'Step', 'Top_Token', 'Top_Prob', 'Entropy'});

disp('====================================================');
disp(['Top 5 Highest Entropy Tokens: ', gatedID, ' (ISEF-Gated)']);
disp('====================================================');
disp(top5Gated);

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Create a 'Phase' label column
PhaseBase = repmat({'Baseline'}, 5, 1);
PhaseGated = repmat({'ISEF-Gated'}, 5, 1);

% Append the Phase column
top5Base.Phase = PhaseBase;
top5Gated.Phase = PhaseGated;

% Reorder columns
top5Base = movevars(top5Base, 'Phase', 'Before', 'Step');
top5Gated = movevars(top5Gated, 'Phase', 'Before', 'Step');

% Combine and Save
combinedTop5 = [top5Base; top5Gated];
csvFileName = fullfile(outputDir, [baseID, '_Top5_HighEntropy_Tokens.csv']);
writetable(combinedTop5, csvFileName);

disp(['Top 5 tokens table successfully saved to: ', csvFileName]);