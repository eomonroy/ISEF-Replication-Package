% =========================================================================
% Phase 2 HW17: Statistical Deep Dive & Variance Proving (Latency PDFs)
% =========================================================================

% 1. Load the temporal telemetry directly from the Modeler spreadsheet
fileName = 'ISEF_Telemetry_Modeler_v4.xlsx';
sheetName = 'LatencyVariance';

% Read the table (Suppressing warning about modified column names)
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');
latencyData = readtable(fileName, 'Sheet', sheetName);

% Extract latency columns (Column 2 = Baseline, Column 3 = ISEF Gated)
% Using column indices guarantees structural integrity despite spaces in headers
baseline_ms = latencyData{:, 2};
isef_ms = latencyData{:, 3};

% 2. Fit the Probability Distributions
% We use Kernel density estimation to accurately capture heavy-tailed dispersion
pd_base = fitdist(baseline_ms, 'Kernel');
pd_isef = fitdist(isef_ms, 'Kernel');

% 3. Create the High-Fidelity PDF Visualization
fig_pdf = figure('Name', 'Structural Overhead: Latency PDF', 'Position', [150, 150, 1000, 600]);

% Generate dynamic X-axis limits based on the data extremes
x_min = min(baseline_ms) * 0.8;
x_max = max(isef_ms) * 1.1;
x_vals = linspace(x_min, x_max, 1000);

% Calculate density values
pdf_base = pdf(pd_base, x_vals);
pdf_isef = pdf(pd_isef, x_vals);

% Plot the curves
plot(x_vals, pdf_base, 'LineWidth', 2.5, 'Color', [0 0.4470 0.7410], 'DisplayName', 'Unshielded Baseline (Tight Cluster)');
hold on;
plot(x_vals, pdf_isef, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'ISEF-Gated Architecture (Dispersed / Heavy-Tailed)');

% Fill areas under the curve for high-contrast Praxis aesthetics
fill([x_vals fliplr(x_vals)], [pdf_base zeros(size(pdf_base))], [0 0.4470 0.7410], 'FaceAlpha', 0.2, 'EdgeColor', 'none', 'HandleVisibility', 'off');
fill([x_vals fliplr(x_vals)], [pdf_isef zeros(size(pdf_isef))], [0.8500 0.3250 0.0980], 'FaceAlpha', 0.2, 'EdgeColor', 'none', 'HandleVisibility', 'off');
hold off;

% 4. Formatting and Analytical Labels
grid on;
xlabel('Execution Latency (ms)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Probability Density', 'FontSize', 12, 'FontWeight', 'bold');
title('Structural Overhead Distribution: Baseline vs. ISEF-Gated', 'FontSize', 14, 'Interpreter', 'none');
legend('Location', 'NorthEast', 'FontSize', 11);

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, 'Latency_PDF_Distribution.png');
figFileName = fullfile(outputDir, 'Latency_PDF_Distribution.fig');

exportgraphics(fig_pdf, pngFileName, 'Resolution', 300);
savefig(fig_pdf, figFileName);

disp('Phase 2 Latency Distribution graphic saved successfully.');