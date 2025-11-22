function [y] = whisper_effect(x, f_size, overlap)
    wa = blackman(f_size, 'periodic');
    ws = hann(f_size, 'periodic');

    hop_size = f_size - overlap;
    n_frames = floor((length(x) - f_size) / hop_size) + 1;
    
    y = zeros(length(x), 1);

    for i = 1:n_frames
        start_idx = (i-1) * hop_size + 1;
        end_idx = start_idx + f_size - 1;
        
        if end_idx > length(x)
            break;
        end
        
        frame = x(start_idx:end_idx) .* wa;
        fft_frame = fft(frame, f_size);
        
        mag = abs(fft_frame);
        random_phase = exp(1j * 2 * pi * rand(size(mag)));
        fft_modified = mag .* random_phase;
        
        modified_frame = real(ifft(fft_modified));
        modified_frame = modified_frame .* ws;
        
        y(start_idx:end_idx) = y(start_idx:end_idx) + modified_frame;
    end
    
    y = y / max(abs(y)) * 0.99;
end