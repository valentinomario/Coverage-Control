order_preservation = false;
update_step = 1;
n = 5;

lambda = rand(1,n)*4.5 + ones(1,n)*0.5;
delta = deg2rad(rand(1,n)*360/10);

delta_bar = zeros(n,n);

    for i=1:n
        j = previous_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
        
        j = next_i(i,n);
        delta_bar(i,j) = (delta(i) + delta(j))/2;
    end

eta = 0.005.*ones(1,n);

omega = rand(1,n)*2;
phi = rand(1,n)*pi;

q0 = sort(rand(1, n) * 2 * pi)'; % random position init

Tf = 500;
T_star = pi/sum(lambda(1:n));
%fprintf('Parameters updated %s\n', (datetime))

pinning = true;
[~, pinned_node] = min(lambda);
qs_velocity = 0.01;
K = 0.1/lambda(pinned_node);
