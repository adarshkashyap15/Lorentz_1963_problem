function dx=lorentz3d_function(t,x,sigma,beta,rho)
dx=[
sigma*(x(2,:,:,:)-x(1,:,:,:));
(x(1,:,:,:).*(rho-x(3,:,:,:)))-x(2,:,:,:); 
(x(1,:,:,:).*x(2,:,:,:))-(beta*x(3,:,:,:)) 
];
end