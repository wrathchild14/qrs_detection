function [] = detection(recordName, frequency)
    try
        eeg_data = load(['data/' recordName 'm.mat']);
        % eeg_data = load([recordName 'm.mat']);
        eeg = eeg_data.val(1, :);

        M = 7;
        lphf_output = lhpf(eeg, M);
        nlpf_output = nlpf(lphf_output, frequency);

        qrs_peaks = dec(nlpf_output, frequency);

        fileID = fopen(['asc_data/' recordName '.asc'], 'w');
        for i = 1:numel(qrs_peaks)
            fprintf(fileID, '0:00:00.00 %d N 0 0 0\n', qrs_peaks(i));
        end
        fclose(fileID);
        clear eeg_data eeg lphf_output nlpf_output qrs_peaks;
    catch ME
        disp(['Error: ' ME.message]);
    end
end
