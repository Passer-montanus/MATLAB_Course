%% 系统的动态性能函数，该函数输入输出的信号y和每个输出信号的间隔dt，得到该系统的一些动态性能指标
%ts指调节时间
function [text,tr,Mp,tp,ts,ys]=dynamicproperties(y,dt)
[lp,m]=size(y);  %lp是该输入y的数量
type=0; %系统类型的指标
%此函数的使用基础是该系统稳定，temp为最后的稳定值
temp=0;
length=fix(lp/20); %fix是取整函数，用最后的几位取平均值作为temp
for i=lp:-1:lp-length+1
    temp=temp+y(i);
end
temp=temp/length;
%得到最后几位的误差
error=zeros(1,length);
for i=lp:-1:lp-length
    error(lp-i+1)=abs(y(i)-temp);
end
test=0;
for i=1:lp-1
    if(y(i+1)<y(i))
        test=test+1;
    end
end
ys=0; %稳定值
%找到误差最大值
[emax,te]=max(error);
if abs(emax)> 0.02*abs(temp) %说明不稳定
    type=3;
    fai=-1;
    Mp=-1;
    ts=-1;
    tr=-1;
    tp=-1;
    ys=0;
elseif test<=5       %递减的少，一般认为是一阶系统
    type=1;
    ys=y(lp);
else
    type=2;
    ys=y(lp);
end


%一阶系统
if type==1
    Mp=0; %超调量
    tp=dt*lp; %峰值时间
    i=lp;
    while y(i)>ys*0.95
        i=i-1;
    end
    ts=(i+1)*dt;  %调节时间
    while y(i)>ys*0.9
        i=i-1;
    end
    tr=i*dt; %上升时间
end

%二阶系统
if type==2
    i=1;
    while y(i)<0.98*ys
        i=i+1;
    end
    tr=i*dt;  %上升时间
    i=lp;
    while y(i)>0.95*ys&&y(i)<ys*1.05
        i=i-1;
    end
    ts=i*dt;   %调节时间
    [ymax,tmax]=max(y);
    tp=dt*tmax;  %峰值时间
    Mp=(ymax-ys)/ys*100; %超调量
end

tr1=num2str(tr);
mp1=num2str(Mp);
tp1=num2str(tp);
ts1=num2str(ts);
ys1=num2str(ys);
text=['上升时间tr=',tr1,'  超调量Mp=',mp1,'  峰值时间tp=',tp1,'  调节时间ts=',ts1,'  稳定值ys=',ys1];