function dy = cartpend_pid(t, y, m, M, L, g, d, Kp, Ki, Kd)
    persistent error_integral previous_error
    if isempty(error_integral)
        error_integral = 0;
        previous_error = 0;
    end

    desired_state = [1; 0; pi; 0];
    error = desired_state - y;
    error_integral = error_integral + error(3) * 0.001;  % 只积分角度误差
    derivative = (error(3) - previous_error) / 0.001;
    previous_error = error(3);

    % PID 控制器计算控制力
    u = Kp * error(3) + Ki * error_integral + Kd * derivative;

    % 系统动力学模型
    dy = cartpend(y, m, M, L, g, d, u);
end
