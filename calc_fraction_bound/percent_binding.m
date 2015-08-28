function z = percent_binding(S1T,X0,AT,Kd)
    x = S1T-X0*tanh(S1T/X0);
    Y = 1/(2*AT)*((x+AT+Kd)-sqrt((x+AT+Kd).^2-4*AT*x));
    z = Y;
end