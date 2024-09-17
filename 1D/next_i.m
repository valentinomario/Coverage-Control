function next_index = next_i(i, n)
% This function returns the next index of a circular sequence of size n

    if i==n
        next_index = 1;
    else
        next_index = i+1;
    end
end
