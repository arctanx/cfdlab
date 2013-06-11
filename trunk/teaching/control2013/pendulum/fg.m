function dxdt = fg(t,x,A,B,C,K,L,M,l,m,g,k,d,I,alpha,beta)

dxdt = zeros(8,1);

% Compute feedback using estimator
u = -K*x(5:8);
F = alpha*u-beta*x(2);

% nonlinear model
dxdt(1:4,1) = [ x(2);...
         ((l*m*d)/(I+l^2*m)*cos(x(3))*x(4) + l*m*x(4)^2*sin(x(3)) - (l*m)^2/(I+l^2*m)*g*cos(x(3))*sin(x(3)) ...
             - k*x(2) + F )/( (M+m) - (l*m)^2/(I+l^2*m)*cos(x(3))^2 );...
         x(4);...
        ( l*m*g*sin(x(3)) - (l*m)^2/(M+m)*x(4)^2*sin(x(3))*cos(x(3)) -d*x(4)  + k*l*m/(M+m)*cos(x(3))*x(2) ...
          - l*m/(M+m)*cos(x(3))*F )/( I + l^2*m - (l*m)^2/(M+m)*cos(x(3)^2)) ] ;
     
% linear estimator
dxdt(5:8,1) = L*C*x(1:4) + (A-L*C-B*K)*x(5:8);
