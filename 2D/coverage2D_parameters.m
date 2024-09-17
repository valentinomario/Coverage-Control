% never clear here!

n = 20;
x0 = rand(n,1);
y0 = rand(n,1);

bs_ext = [0 1 1 0; 0 0 1 1]'; 

p0 = [x0, y0];


amin = 0.1;
a = [100 amin*ones(1,7) 100]';
a_hat0 = amin * ones(9,n);
li0 = zeros(9,n);
Li0 = zeros(9,9,n);
Li0 = Li0(:); % Reshape for integrator block
%Fi = zeros(9,9,n);

%K = 3*eye(2); % Control gain matrix
K = [3 3; -3 3];
Gamma = eye(9); 
g = 100; % Learning rate
psi = 0; % Consensus weight

step_size = 0.01;
Tf = 50;

