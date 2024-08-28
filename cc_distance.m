%function d = circular_distance(q1, q2)
%    d_bar = mod(q2 - q1, 2*pi);
%    if d_bar > pi
%        d = d_bar - 2*pi;
%    else
%        d = d_bar;
%    end
%end

function d = cc_distance(q1, q2)
    d = mod(q2 - q1, 2*pi);
    %d = min([d_bar; 2*pi-d_bar]);
end 