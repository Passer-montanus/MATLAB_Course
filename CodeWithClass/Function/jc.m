function p = jc(x)
%JC 此处显示有关此函数的摘要
%   此处显示详细说明
p = 1;
for i = 1:x
    p = p*i;
end

disp(strcat(num2str(x),'的阶乘为：',num2str(p)))

end