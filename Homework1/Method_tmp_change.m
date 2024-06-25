clc;
clear;

folder_path = 'Datasets/';
file_template = 'image%d.png';

% 读取图像序列的范围
start_frame = 1607;
end_frame = 1950;
num_frames = end_frame - start_frame + 1;
temperature_sequence = cell(1, num_frames);

% 裁剪参数
crop_rect = [298.5 3.5 342 477];

% 读取并裁剪图像序列
for i = start_frame:end_frame
    filename = sprintf([folder_path, file_template], i);
    image_org = imread(filename);
    % 应用裁剪
    image_crop = imcrop(image_org, crop_rect);
    temperature_sequence{i-start_frame+1} = grayscale_to_temperature(image_crop);
end

% 分析温度变化
defects = zeros(size(temperature_sequence{1}));
% manual_threshold = 0.28; % 设置温度变化阈值
manual_threshold = 0.13; % 设置温度变化阈值

for i = 2:num_frames
    % 计算温度变化
    temp_change = abs(double(temperature_sequence{i}) - double(temperature_sequence{i-1}));
    
    % 通过阈值进行二值化
    change_mask = temp_change > (manual_threshold * max(temp_change(:)));
    
    % 累积变化
    defects = defects + change_mask;
end

% 显示缺陷图像
figure;
imagesc(defects);
colormap('jet');
colorbar;
title('热变化法缺陷检测图像');

% 定义温度转换函数
function temperature = grayscale_to_temperature(gray_image)
    temperature = (double(gray_image)/255) * 50 - 273;
end
