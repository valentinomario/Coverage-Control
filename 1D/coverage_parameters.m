clear %!
close all
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
fprintf('Parameters updated %s\n', (datetime))

pinning = true;
[~, pinned_node] = min(lambda);
qs_velocity = 0.01;
K = 0.1/lambda(pinned_node);


%% 

if pinning
    out = sim('cov_control.slx');
else
    out = sim('cov_control_no_pinning.slx');
end

if ~exist("./img/pinning_"+string(pinning), 'dir')
        mkdir("./img/pinning_"+string(pinning));
end

figure
plot(out.T_diff.Time, out.T_diff.Data,'k');
xlabel('step')
ylabel('T - T*')
saveas(gcf, "./img/pinning_"+string(pinning)+"/Tdiff",'epsc');

figure
plot(out.Ti.Time, squeeze(out.Ti.Data));
xlabel('step')
ylabel('T_i')
saveas(gcf, "./img/pinning_"+string(pinning)+"/Ti",'epsc');


figure
plot(out.u.Time, squeeze(out.u.Data));
xlabel('step')
ylabel('u_i')
saveas(gcf, "./img/pinning_"+string(pinning)+"/ui",'epsc');


figure
plot(out.est_err.Time, out.est_err.Data);
xlabel('step')
ylabel('estimation error norm')
saveas(gcf, "./img/pinning_"+string(pinning)+"/est_err",'epsc');

figure
plot(out.Ti.Time, squeeze(out.q.Data));
xlabel('step')
ylabel('q_i')
if pinning
    hold;
    plot(out.qs.Time, out.qs.Data,'--')
end
saveas(gcf, "./img/pinning_"+string(pinning)+"/qi",'epsc');

plotPointsOnUnitCircle(out.q.Data(:,1,1));
saveas(gcf, "./img/pinning_"+string(pinning)+"/q0",'epsc');
plotPointsOnUnitCircle(out.q.Data(:,1,end));
saveas(gcf, "./img/pinning_"+string(pinning)+"/qend",'epsc');

