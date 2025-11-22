function [y] = whisper_effect(x, fs, f_size, overlap)
    wa = hann(f_size, 'periodic');
    ws = hamming(f_size, 'periodic');

    [S, ~, ~] = spectrogram(x, wa, overlap, f_size, fs);

    random_phase = exp(1j * 2 * pi * rand(size(S)));
    S_whisper = abs(S) .* random_phase;

    hop_size = f_size - overlap;
    n_frames = size(S_whisper, 2);
    x_len = (n_frames - 1) * hop_size + f_size;
    y = zeros(x_len, 1);
    win_sum = zeros(x_len, 1);

    for m = 1:n_frames
        start_idx = (m-1)*hop_size + 1;
        end_idx = start_idx + f_size - 1;
        if end_idx > length(y)
            break;
        end

        frame_rec = real(ifft(S_whisper(:,m), f_size));

        frame_rec = frame_rec .* ws;

        y(start_idx:end_idx) = y(start_idx:end_idx) + frame_rec;
        win_sum(start_idx:end_idx) = win_sum(start_idx:end_idx) + ws.^2;
    end
    y = y / max(abs(y)) * 0.99;
end