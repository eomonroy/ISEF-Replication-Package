% =========================================================================
% Phase 6: Statistical Significance (With Complete Export)
% =========================================================================

% Define the path to the previously saved aggregate data
outputDir = 'Chapter4_Graphics';
csvFileName = fullfile(outputDir, 'Aggregate_Entropy_Results.csv');

% Load the data
if exist(csvFileName, 'file')
    AggregateResults = readtable(csvFileName);
else
    error('Data file not found. Please ensure the CSV is in the Chapter4_Graphics folder.');
end

% Extract the paired vectors
base_entropy = AggregateResults.Mean_Baseline;
gated_entropy = AggregateResults.Mean_ISEF;

% Perform a two-tailed Paired Sample T-Test
[h, p, ci, stats] = ttest(gated_entropy, base_entropy);

% Construct the complete output string
outText = sprintf('=============================================================================\n');
outText = [outText, sprintf('                     PAIRED T-TEST RESULTS (ISEF vs BASELINE)                \n')];
outText = [outText, sprintf('=============================================================================\n')];
outText = [outText, sprintf('Degrees of Freedom (df): %d\n', stats.df)];
outText = [outText, sprintf('T-Statistic (t):         %.4f\n', stats.tstat)];
outText = [outText, sprintf('P-Value (p):             %.6f\n', p)];
outText = [outText, sprintf('95%% Confidence Interval: [%.4f, %.4f]\n', ci(1), ci(2))];
outText = [outText, sprintf('-----------------------------------------------------------------------------\n')];

% Append the narrative conclusion based on the p-value
if p < 0.05
    outText = [outText, sprintf('CONCLUSION: STATISTICALLY SIGNIFICANT SHIFT\n')];
    outText = [outText, sprintf('The p-value is less than 0.05. We reject the null hypothesis.\n')];
    outText = [outText, sprintf('There is a statistically significant difference in mean Shannon entropy\n')];
    outText = [outText, sprintf('when the model is subjected to ISEF deterministic control gates.\n')];
else
    outText = [outText, sprintf('CONCLUSION: NO STATISTICALLY SIGNIFICANT SHIFT\n')];
    outText = [outText, sprintf('The p-value is greater than or equal to 0.05. We fail to reject the null hypothesis.\n')];
end

% Display to the Command Window
fprintf(1, '%s', outText);

% --- Auto-Save Section ---
outputTxt = fullfile(outputDir, 'T_Test_Results.txt');
fid = fopen(outputTxt, 'w');
fprintf(fid, '%s', outText);
fclose(fid);

disp(['Statistical summary successfully saved to: ', outputTxt]);

disp(['Statistical summary successfully saved to: ', outputTxt]);