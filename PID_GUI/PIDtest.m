function OUTPUT = PIDtest(K,KP,KI,KD,a,b,c,in,delay,freq,ifsin)
syms s
%TF means Transfer_Function
GTF = (KP+KI/s+KD*s)/(c*s^2+b*s+a); 
if ifsin == 1
    Input_TF = freq/(s^2+freq^2);
else
    Input_TF = s^in;
end
Output_TF = K*GTF/((1+GTF)*Input_TF) * exp(-delay*s);
OUTPUT = ilaplace(Output_TF);
end

