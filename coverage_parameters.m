% coverage control without order preservation
clear %!
close all
order_preservation = false;
update_step = 1;
n = 10; % sensors number
lambda = [2.4, 2.8, 3.0, 4.2, 3.6]; % max sensor velocity
lambda = rand(1,n)*5 + ones(1,n)*0.5;

delta = deg2rad([1.2, 4.0, 1.6, 3.0, 1.8]); % measurement error upper bound
delta = deg2rad(rand(1,n)*pi/10)*0;

delta_bar = zeros(n,n);

    for i=1:n
        j = previous_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
        
        j = next_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
    end

eta = [0.005, 0.006, 0.002, 0.004, 0.003]; % control gains
eta = 0.0005.*ones(1,n);

omega = [1.5, 12, 8, 0.5, 21]; % error frequency
phi = [pi/6, pi/3, pi/2, pi/4, pi/5]; % error phase

omega = rand(1,n)*10;
phi = rand(1,n)*pi;

q0 = sort(rand(1, n) * 0.2 * pi)'; % random position init

Tf = 1000;
T_star = pi/sum(lambda(1:n));
fprintf('Parameters updated %s\n', (datetime))

% provare a fare il pinning control per far ruotare gli agenti in
% formazione. >Vedere se è possibile inglobale  la legge di controllo del
% pinning control nello stimatore per mantenersi il più vicini possibili
% all'ottimo anche in questo caso.