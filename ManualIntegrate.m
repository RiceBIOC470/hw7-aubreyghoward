function [sol,Nt] = ManualIntegrate(x0,ain)

func = @(t,X,a) a.*X.*(1-X)
N99 = x0./0.99
sol = ode23(func,[0 1],[0,x0;ain])
figure;
plot(sol.x,sol.y,'g.-')


% Part 3: Write a function that takes two inputs - the initial condition x0
% and the a parameter and integrates the equation forward in time. Make
% your code return two variables - the timecourse of X and the time
% required for the population to reach 99% of its maximum value. 
