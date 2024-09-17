clear
close all

coverage2D_parameters

out = sim("coverage2D.slx");

%% report plots

if ~exist("./img/out", 'dir')
        mkdir("./img/out");
end


mu = [1 1 1 3 3 3 5 5 5; 1 3 5 1 3 5 1 3 5]/6;
figure
voronoi(x0,y0,'k.')
hold on;
plot(mu(1,1),mu(2,1),'r*')
plot(mu(1,9),mu(2,9),'r*')
xlabel('x');
ylabel('y');
xlim([0,1]);
ylim([0,1]);
saveas(gcf, "./img/out/initial",'epsc');


figure
voronoi(out.p.Data(:,1,end),out.p.Data(:,2,end),'k.')
hold on;
plot(mu(1,1),mu(2,1),'r*')
plot(mu(1,9),mu(2,9),'r*')
xlabel('x');
ylabel('y');
xlim([0,1]);
ylim([0,1]);
saveas(gcf, "./img/out/final",'epsc');

figure
mean_par_err = mean(vecnorm(out.a_hat.Data - a));
plot(out.a_hat.Time, mean_par_err(:),'-r')
ylabel('Average parameters error')
xlabel('t')
ylim([0,150])
saveas(gcf, "./img/out/par_error",'epsc');


figure
hold on;
for i=1:n
    pxi = out.p.Data(i,1,:);
    pyi = out.p.Data(i,2,:);
    plot(pxi(:),pyi(:),'--')
end
plot(out.p.Data(:,1,end)',out.p.Data(:,2,end)','ko')
xlabel('x');
ylabel('y')
axis off
saveas(gcf, "./img/out/traj",'epsc');

figure
plot(out.est_err.Time, out.est_err.Data, 'k');
hold on;
plot(out.tru_err.Time, out.tru_err.Data, 'r');
xlabel('t')
ylabel('Average position error')
legend('Estimated average position error', 'True average position error')
saveas(gcf, "./img/out/pos_error",'epsc');
