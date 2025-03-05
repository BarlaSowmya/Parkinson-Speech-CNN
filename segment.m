% Define the input and output directories
inputDir = "C:\Users\sowmya\Downloads\sound\pd_test";  % Path to your .wav files
outputDir = "C:\Users\sowmya\Downloads\sound\MEL\PD_TEST";  % Path to save the Mel spectrogram plots

% Create output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Get all .wav files in the input directory and its subdirectories
audioFiles = dir(fullfile(inputDir, '**', '*.wav'));  % '**' allows for recursive searching

% Loop through each .wav file in the directory
for i = 1:length(audioFiles)
    % Get the full file path for the current audio file
    audioPath = fullfile(audioFiles(i).folder, audioFiles(i).name);  % Full path including subfolder
    
    % Read the audio file
    [y, fs] = audioread(audioPath);
    
    % Calculate Mel spectrogram
    windowLength = 1024;
    overlapLength = 512;
    nfft = 2048;
    
    % Mel spectrogram using the spectrogram function
    [S, F, T] = spectrogram(y, windowLength, overlapLength, nfft, fs, 'yaxis');
    
    % Convert the power spectrogram to decibel scale
    S_db = 10 * log10(abs(S).^2);
    
    % Generate the base name (without file extension)
    [~, baseName, ~] = fileparts(audioFiles(i).name);
    
    % Create a figure for the Mel spectrogram plot only
    figure('Visible', 'off');  % Create an invisible figure for plotting
    
    % Plot the Mel spectrogram
    imagesc(T, F, S_db);
    axis xy;
    colormap default;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    
    % Add only the file name as text on the plot, without formatting
    text(0.5, 1.05, baseName, 'Units', 'normalized', 'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');

    % Save the Mel spectrogram plot in the output directory
    outputFile = fullfile(outputDir, [baseName '_mel_spectrogram.png']);
    saveas(gcf, outputFile);
    
    % Close the figure to avoid overlap for the next file
    close(gcf);
end
