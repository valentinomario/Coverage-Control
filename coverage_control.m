% coverage control without order preservation
n = 5; % sensors number
lambda = [2.4, 2.8, 3.0, 4.2, 3.6]; % max sensor velocity
delta = [1.2, 4.0, 1.6, 3.0, 1.8]; % measurement error upper bound
eta = [0.005, 0.006, 0.002, 0.004, 0.003]; % control gains

omega = [1.5, 12, 8, 0.5, 21]; % error frequency
phi = [pi/6, pi/3, pi/2, pi/4, pi/5]; % error phase

q = zeros(n, 100);
q(:, 1) = sort(rand(1, n) * 2 * pi); % random position init

max_steps = 100;

% pre-allocation
u = zeros(n, max_steps-1);

d_low_next = zeros(n,max_steps);
d_high_next = zeros(n,max_steps); % TODO: different initial condition!
d_low_previous = zeros(n,max_steps);
d_high_previous = zeros(n,max_steps);

d_tilde_next = zeros(n,max_steps);
d_tilde_previous = zeros(n,max_steps);

e = zeros(n,2,max_steps-1);
d = zeros(n,2,max_steps-1); % (i,j,k): j=1 previous, j=2 next
for k=1:max_steps-1

    % compute all measuremets 
    for i=1:n
        % previous
        e(i,1,k) = 1+3*sin(omega(i)*k + 10*(previous_i(i,n)-i)*phi(i))*delta(i)/4;
        d(i,1,k) = q(previous_i(i,n),k) - q(i,k) + e(i,1,k);

        % next
        e(i,2,k) = 1+3*sin(omega(i)*k + 10*(next_i(i,n)-i)*phi(i))*delta(i)/4;
        d(i,2,k) = q(next_i(i,n),k) - q(i,k) + e(i,2,k);
        
    end


    % control law
    for i=1:n

        d_tilde_next(i,k) = (d_low_next(i,k) + d_high_next(i,k))/2;
        d_tilde_previous(i,k) = (d_low_previous(i,k) + d_high_previous(i,k))/2;

        u_tilde_ik = eta(i)*( ...
            (lambda(previous_i(i,n)) + lambda(i))*d_tilde_next(i,k) + ...
            (lambda(i) + lambda(next_i(i,n)))*d_tilde_previous(i,k)...
            );
        u(i,k) = lambda(i)*sign(u_tilde_ik)*min([1,abs(u_tilde_ik)]);
        
        delta_bar_next = (delta(i) + delta(next_i(i,n)))/2;
        delta_bar_previous = (delta(i) + delta(previous_i(i,n)))/2;

        % update distance estimation
       
        % qui viene usato d_bar(k+1) che dipende da d(k+1), che a sua 
        % volta dipende da q(k+1) come facci o ad aggiornare d_bar?

        d_low_next(i,k+1) = max([d_bar_next(k+1)-delta_bar_next; ...
                                 d_low_next(k) + u(next_i(i,n),k) - u(i,k)]);
        d_high_next(i,k+1) = min([d_bar_next(k+1)-delta_bar_next; ...
                                 d_high_next(k) + u(next_i(i,n),k) - u(i,k)]);
        d_low_previous(i,k+1) = max([d_bar_previous(k+1)-delta_bar_previous; ...
                                 d_low_previous(k) + u(previous_i(i,n),k) - u(i,k)]);
        d_high_previous(i,k+1) = min([d_bar_previous(k+1)-delta_bar_previous; ...
                                 d_high_previous(k) + u(previous_i(i,n),k) - u(i,k)]);
        
        % update agent
        % q(k+1) = q(k) + u(k) !
    end
end