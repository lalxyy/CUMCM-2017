% Question 4
% Genetic Algorithm
% Fitness function

function [res] = fitness_function(data)
    center_x = -6.0874;
    center_y = 4.1505;
    w = size(data);
    res = zeros(w(1));
    pixels = zeros(256, 256);
    for index = 1:w(1)
        x = data(index, 1) * 100 - 50;
        y = data(index, 2) * 100 - 50;
        theta_start = data(index, 3) * 360 - 180;
        r = data(index, 4) * 50;
        
        % generate 256 pixels
        x = x - center_x;
        y = y - center_y;
        for i = 1:256
            for j = 1:256
                actual_y = (100/256) * i - 50;
                actual_x = 50 - (100/256) * j;
                if ((actual_x - x)^2 + (actual_y - y)^2) < r^2
                    pixels(i, j) = 1.77245;
                else
                    pixels(i, j) = 0;
                end
            end
        end
        R = radon(pixels, theta_start:(theta_start + 179));
        I = iradon(R, theta_start:(theta_start + 179));
        I = I(1:256, 1:256);
        loss = 0;
        for i = 1:256
            for j = 1:256
                loss = loss + (1/2) * (pixels(i, j) - I(i, j))^2;
            end
        end
       
        res(index) = loss;
    end
end
