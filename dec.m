function peaks = dec(x, freq)
    alpha = 0.1;
    gamma = 0.2;
    peaks = [];

    n = 1;
    N = floor((freq / 1000) * 250);
    threshold = max(x(1:N));

    while (n + N < numel(x))
        PEAK = max(x(n:n + N));
        possible_threshold = alpha * gamma * PEAK + (1 - alpha) * threshold;
        
        if PEAK > possible_threshold
            [~, idx] = max(x(n:n + N));
            k = n + idx - 1;
            n = k + 1;
            
            while (x(n) > possible_threshold && n < numel(x))
                n = n + 1;
            end
            
            PEAK = max(x(k:n));
            threshold = alpha * gamma * PEAK + (1 - alpha) * threshold;
            peaks(end + 1) = k;
        end
        n = n + 1;
    end
end