% Question 2

result_shape = zeros(256, 256);
data = csvread('../resource/attachment-3.csv');
data2 = csvread('../resource/attachment-2.csv');
data5 = csvread('../resource/attachment-5.csv');
angles = csvread('../resource/angle_data.csv');
bias_from_1 = 58.8482;
center_x = -6.0874;
center_y = 4.1505;
d = 0.2767;
detector_total_length = 141.6704;
question_data = csvread('../resource/attachment-4.csv');
positions = zeros(10, 2);
result_2 = zeros(10);
result_3 = zeros(10);

% deal with attachment 4
[l, r] = size(question_data);
for i = 1:l
    positions(i, 1) = floor(question_data(i, 1) / (100/256));
    positions(i, 2) = 256 - floor(question_data(i, 2) / (100/256));
%     disp([positions(i, 1), positions(i, 2)]);
end

I1 = iradon(data, rad2deg(angles) - 90, 'linear', 'Ram-Lak', 512);
I2 = imresize(I1, 1/sqrt(2));
disp(length(I2));
[R, C] = size(I2);
I3 = zeros(R, C);
delx = -15; % distance in pixels
dely = -22; % distance in pixels
tras = [1 0 delx; 0 1 dely; 0 0 1];

for i = 1:R
    for j = 1:C
        tmp = [i; j; 1];
        tmp = tras * tmp;
        x = tmp(1,1);
        y = tmp(2,1);
        if (x <= R) && (y <= C) && (x >= 1) && (y >= 1)
            I3(x, y) = I2(i, j);
        end
    end
end;

% imshow(I3);
start_index = floor(length(I3)/2 - 128);
disp(start_index);
I4 = I3(start_index:(start_index + 256), start_index:(start_index + 256));
% imshow(I4);

for i = 1:10
    disp(I4(positions(i, 1), positions(i, 2)));
end

csvwrite('../resource/problem2.csv', I4(1:256, 1:256));

%%%%%%%%%%

I1 = iradon(data5, rad2deg(angles) - 90, 'linear', 'Ram-Lak', 512);
I2 = imresize(I1, 1/sqrt(2));
disp(length(I2));
[R, C] = size(I2);
I3 = zeros(R, C);
delx = -15; % distance in pixels
dely = -22; % distance in pixels
tras = [1 0 delx; 0 1 dely; 0 0 1];

for i = 1:R
    for j = 1:C
        tmp = [i; j; 1];
        tmp = tras * tmp;
        x = tmp(1,1);
        y = tmp(2,1);
        if (x <= R) && (y <= C) && (x >= 1) && (y >= 1)
            I3(x, y) = I2(i, j);
        end
    end
end;

% imshow(I3);
start_index = floor(length(I3)/2 - 128);
disp(start_index);
I4 = I3(start_index:(start_index + 256), start_index:(start_index + 256));
% imshow(I4);

for i = 1:10
    disp(I4(positions(i, 1), positions(i, 2)));
end

csvwrite('../resource/problem3.csv', I4(1:256, 1:256));

% sum_angle = 0;
% for i = 1:(length(angles) - 1)
%     sum_angle = sum_angle + (angles(i + 1) - angles(i));
% end
% avg_angle = sum_angle / (length(angles) - 1);
% s = linspace(-bias_from_1, detector_total_length - bias_from_1, 512);
% disp(length(s));
% disp(length(angles));
% 
% xi = linspace(s(1), s(end), 10*512);
% yi = linspace(angles(1), angles(end), 10*180);
% z1 = griddata(s, angles, data.', xi, yi');
% z1 = z1';
% disp('finished interp on angles and distances');
% 
% integral_tmp = zeros(length(s) - 1, length(angles) - 1);
% 
% xs = linspace(-100, 100, 256);
% ys = linspace(-100, 100, 256);
% for x = 1:256
%     for y = 1:256
%         for s_index = 1:length(s) - 1 % count 512
%             for theta_index = 1:length(angles) - 1 % count 180
%                 % loop start
%                 % derivative of s (bias from center)
%                 if s_index == length(s)
%                     derivative = (data(s_index, theta_index) - z1(10*s_index-10, 10*y_index-9)) / (d/10);
%                 else
%                     derivative = (z1(10*s_index-8, 10*theta_index-9) - data(s_index, theta_index)) / (d/10);
%                 end
% %                 res = derivative / ((xs(x) + center_x)*cos(angles(theta_index)) + (ys(y) + center_y)*sin(angles(theta_index)) - abs(s(s_index)));
%                 res = derivative / ((xs(x) + center_x)*cos(angles(theta_index)) + (ys(y) + center_y)*sin(angles(theta_index)) - abs(s(s_index)));
%                 
%                 if s_index == 1 && theta_index == 1
%                     integral_tmp(s_index, theta_index) = (1/4) * res;
%                 elseif s_index == length(s) && theta_index == length(theta)
%                     integral_tmp(s_index, theta_index) = (1/4) * res;
%                 elseif s_index == 1 && theta_index > 1 && theta_index < length(theta)
%                     integral_tmp(s_index, theta_index) = (1/2) * res;
%                 elseif theta_index == 1 && s_index > 1 && s_index < length(s)
%                     integral_tmp(s_index, theta_index) = (1/2) * res;
%                 else
%                     integral_tmp(s_index, theta_index) = res;
%                 end
%                 % loop end
%             end
%         end
%         % apply to real (x, y)
%         result_shape(x, y) = avg_angle * d * sum(sum(integral_tmp)) / (2 * pi.^2);
%     end
% end
% 
% xlswrite('../resource/problem2.xls', result_shape);

% For each X-ray
% for i = 1:180
%     x = linspace(-bias_from_1, detector_total_length - bias_from_1, 512);
%     if angle(i) < 1.5*pi
%         k = arctan(angle(i) - pi);
%     else
%         k = arctan(2*pi - angle(i));
%     end
%     y_gap = sqrt(1 + angles(i).^2) * d;
%     y_round_center = center_y - k * center_x;
%     if angle(i) < 1.5*pi
%         y_start = y_round_center - y_gap * (bias_from_1 / d);
%         y_end = y_round_center + y_gap * (bias_from_1 / d);
%     else
%         y_start = y_round_center + y_gap * (bias_from_1 / d);
%         y_end = y_round_center - y_gap * (bias_from_1 / d);
%     end
%     y = linspace(y_start, y_end, 512);
%     
% end
