% Question 1

syms r x;
[r, x] = vpasolve([sqrt(r^2 - 1.5257^2) + sqrt(r^2 - 6.2336^2) == 21*x, sqrt(r^2 - 1.5257^2) + sqrt(r^2 - 1.9678^2) == 28*x]);
radiate_weight = abs(r) / 4;
avg_dist = x / radiate_weight;
disp(avg_dist);

attachment_2 = csvread('../resource/attachment-2.csv');
last_k = 0;
result_k = zeros(1,180);
% for i = 1:90
%     start_index = 1;
%     for j = 1:512
%         if attachment_2(j, i) ~= 0
%             start_index = j;
%             break;
%         end
%     end
% %     disp(start_index);
% 
%     calculation_array = attachment_2((start_index + 3):(start_index + 10), i);
% %     disp([start_index+3, start_index+10]);
%     syms k m n;
%     a = 15; b = 40;
%     [k, m, n] = vpasolve([(sqrt(1+k.^2)/(1 + a.^2*k.^2/b.^2))*sqrt(4*a.^4*m.^2*k.^2/b.^4 - 4*a^2*(1 + a.^2*k.^2/b.^2)*(m.^2/b.^2 - 1)) == calculation_array(1)/radiate_weight, ...
%         (sqrt(1+k.^2)/(1 + a.^2*k.^2/b.^2))*sqrt(4*a.^4*n.^2*k.^2/b.^4 - 4*a.^2*(1 + a.^2*k.^2/b.^2)*(n.^2/b.^2 - 1)) == calculation_array(end)/radiate_weight, ...
%         abs(m - n)/sqrt(1 + k.^2) == 7*avg_dist], [k m n]);
%     k = -abs(k);
%     m = -abs(m);
%     n = -abs(n);
%     if i == 1
%         last_k = abs(k);
% %         result_k(i) = k;
% %         disp(i);
%         if (atan(k) < 0)
%             disp(vpa(pi + atan(k)));
%         else
%             disp(vpa(pi + atan(k)));
%         end
%         continue;
%     else
%         if last_k < abs(k)
%             k = abs(k);
%             last_k = k;
% %             result_k(i) = k;
%         else
%             last_k = abs(k);
% %             result_k(i) = k;
%         end
%     end
% %     disp(i);
%     if (atan(k) < 0)
%         disp(vpa(pi + atan(k)));
%     else
%         disp(vpa(pi + atan(k)));
%     end
% end

% disp(result_k);

for i = 91:180
%     disp(i);
    end_index = 512;
    for j = 512:-1:1
        if attachment_2(j, i) ~= 0
            end_index = j;
            break;
        end
    end
%     disp(start_index);
    
    calculation_array = attachment_2((end_index - 10):(end_index - 3), i);
%     disp([calculation_array(1), calculation_array(end)]);
    syms k m n;
    a = 15; b = 40;
    [k, m, n] = vpasolve([(sqrt(1+k.^2)/(1 + a.^2*k.^2/b.^2))*sqrt(4*a.^4*m.^2*k.^2/b.^4 - 4*a^2*(1 + a.^2*k.^2/b.^2)*(m.^2/b.^2 - 1)) == calculation_array(1)/radiate_weight, ...
        (sqrt(1+k.^2)/(1 + a.^2*k.^2/b.^2))*sqrt(4*a.^4*n.^2*k.^2/b.^4 - 4*a.^2*(1 + a.^2*k.^2/b.^2)*(n.^2/b.^2 - 1)) == calculation_array(end)/radiate_weight, ...
        abs(m - n)/sqrt(1 + k.^2) == 7*avg_dist], [k m n]);
    k = abs(k);
%     m = abs(m);
%     n = abs(n);
    if i == 1
        last_k = abs(k);
%         result_k(i) = k;
%         disp(i);
%         disp(k);
        %
        if (atan(k) < 0)
            disp(vpa(2*pi + atan(k)));
        else
            disp(vpa(pi + atan(k)));
        end
        continue;
    else
        if last_k > abs(k)
            k = -abs(k);
            last_k = abs(k);
%             result_k(i) = k;
        else
            last_k = abs(k);
%             result_k(i) = k;
        end
    end
%     disp(i);
%     disp(k);
    if (atan(k) < 0)
        disp(vpa(2*pi + atan(k)));
    else
        disp(vpa(pi + atan(k)));
    end
end
