function poles = PID_poles(a,b,c)
syms s
p=[a b c 0];
poles=roots(p);
end

