function OUTPUT = PIDtest2(K,KP,KI,KD,p,z,in,delay,freq,ifsin)
syms s
%TF means Transfer_Function
CTF=1;
for ii=1:length(p)
    if imag(p(ii)) == 0
       CTF=(1/(s-p(ii)))*CTF;
    else
       CTF=(1/(s-conj(p(ii))))*CTF;
    end
end
for jj=1:length(z)
    if imag(z(jj)) == 0
       CTF=(s-z(jj))*CTF;
    else
       CTF=(s-conj(z(jj)))*CTF;
    end    
end

if ifsin == 1
    Input_TF = freq/(s^2+freq^2);
else
    Input_TF = s^in;
end
GTF = (KP+KI/s+KD*s)*CTF
Output_TF = K*GTF/((1+GTF)*Input_TF) * exp(-delay*s);
OUTPUT = ilaplace(Output_TF);
end

