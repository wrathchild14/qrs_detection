function y = lhpf(x, M)
    b = ones(1, M) / M;
    a = [1 zeros(1, M - 1)];

    y = filter(b, a, x);
    y = x - y;
end