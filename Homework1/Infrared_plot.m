clc;
clear;

% 图片编号从1607开始，到1950结束
start_index = 1607;
end_index = 1950;
total_images = end_index - start_index + 1;

% 将图片分成三个区间，以便于随机选择的图片分布均匀
interval_length = floor(total_images / 3);
random_indices = zeros(1, 3);

% 从每个区间中随机选择一个图像
for i = 1:3
    start_interval = start_index + (i-1) * interval_length;
    if i < 3
        end_interval = start_interval + interval_length - 1;
    else
        end_interval = end_index; 
    end
    random_indices(i) = randi([start_interval, end_interval], 1);
end

% 创建一个新窗口来显示图像
figure;
set(gcf, 'Position', [50, 100, 1200, 420]);  % [左边距, 下边距, 宽度, 高度]
sgtitle('随机三个不同时刻红外图像展示  按下任意按键继续')

% 循环显示三个随机图像
for i = 1:3
    subplot(1, 3, i); % 分配子图位置
    file_name = sprintf('Datasets/image%d.png', random_indices(i)); 
    image = imread(file_name);
    image_crop = imcrop(image, [298.5 3.5 342 477]);
    temperature_image = grayscale_to_temperature(image_crop);
    imagesc(temperature_image);
    colormap('JET');
    colorbar;
    title(sprintf('image%d.png', random_indices(i)));
    axis image; % 设置图像的宽高比固定，防止图像被拉伸或压缩
end
waitforbuttonpress;

% 关闭所有图像，继续进行第一张图的交互式选点
close all;

% 选择第一张随机图像进行交互式选点
image_org = imread(sprintf('Datasets/image1607.png')); 
image_crop = imcrop(image_org, [298.5 3.5 342 477]);

% 提取温度信息
temperature_image = grayscale_to_temperature(image_crop);

% 显示温度梯度图
imagesc(temperature_image); % 使用 imagesc 函数显示温度图像
axis image;
colormap('JET');
colorbar; % 显示颜色栏
title('选择背景处坐标');

[x, y] = ginput_int(3); % 获取三个点击点的坐标
disp(['背景处坐标1为：(', num2str(x(1)), ', ', num2str(y(1)), ')']);
disp(['背景处坐标2为：(', num2str(x(2)), ', ', num2str(y(2)), ')']);
disp(['背景处坐标3为：(', num2str(x(3)), ', ', num2str(y(3)), ')']);


% 显示温度梯度图
imagesc(temperature_image); % 使用 imagesc 函数显示温度图像
colormap('JET');
colorbar; % 显示颜色栏
axis image;
title('选择缺陷处坐标');

[l, m] = ginput_int(3); % 获取三个点击点的坐标
disp(['缺陷处坐标1为：(', num2str(l(1)), ', ', num2str(m(1)), ')']);
disp(['缺陷处坐标2为：(', num2str(l(2)), ', ', num2str(m(2)), ')']);
disp(['缺陷处坐标3为：(', num2str(l(3)), ', ', num2str(m(3)), ')']);


% 预先分配存储空间以存储每个时间点的温度值
num_points = 6; % 选择的点数
num_images = 1950-1607;
temperature_data = zeros(num_images, num_points);
temperature_point_data = zeros(num_images, num_points);

% 循环处理每张图片
for i = 1607:1950
    % 读取图像
    filename = sprintf('Datasets/image%d.png', i);
    image_org = imread(filename);
    
    % 裁剪图像
    image_crop = imcrop(image_org, [298.5 3.5 342 477]); % 根据你提供的裁剪参数裁剪图像
    
    % 提取温度信息
    temperature_image = grayscale_to_temperature(image_crop);
    axis image;

    % 提取三个感兴趣的像素点的温度信息
    background1_temperature = temperature_image(y(1), x(1)); % 背景点1
    background2_temperature = temperature_image(y(2), x(2)); % 背景点2
    background3_temperature = temperature_image(y(3), x(3)); % 背景点3

    point1_temperature = temperature_image(l(1), m(1)); % 背景点1
    point2_temperature = temperature_image(l(2), m(2)); % 背景点2
    point3_temperature = temperature_image(l(3), m(3)); % 背景点3

    % 存储温度信息到数组中
    index = i - 1606; % 从1开始索引
    temperature_data(index, :) = [background1_temperature, background2_temperature, background3_temperature,...
        point1_temperature, point2_temperature, point3_temperature];

end

% 计算平均背景温度
average_background_temperature = mean(temperature_data(:, 1:3), 2);

% 时间序列（采样频率0.3帧一秒）
time_sequence = 3:3:1032;


% 绘制温度变化曲线
figure;
plot(time_sequence, temperature_data(:, 1), '--b', 'LineWidth', 0.5, 'DisplayName', '背景点1');
hold on;
plot(time_sequence, temperature_data(:, 2), '--b', 'LineWidth', 0.5, 'DisplayName', '背景点2');
plot(time_sequence, temperature_data(:, 3), '--b', 'LineWidth', 0.5, 'DisplayName', '背景点3');
plot(time_sequence, average_background_temperature(:,1), 'b', 'LineWidth', 2, 'DisplayName', '背景平均温度');

plot(time_sequence, temperature_data(:, 4), 'r','LineWidth', 1.5,  'DisplayName', '缺陷点1');
plot(time_sequence, temperature_data(:, 5), 'g','LineWidth', 1.5,  'DisplayName', '缺陷点2');
plot(time_sequence, temperature_data(:, 6), 'y','LineWidth', 1.5,  'DisplayName', '缺陷点3');
hold off;

% 添加图例和标签
legend('Location', 'northeast');
title('缺陷处与背景温度变化对比曲线');
xlabel('时间（秒）');
ylabel('温度（摄氏度）');

waitforbuttonpress;
close all;


function [x_int, y_int] = ginput_int(n)
    [x, y] = ginput(n); % 获取鼠标点击的坐标
    x_int = round(x); % 将 x 坐标四舍五入为整数
    y_int = round(y); % 将 y 坐标四舍五入为整数
end

% 定义温度转换函数
function temperature = grayscale_to_temperature(gray_image)
    temperature = (double(gray_image)/100)-273;  
end