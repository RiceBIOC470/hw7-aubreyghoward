%HW7
%GB comments
1a 95 you are almost completely correct. Be more complete with what you mean by population leveling off at 1. 
1b. 100
1c. 100
1d. 0 no solution
2a 50 wrong equations used. It should be [V/(1+x(2)^4)-x(1); V/(1+x(1)^4)-x(2)];
2b. 100 correctly generated plots, but the equations used are wrong. I will give full credit
2c  100 same as 2b. 
overall: 78


clear all
% Problem 1: Modeling population growth
% The simplest model for a growing population assumes that each current
% individual has equal likelihood to divide, which yields a differential
% equation dx/dt = a*x where a is the division rate. It is easy to see that
% this will grow exponentially without bound. A simple modification is to
% assume that the growth rate slows done as the population reaches some
% maximum value N so that dx/dt = a*x*(1-x/N). Defining X = x/N, we have 
% dX/dt = a*X*(1-X).  
% Part 1. This equation has two fixed points at 0 and 1. Explain the
% meaning of these two points.

figure(1);
a = 2;
X = 0:0.01:1.5;
gx = a.*X.*(1-X);
plot(X,gx,'LineWidth',3); hold on;
xlabel('#bact/MaxBact'); ylabel('g(x)'); set(gca,'FontSize',18); hold on;
plot([0 1.5],[0 0],'k','LineWidth',3); hold on;
legend('Bact Growth','0 line'); hold off;
hold on;

%Adam: The two fixed points represents the two equilibrium states of the
%growth of the bacteria. The first point at 0 will have no growth because
%there is no starting bacteria. The other point at 1 is the equilibrium
%point where the growth will level off. 

% Part 2: Evaluate the stability of these fixed points. Does it depend on
% the value of the parameter a? 
figure(2);
X = 0:0.01:1.5;
for a = 1:5
gx = a.*X.*(1-X);
plot(X,gx,'LineWidth',3); hold on;
end
xlabel('#bact/MaxBact'); ylabel('g(x)'); set(gca,'FontSize',18);
plot([0 1.5],[0 0],'k','LineWidth',3); hold on;
hold on;

%Adam: as you can see in figure 2, the stability of these two points do not
%vary with the value of a. This makes sense as a only represents the rate
%at which will will approach the fixed points. 
%%
% Part 3: Write a function that takes two inputs - the initial condition x0
% and the a parameter and integrates the equation forward in time. Make
% your code return two variables - the timecourse of X and the time
% required for the population to reach 99% of its maximum value. 


[sol3,Nt3] = ManualIntegrate(80000000,20200000)






% Part 4: Another possible model is to consider discrete generations
% instead allowing the population to vary continuously. e.g. X(t+1) = a*
% X(t)*(1-X(t)). Consider this model and vary the a parameter in the range 0
% < a <= 4. For each value of a choose 200 random starting points  0 < x0 < 1 
% and iterate the equation forward to steady state. For each final
% value Xf, plot the point in the plane (a,Xf) so that at the end you will
% have produced a bifucation diagram showing all possible final values of
% Xf at each value of a. Explain your results. 

%%
% Problem 2. Genetic toggle switches. 
% Consider a genetic system of two genes A and B in which each gene
% product represses the expression of the other. Make the following
% assumptions: 

% a. Repression is cooperative:  each promotor region of one gene has 4
% binding sites for the other protein and that all of these need to be
% occupied for the gene to be repressed. 
% b. You can ignore the intermediate mRNA production so that the product of
% the synthesis of one gene can be assumed to directly repress the other
% c. the system is prefectly symmetric so that the degradation
% times, binding strengths etc are the same for both genes. 
% d. You can choose time and concentration scales so that all Michaelis
% binding constants and degradation times are equal to 1. 
%
% Part 1. Write down a two equation model (one for each gene product) for
% this system. Your model should have one free parameter corresponding to the
% maximum rate of expression of the gene, call it V. 
% Adam: da/dt = (V+(V-k)B^4)/(1 + B^4)-B
%       db/dt = (V+(V-k)A^4)/(1 + A^4)-A
% Part 2. Write code to integrate your model in time and plot the results for V = 5 for two cases, 
% one in which A0 > B0 and one in which B0 > A0. 

% Case of A0 > B0
k = 1; V = 5; A0 = 20; B0 = 3;
dxA = @(t,B) (V+(V-k).*B^4)/(1 + B^4)-B;
dxB = @(t,A) (V+(V-k).*A^4)/(1 + A^4)-A;
solA1 = ode23(dxA, [0 10], B0);
solB1 = ode23(dxB, [0 10], A0);
figure; hold on;
plot(solA1.x,solA1.y,'r-'); hold on;
plot(solB1.x,solB1.y,'b-'); hold on;
xlabel('time'); ylabel('expression');
legend('A expression', 'B expression');
clear all

% Case of A0 < B0
k = 1; V = 5; A0 = 1; B0 = 10;
dxA = @(t,B) (V+(V-k).*B^4)/(1 + B^4)-B;
dxB = @(t,A) (V+(V-k).*A^4)/(1 + A^4)-A;
solA1 = ode23(dxA, [0 10], B0);
solB1 = ode23(dxB, [0 10], A0);
figure; hold on;
plot(solA1.x,solA1.y,'r-'); hold on;
plot(solB1.x,solB1.y,'b-'); hold on;
xlabel('time'); ylabel('expression');
legend('A expression', 'B expression');
%%
% Part 3. By any means you want, write code to produce a bifurcation diagram showing all
% fixed points of the system as a function of the V parameter. 
% dA/dt = 0 = -B^5+(V-k)*B^4+0*B^3+0*B^2-B+V
figure; hold on;
k = 2; %"leaky" rate of transcription.
for V = -5:0.1:5
    polycoeff = [-1 (V-k) 0 0 -1 V]
    rts = roots(polycoeff);
    rts = rts(imag(rts) == 0);
    plot(V*ones(length(rts),1),rts,'r.');
end
hold off;
xlabel('V'); ylabel('Zeros points');


