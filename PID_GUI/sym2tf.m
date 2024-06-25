function tf_G1 = sym2tf(G1)%符号函数转换为传递函数形式
[num,den] = numden(G1);%提取符号表达式分子和分母
Num = sym2poly(num);%返回多项式项式系数
Den = sym2poly(den);
tf_G1 = tf(Num,Den);
end