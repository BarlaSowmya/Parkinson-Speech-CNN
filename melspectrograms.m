% Define input and output directories
input_dir ="C:\Users\sowmya\Downloads\converted_dataset\PD_TEST_WAV";  % Directory containing .wav files and subfolders
output_dir ="C:\Users\sowmya\Downloads\sound\pd_test" ; % Directory where segmented audio will be saved


% Get all .wav files in the input directory and its subdirectories
file_list = dir(fullfile(input_dir, '**', '*.wav'));

% Create the output directory if it doesn't exist
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Loop through all files
for file_idx = 1:length(file_list)
    % Read the audio file
    audio_file = fullfile(file_list(file_idx).folder, file_list(file_idx).name);
    [audio, fs] = audioread(audio_file); % fs is now initialized here

    % Parameters
    win_length = round(0.025 * fs); % 25ms window for short-term analysis
    hop_length = round(0.01 * fs);  % 10ms hop length
    seg_window = round(0.4 * fs);   % 400ms segment window
    half_seg_window = seg_window / 2;

    % Pre-emphasize the signal
    audio = filter([1 -0.97], 1, audio);

    % Compute LP residual
    order = 12; % Order of LP analysis
    lp_residual = zeros(size(audio));
    for i = 1:hop_length:length(audio) - win_length
        segment = audio(i:i+win_length-1);
        a = lpc(segment, order);
        residual_segment = filter(a, 1, segment);
        lp_residual(i:i+win_length-1) = residual_segment;
    end

    % Hilbert transform and envelope calculation
    hilbert_env = abs(hilbert(lp_residual));

    % Normalize the envelope
    norm_env = hilbert_env / max(hilbert_env);

    % Differencing window
    diff_env = diff(norm_env);

    % Threshold for VOP detection
    vop_threshold = 0.3; % Set a threshold value based on experiment
    vop_locs = find(diff_env > vop_threshold);

    % Segment audio around detected VOPs
    segments = {};
    for j = 1:length(vop_locs)
        vop_index = vop_locs(j);
        start_idx = max(vop_index - half_seg_window, 1);
        end_idx = min(vop_index + half_seg_window, length(audio));
        segments{end + 1} = audio(start_idx:end_idx);
    end

    % Save segmented audio in the output directory
    for k = 1:length(segments)
        % Create a unique filename based on the original file name and segment number
        [~, base_name, ~] = fileparts(file_list(file_idx).name);
        filename = fullfile(output_dir, sprintf('%s_segment_%d.wav', base_name, k));
        audiowrite(filename, segments{k}, fs);
    end
end

disp('Segmentation completed for all files.');
