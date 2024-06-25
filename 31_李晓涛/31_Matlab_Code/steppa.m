function [mp, tp, sigma, tr1, tr2, ts] = steppa(Y, T)
    [mp, tf] = max(Y); % 求出Y向量中的最大值及其对应的位置tf
    tp = T(tf); % 信号的持续时间T中tf所对应的向量值（峰值时间）
    ct = length(T); % 信号的持续时间T向量的长度
    yss = Y(ct); % 时间最大值时所对应的值—稳态值近似
    sigma = 100 * (mp - yss) / yss; % 最大超调量
    
    temp1 = 0;
    temp2 = 0;
    for a = 1:tf % 最大值所对应的向量值
        if Y(a) < yss * 0.1 && Y(a + 1) >= yss * 0.1 % 到达终值0.1倍时间
            temp1 = T(a);
        end
        if Y(a) < yss * 0.9 && Y(a + 1) >= yss * 0.9 % 到达终值0.9倍时间
            temp2 = T(a);
        end
    end
    
    tr1 = temp2 - temp1; % 0.1到0.9倍终值的上升时间
    tr2 = NaN; % 初始化tr2为NaN
    
    for a = 1:tf % 再次遍历从1到tf，计算上升时间tr2
        if Y(a) < yss && Y(a + 1) > yss % 稳态值
            tr2 = T(a); % 求出相对应的起调(上升)时间
            break; % 退出循环
        end
    end
    
    a = ct; % 由稳态时间向前检索
    e = 0.02; % 误差容限
    yss = 1; % 稳态值重新设定为1，用于标准化
    
    while abs((Y(a) - yss) / yss) < e % 超出2%范围的对应数值
        a = a - 1;
    end
    
    ts = T(a); % 调整时间
end
