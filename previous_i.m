function prev_index = previous_i(i, n)
    % previous_i restituisce l'indice dell'elemento precedente in maniera circolare
    % i: indice attuale
    % n: numero di elementi nell'array
    if i==1
        prev_index = n;
    else
        prev_index = i-1;
    end
end
