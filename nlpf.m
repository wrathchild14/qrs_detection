function y = nlpf(x, freq)
    window_size = round((freq / 1000) * 150);
    x_squared = x .^ 2;
    y = zeros(size(x));
    for n = 1:numel(x)
        start_index = max(1, n - window_size + 1);
        end_index = n;
        y(n) = sum(x_squared(start_index:end_index));
    end
end