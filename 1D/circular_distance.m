function d = circular_distance(q1,q2)
% This function calculates the shortest distance between two angles in 
% radians on a circle

    q1=mod(q1,2*pi);
    q2=mod(q2,2*pi);

    d_bar = (mod(q2 - q1, 2*pi));
    d = min([d_bar; 2*pi-d_bar]);
end




