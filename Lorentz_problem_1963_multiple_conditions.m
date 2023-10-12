clear variables
clc
close all

% Defining constants
sigma=10;
beta=8/3;
rho=28;

% Single Initial conditions for my RK4
x0=[-8;8;27];
dt=0.01;
tspan=0:dt:4;
X(:,1)=x0;
xin=x0;
for i=1:tspan(end)/dt
    time=i*dt;
    xout=rk4singlestep(@(t,x)lorentz_function(t,x,sigma,beta,rho),dt,time,xin);
    X=[X xout];
    xin=xout;
end

% Single Initial conditions for ODE45
[t,x]=ode45(@(t,x)lorentz_function(t,x,sigma,beta,rho),tspan,x0);

% Cube of Initial conditions
xvec=-20:1:20;
yvec=-20:1:20;
zvec=-20:1:20;
[x0_v,y0_v,z0_v]=meshgrid(xvec,yvec,zvec);
xIC(1,:,:,:)=x0_v;
xIC(2,:,:,:)=y0_v;
xIC(3,:,:,:)=z0_v;

% Video formation
dt=0.01;
duration=4;
tspan=[0,duration];
L=duration/dt;
xin=xIC;
videoFile = 'lorentz_animation.mp4';  
writerObj = VideoWriter(videoFile, 'MPEG-4');
open(writerObj);

% Time Iteration
for step=1:L
    time=step*dt;
    xout=rk4singlestep(@(t,x)lorentz3d_function(t,x,sigma,beta,rho),dt,time,xin);
    xin=xout;
    plot3(X(1,:),X(2,:),X(3,:),'r','Linewidth',3)
    hold on
    plot3(x(:,1),x(:,2),x(:,3),'c','LineWidth',3)
    plot3(xout(1,:),xout(2,:),xout(3,:),'b.','MarkerSize',2)
    axis([-60 60 -60 60 -60 60])
    view([20+360*step/L, 40]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(['Lorenz System at t = ' num2str(time)]); 
    set(gca,'Fontsize',10)
    frame = getframe(gcf);
    writeVideo(writerObj, frame);
    hold off
end
close(writerObj);