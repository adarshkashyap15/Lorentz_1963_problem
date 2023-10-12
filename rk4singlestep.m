function xout=rk4singlestep(fun,dt,tk,xk)
k1=fun(tk,xk);
k2=fun(tk+(dt/2),xk+(dt/2)*k1);
k3=fun(tk+(dt/2),xk+(dt/2)*k2);
k4=fun(tk+dt,xk+dt*k3);


xout=xk+(dt/6)*(k1+2*k2+2*k3+k4);
end