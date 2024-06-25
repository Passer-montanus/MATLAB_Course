    m = 1;  % 摆杆质量
    M = 5;  % 小车质量
    L = 2;  % 摆杆长度
    g = -10;  % 重力加速度
    d = 1;  % 阻尼系数
    s = 1;  % 摆杆初始状态，1表示向上

    % 状态空间矩阵 A, B
    A = [0 1 0 0;
        0 -d/M -m*g/M 0;
        0 0 0 1;
        0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];
    B = [0; 1/M; 0; s*1/(M*L)];

    % 输出矩阵 C 和直接传递矩阵 D
    C = [0 0 1 0];  % 关心的输出是摆杆角度
    D = [0];

    % 导出传递函数
    [num,den] = ss2tf(A, B, C, D);
    sys_cartpend = tf(num, den);

    num1 = [1];
    den1 = [1 , 2 , 3];
    sys_exp1 = tf(num1,den1);

    num2 = [5];
    den2 = [1 , -2 , 3];
    sys_exp2 = tf(num2,den2);
