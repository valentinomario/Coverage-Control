% coverage control without order preservation
clear %!
close all
n = 5; % sensors number
lambda = [2.4; 2.8; 3.0; 4.2; 3.6]; % max sensor velocity
%lambda = [0.1, 0.2, 0.3, 0.6, 0.8]';
lambda = 3*[1; 1; 1; 1; 1];
delta = [1.2, 4.0, 1.6, 3.0, 1.8]*0; % measurement error upper bound

delta_bar = zeros(n,n);

    for i=1:n
        j = previous_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
        
        j = next_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
    end

eta = [0.005, 0.006, 0.002, 0.004, 0.003]; % control gains
%eta = 0.002.*ones(1,n);
omega = [1.5, 12, 8, 0.5, 21]; % error frequency
phi = [pi/6, pi/3, pi/2, pi/4, pi/5]; % error phase

q0 = sort(rand(1, n) * 2 * pi)'; % random position init

Tf = 200;
T_star = pi/sum(lambda);
fprintf('Parameters updated %s\n', (datetime))

