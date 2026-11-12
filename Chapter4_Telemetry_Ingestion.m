% =========================================================================
% Phase 1: Telemetry Archive Extraction & Directory Mapping
% =========================================================================

% Define target archive and local extraction folder
archiveFile = 'telemetry_tensors_24runs.tar.gz';
dataFolder = 'telemetry_tensors_raw';

% Check if extraction is already complete to avoid redundant processing
if ~exist(dataFolder, 'dir')
    disp('Extracting telemetry archive...');
    untar(archiveFile, dataFolder);
    disp('Extraction complete.');
else
    disp('Directory already exists. Skipping extraction.');
end

% Map the subdirectories (Domains and Phases)
domains = {'Medical', 'Autonomous_Vehicles', 'Agentic_Workflows'};
phases = {'Baseline', 'ISEF_Gated'};

disp('Environment configured. Ready to load matrices and probability tables.');

% =========================================================================
% Phase 2: Load Telemetry Data into MATLAB Structures (Path Corrected)
% =========================================================================
telemetryData = struct();

for d = 1:length(domains)
    domain = domains{d};
    for p = 1:length(phases)
        phase = phases{p};
        
        % CORRECTED PATH: Pointing directly to the extracted domain folders
        folderPath = fullfile(dataFolder, domain, phase);
        
        % Check if directory exists before processing
        if exist(folderPath, 'dir')
            csvFiles = dir(fullfile(folderPath, '*.csv'));
            
            for f = 1:length(csvFiles)
                fileName = csvFiles(f).name;
                filePath = fullfile(folderPath, fileName);
                
                % Extract the Run ID (e.g., MED-SYN-001) and format for MATLAB struct fields
                if contains(fileName, 'Attention_Matrix')
                    rawID = strrep(fileName, '_Attention_Matrix.csv', '');
                    cleanID = strrep(rawID, '-', '_'); % Struct fields cannot contain hyphens
                    
                    % Read matrix
                    telemetryData.(domain).(phase).(cleanID).Attention = readmatrix(filePath);
                    
                elseif contains(fileName, 'Probabilities')
                    rawID = strrep(fileName, '_Probabilities.csv', '');
                    cleanID = strrep(rawID, '-', '_');
                    
                    % Read probabilities as a table
                    telemetryData.(domain).(phase).(cleanID).Probabilities = readtable(filePath);
                end
            end
        else
            fprintf('Warning: Directory not found - %s\n', folderPath);
        end
    end
end

disp('Data successfully loaded into the telemetryData struct.');

% % =========================================================================
% % Phase 3: Visual Validation (Baseline vs. ISEF-Gated) - Medical
% % =========================================================================
% 
% % 1. Define the specific scenario to analyze
% domain = 'Medical';
% baseID = 'MED_SYN_001';
% gatedID = 'MED_SYN_001_ISEF';
% 
% % 2. Extract the Attention Matrices from the struct
% baseline_matrix = telemetryData.(domain).Baseline.(baseID).Attention;
% gated_matrix = telemetryData.(domain).ISEF_Gated.(gatedID).Attention;
% 
% % 3. Create a side-by-side comparative figure
% figure('Name', ['Attention Matrix Comparison: ', baseID], 'Position', [100, 100, 1200, 500]);
% 
% % Plot Baseline Attention
% subplot(1, 2, 1);
% imagesc(baseline_matrix);
% colorbar;
% colormap('parula');
% title(['Baseline Attention: ', baseID]);
% xlabel('Token Position (Target)');
% ylabel('Token Position (Source)');
% axis tight;
% 
% % Plot ISEF-Gated Attention
% subplot(1, 2, 2);
% imagesc(gated_matrix);
% colorbar;
% colormap('parula');
% title(['ISEF-Gated Attention: ', gatedID]);
% xlabel('Token Position (Target)');
% ylabel('Token Position (Source)');
% axis tight;
% 
% sgtitle('LLaMA-3.3-70B Final Layer Mean Attention Map Comparison');

% =========================================================================
% Medical
% Phase 3b: Visual Validation (Synchronized, Fixed Titles, & Auto-Save)
% i. set interpreter to none for titles & 
% ii. create a folder to save output figures and raw .fig files 
% =========================================================================

domain = 'Medical';
baseID = 'MED_SYN_001';
gatedID = 'MED_SYN_001_ISEF';

baseline_matrix = telemetryData.(domain).Baseline.(baseID).Attention;
gated_matrix = telemetryData.(domain).ISEF_Gated.(gatedID).Attention;

% Calculate global limits for strict 1:1 comparison
max_tokens = max(size(baseline_matrix, 1), size(gated_matrix, 1));
global_min = min(min(baseline_matrix(:)), min(gated_matrix(:)));
global_max = max(max(baseline_matrix(:)), max(gated_matrix(:)));

% Create the figure handle (so we can save it specifically)
fig = figure('Name', ['Synchronized Attention Comparison: ', baseID], 'Position', [100, 100, 1200, 500]);

% Plot Baseline Attention
subplot(1, 2, 1);
imagesc(baseline_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
% Disable TeX interpreter to prevent underscores from creating subscripts
title(['Baseline Attention: ', baseID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Plot ISEF-Gated Attention
subplot(1, 2, 2);
imagesc(gated_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
% Disable TeX interpreter here as well
title(['ISEF-Gated Attention: ', gatedID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Fix the main figure title
sgtitle(['LLaMA-3.3-70B Final Layer Mean Attention: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');

% --- Auto-Save Section ---
% Create a dedicated folder for Chapter 4 graphics if it doesn't exist
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Define file names
pngFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.fig']);

% Save as a high-resolution PNG (300 DPI) for your document and a .fig for MATLAB edits
exportgraphics(fig, pngFileName, 'Resolution', 300);
savefig(fig, figFileName);

disp(['Figure saved successfully to: ', outputDir]);

% =========================================================================
% Autonomous Vehicles
% Phase 3c: Visual Validation (Synchronized, Fixed Titles, & Auto-Save)
% =========================================================================

% 1. Updated for the Autonomous Vehicles Domain
domain = 'Autonomous_Vehicles';
baseID = 'AV_SYN_001';
gatedID = 'AV_SYN_001_ISEF';

baseline_matrix = telemetryData.(domain).Baseline.(baseID).Attention;
gated_matrix = telemetryData.(domain).ISEF_Gated.(gatedID).Attention;

% Calculate global limits for strict 1:1 comparison
max_tokens = max(size(baseline_matrix, 1), size(gated_matrix, 1));
global_min = min(min(baseline_matrix(:)), min(gated_matrix(:)));
global_max = max(max(baseline_matrix(:)), max(gated_matrix(:)));

% Create the figure handle
fig = figure('Name', ['Synchronized Attention Comparison: ', baseID], 'Position', [100, 100, 1200, 500]);

% Plot Baseline Attention
subplot(1, 2, 1);
imagesc(baseline_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
title(['Baseline Attention: ', baseID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Plot ISEF-Gated Attention
subplot(1, 2, 2);
imagesc(gated_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
title(['ISEF-Gated Attention: ', gatedID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Fix the main figure title
sgtitle(['LLaMA-3.3-70B Final Layer Mean Attention: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.fig']);

exportgraphics(fig, pngFileName, 'Resolution', 300);
savefig(fig, figFileName);

disp(['Figure saved successfully to: ', outputDir]);

% =========================================================================
% Agentic Workflows
% Phase 3d: Visual Validation (Synchronized, Fixed Titles, & Auto-Save)
% =========================================================================

% Target updated for Agentic Workflows
domain = 'Agentic_Workflows';
baseID = 'AGT_SYN_001';
gatedID = 'AGT_SYN_001_ISEF';

baseline_matrix = telemetryData.(domain).Baseline.(baseID).Attention;
gated_matrix = telemetryData.(domain).ISEF_Gated.(gatedID).Attention;

% Calculate global limits for strict 1:1 comparison
max_tokens = max(size(baseline_matrix, 1), size(gated_matrix, 1));
global_min = min(min(baseline_matrix(:)), min(gated_matrix(:)));
global_max = max(max(baseline_matrix(:)), max(gated_matrix(:)));

% Create the figure handle
fig = figure('Name', ['Synchronized Attention Comparison: ', baseID], 'Position', [100, 100, 1200, 500]);

% Plot Baseline Attention
subplot(1, 2, 1);
imagesc(baseline_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
title(['Baseline Attention: ', baseID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Plot ISEF-Gated Attention
subplot(1, 2, 2);
imagesc(gated_matrix);
clim([global_min, global_max]); 
ylim([1, max_tokens]);          
colorbar;
colormap('parula');
title(['ISEF-Gated Attention: ', gatedID], 'Interpreter', 'none');
xlabel('Token Position (Target)');
ylabel('Token Position (Source)');

% Fix the main figure title
sgtitle(['LLaMA-3.3-70B Final Layer Mean Attention: ', baseID, ' vs ', gatedID], 'Interpreter', 'none');

% --- Auto-Save Section ---
outputDir = 'Chapter4_Graphics';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

pngFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.png']);
figFileName = fullfile(outputDir, [baseID, '_Attention_Comparison.fig']);

exportgraphics(fig, pngFileName, 'Resolution', 300);
savefig(fig, figFileName);

disp(['Figure saved successfully to: ', outputDir]);