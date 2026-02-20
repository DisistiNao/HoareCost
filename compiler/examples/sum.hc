{ ((N >= 0 and I == 1) and T == 0) }
    while "sumLoop" (I <= N) do
        if (I <= N) then
            T = T + I;
            I = I + 1
        end
        else
            skip
        end
    end
{ T <= N * N | 20 * N + 15}