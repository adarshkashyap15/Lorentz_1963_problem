clear variables
clc
close all

% Defining constants
sigma=10;
beta=8/3;
rho=28;

% Initial conditions
x0=[-8;8;27];
dt=0.01;
tspan=[0:dt:4];
X(:,1)=x0;
xin=x0;

% Time iteration
for i=1:tspan(end)/dt
    time=i*dt;
    xout=rk4singlestep(@(t,x)lorentz_function(t,x,sigma,beta,rho),dt,time,xin);
    X=[X xout];
    xin=xout;
end

% Plotting
plot3(X(1,:),X(2,:),X(3,:),'r','Linewidth',3) % My RK4 Plot
hold on
set(gca,'Fontsize',15)
view(20,40);
[t,x]=ode45(@(t,x)lorentz_function(t,x,sigma,beta,rho),tspan,x0);
plot3(x(:,1),x(:,2),x(:,3),'b','LineWidth',3) % ODE45 Plot
hold off

% If you want to animate then uncomment it
% comet3(X(1,:),X(2,:),X(3,:))