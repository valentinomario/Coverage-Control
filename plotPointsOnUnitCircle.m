function plotPointsOnUnitCircle(q)

    x = cos(q);
    y = sin(q);

    theta = linspace(0, 2*pi, 100);
    x_circle = cos(theta);
    y_circle = sin(theta);
    
    figure;
    set(gcf, 'color', 'w')
    plot(x_circle, y_circle, 'b-', 'LineWidth', 1.5);
    hold on;
    axis equal;
    axis off;
    plot(x, y, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    
    for i = 1:length(q)
        angle_deg = rad2deg(q(i));
        angle_text = sprintf('q_%d: %.2f°', i, angle_deg);
        text(x(i) + 0.1, y(i), angle_text);
    end

    hold off;
end
