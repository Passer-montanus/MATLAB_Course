clc;
clear;
% M_ball 乳胶气球球皮质量   1.60 kg
% M_gas  球内气体实时质量   M_gas = m_g0-m_gR
% m_g0   球内气体初始质量   2.09 kg
% m_gR   球内气体释放质量   0.00 kg
% M_pay  载荷及压舱物质量   M_pay = M_a+m_b0-m_bR
% m_b0   压舱物初始质量     1.50 kg
% m_bR   压舱物释放质量     0.00 kg
% M_a    航电设备质量       8.50 kg
% b      浮力计算系数       4.96
% d_l    低空段空气阻力系数  2.09 kg/sec
% d_u    高空段空气阻力系数  2.97 kg/sec
% g      重力加速度         9.81 m/sec^2
% z      气球飞行高度       Max = 260000 m

M_ball = 1.6 ;
m_g0 = 2.09;
m_gR = 0 ;
M_gas = m_g0-m_gR ;
m_b0 = 1.5 ;
m_bR = 0 ;
M_a = 8.5 ;
M_pay = M_a+m_b0-m_bR ;
b = 4.96 ;
d_l = 2.09 ;
d_u = 2.97 ;
g = 9.81 ;


% 定义状态变量和平衡点
syms z dz u1 u2 real
x = [z; dz];

% 选择空气阻力系数
d = d_u; % 当前处于高空段

% 动力学方程
ddz = (-d*dz + b*g*(m_g0 - u1) - (m_g0 - u1)*g - (M_a + m_b0 - u2)*g) / (m_g0 + M_a + m_b0 - (u1 + u2));

% 计算平衡点（假设 z0 = 0, dz0 = 0, u1 = 0, u2 = 0 为平衡点）
z0 = 26000;
dz0 = 0;
u10 = 0;
u20 = 0;

% 状态空间方程的雅可比矩阵
A = jacobian([dz; ddz], x);
B = jacobian([dz; ddz], [u1; u2]);

% 代入平衡点计算雅可比矩阵的数值
A_num = double(subs(A, {z, dz, u1, u2}, {z0, dz0, u10, u20}));
B_num = double(subs(B, {z, dz, u1, u2}, {z0, dz0, u10, u20}));

% 状态空间模型
A_ref = [0 1;0 -d/(M_pay+M_gas)];
B_ref = [0 0;
        (-(M_pay+M_gas)*b*g-b*g*m_g0)/(M_pay+M_gas)^2 (b*g*m_g0)/(M_pay+M_gas)^2];
C = [1 0]; % 输出矩阵，输出位置高度
D = [0 0]; % 输入直接到输出的传递矩阵

% 创建状态空间系统
states = {'z' 'z_dot'};
inputs = {'u1' 'u2'};
outputs = {'z'};
sys_ss = ss(A_num, B_num, C, D,'statename',states,'inputname',inputs,'outputname',outputs)
rfsys_ss = ss(A_ref,B_ref,C,D,'statename',states,'inputname',inputs,'outputname',outputs)


[num_tf , den_tf] = tfdata(sys_ss);
sys_ss2tf = tf(num_tf,den_tf) % 原系统状态空间方程转传递函数


[z_ss , p_ss , k_ss] = zpkdata(sys_ss,'v');
sys_ss2zpk = zpk(z_ss,p_ss,k_ss)  % 原系统状态空间方程转零极点形式