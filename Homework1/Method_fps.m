clc;
clear;

folder_path = 'Datasets/';
file_template = 'image%d.png';

% 读取图像序列的范围
start_frame = 1607;
end_frame = 1950;
num_frames = end_frame - start_frame + 1;
image_sequence = cell(1, num_frames);

% 裁剪范围参数
crop_rect = [298.5 3.5 342 477];

% 读取并裁剪图像序列
for i = start_frame:end_frame
    filename = sprintf([folder_path, file_template], i);
    image_org = imread(filename);
    % 应用裁剪
    image_crop = imcrop(image_org, crop_rect);
    image_sequence{i-start_frame+1} = image_crop;
end

% 高斯滤波参数
gaussian_sigma = 0.1;  % 高斯核的标准差

% 应用高斯滤波进行去噪
for i = 1:num_frames
    image_sequence{i} = imgaussfilt(image_sequence{i}, gaussian_sigma);
end

% 手动调整阈值
manual_threshold = 0.19; % 手动设置阈值
morphological_element_size = 1; % 形态学操作的结构元素阈值
area_threshold = 100; % 过滤小对象的面积阈值

% 使用多帧差分和手动设置的阈值
defects = zeros(size(image_sequence{1}));
se = strel('disk', morphological_element_size);
for i = 2:num_frames-1
    % 计算帧差
    frame_diff_prev = abs(double(image_sequence{i}) - double(image_sequence{i-1}));
    frame_diff_next = abs(double(image_sequence{i}) - double(image_sequence{i+1}));
    frame_diff = max(frame_diff_prev, frame_diff_next);
    
    % 手动阈值处理
    frame_diff_binary = frame_diff > (manual_threshold * max(frame_diff(:)));
    
    % 形态学操作
    frame_diff_binary = imclose(frame_diff_binary, se); % 闭操作
    frame_diff_binary = bwareaopen(frame_diff_binary, area_threshold); % 移除小对象
    
    % 累积检测结果
    defects = defects + frame_diff_binary;
end

% 显示缺陷图像
figure;
imagesc(defects);
colormap('jet');
colorbar;
title('帧差法缺陷检测图像');
