% Plots a heatmap with the values of phi

n = 100;
x = linspace(0, 1, n);
y = linspace(0, 1, n);
[X, Y] = meshgrid(x, y);

Phi = zeros(n, n);

for i = 1:n
    for j = 1:n
        Phi(i, j) = (kappa(X(i, j), Y(i, j))*a);
    end
end
Phi = log10(Phi);
figure;
imagesc(x, y, Phi);
axis xy;
colorbar;
%title('Heatmap of kappa function over [0, 1] x [0, 1]');
xlabel('x');
ylabel('y');

hold;
voronoi(x0,y0,'k.');