function OUTPUT = PIDtest3(K,KP,KI,KD,A,in,delay,freq,ifsin)
syms s
%TF means Transfer_Function
[Num,Den] = tfdata(A);
sys_syms = poly2sym(cell2mat(Num),s)/poly2sym(cell2mat(Den),s);
GTF = (KP+KI/s+KD*s)* sys_syms; 
if ifsin == 1
    Input_TF = freq/(s^2+freq^2);
else
    Input_TF = s^in;
end
Output_TF = K*GTF/((1+GTF)*Input_TF) * exp(-delay*s);
OUTPUT=ilaplace(Output_TF);
end
