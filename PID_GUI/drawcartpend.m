function drawcartpend(ax, y, m, M, L)
    x = y(1);
    th = y(3);

    W = 1*sqrt(M/5);  % 小车宽度
    H = 0.5*sqrt(M/5);  % 小车高度
    wr = 0.2;  % 轮子半径
    mr = 0.3*sqrt(m);  % 质量半径

    y_cart = wr/2 + H/2;  % 小车垂直位置
    w1x = x - 0.9*W/2;
    w2x = x + 0.9*W/2 - wr;
    w1y = 0;
    w2y = 0;

    px = x + L*sin(th);
    py = y_cart - L*cos(th);

    plot(ax, [-10 10], [0 0], 'k', 'LineWidth', 2);  % 绘制地面
    hold (ax, 'on')
    rectangle(ax, 'Position', [x-W/2, y_cart-H/2, W, H], 'Curvature', 0.1, 'FaceColor', [1 0.1 0.1]);  % 小车
    rectangle(ax, 'Position', [w1x, w1y, wr, wr], 'Curvature', 1, 'FaceColor', [0 0 0]);  % 轮子1
    rectangle(ax, 'Position', [w2x, w2y, wr, wr], 'Curvature', 1, 'FaceColor', [0 0 0]);  % 轮子2
    plot(ax, [x px], [y_cart py], 'k', 'LineWidth', 2);  % 摆杆

    rectangle(ax, 'Position', [px-mr/2, py-mr/2, mr, mr], 'Curvature', 1, 'FaceColor', [0.1 0.1 1]);  % 摆杆质量
    x_min = -6;
    x_max = 6;
    y_min = -2;
    y_max = 3;

    xlim(ax, [x_min x_max]);
    ylim(ax, [y_min y_max]);
    %set(gcf, 'Position', [100 550 1000 400]);
    drawnow;
    hold (ax, 'off')
end