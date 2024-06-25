% 2) 图形法计算最大偏差和上升时间
close
clear
sysg1 = tf(12.5, [1 1]);
sysg3 = tf(1, [1 0]);
k = 0.2;
sysg2 = tf(k);
sys1 = feedback(sysg1,sysg2,-1); % 定义内部反馈系统sys1
sys2 = series(sys1, sysg3); % sysg3和内部反馈系统sys1串联
sys = feedback(sys2,1,-1); % 定义整体系统传递函数


% 绘制单位阶跃响应
figure
step(sys)
axis([0 6 0 1.4]); %设定x和y轴范围
legend('0.2');