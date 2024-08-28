function next_index = next_i(i, n)
    % next_i restituisce l'indice dell'elemento successivo in maniera circolare
    % i: indice attuale
    % n: numero di elementi nell'array
    if i==n
        next_index = 1;
    else
        next_index = i+1;
    end
end
