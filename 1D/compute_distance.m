function d = compute_distance(q1,q2,str)
% This function computes the angular distance between two sensors on a circle,
% counter clockwise for the "next" sensor, and clockwise for the "previous"
% sensor
    q1=mod(q1,2*pi);
    q2=mod(q2,2*pi);

    d_bar = (mod(q2 - q1, 2*pi));

    if str=="next"
       d = d_bar;
    elseif str=="previous"
       d = -(2*pi - d_bar);
    end

end

