function [sol,Nt] = ManualIntegrate(x0,ain)

N99 = x0./0.99
func1 = @(x,a,N) a.*x.*(1-x./N)
func2 = @(t,func1) func1
sol = ode23(func2,[0 10],[x0,ain,N99])

Nt = 0
for ii = 1:length(sol.x)
    if sol.y(ii) < N99
       Nt = sol.x(ii)
    else
        break
        break
    end
end

figure;
plot(sol.x,sol.y(2,:),'g.-'); hold on;
xlabel('time'); hold on;
ylabel('# of bacteria');hold off;
end


% Part 3: Write a function that takes two inputs - the initial condition x0
% and the a parameter and integrates the equation forward in time. Make
% your code return two variables - the timecourse of X and the time
% required for the population to reach 99% of its maximum value. 
