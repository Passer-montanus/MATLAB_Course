function che(ax, Kp, Ki, Kd, x0, detla_pi, t_sim)
% 定义系统参数
persistent error_integral previous_error
clear error_integral previous_error
error_integral = 0;
previous_error = 0;

m = 1;  % 摆杆质量
M = 5;  % 小车质量
L = 2;  % 摆杆长度
g = -10;  % 重力加速度
d = 1;  % 阻尼系数
s = 1;  % 摆杆初始状态，1表示向上

% Kp = 100;
% Ki = 30;
% Kd = 25;

% 时间跨度 (修改t_sim即为仿真时长)

tspan = 0:.001:t_sim;

% 根据s值选择不同的初始条件

if s == -1
    y0 = [0; 0; 0; 0];
elseif s == 1
    y0 = [x0; 0; pi + detla_pi; 0];
end

% 使用 ODE 求解器进行模拟

[t, y] = ode45(@(t, y)cartpend_pid(t, y, m, M, L, g, d, Kp, Ki, Kd), tspan, y0);

cla(ax);

% 可视化结果
for k = 1:100:length(t)
    drawcartpend(ax, y(k,:), m, M, L);
    pause(0.01);  % 稍作暂停以便可视化动态
end
