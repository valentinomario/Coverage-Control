function prev_index = previous_i(i, n)
% This function returns the previous index of a circular sequence of size n
    if i==1
        prev_index = n;
    else
        prev_index = i-1;
    end
end
