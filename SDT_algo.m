% Program for the steepest Decent Algorithm
clc;clear all;close;

% Generating Desired Signal 
t = 0.001:0.001:1 ;
d = 2*sin(2*pi*50*t); 

% Generating a corrupted signal with Noise 
n = numel(d); % Generate same number of element as desired signal
x = d(1,n) + 0.9*randn(1,n);

% Parameter
M = 250; % Filter_Order of the adaptive filter

w = zeros(M, 1); % Initialize variables with zero

wi = zeros(M,1); % Initialize the updated variable with zero

R = []; % Generate a null matrix of a auto correlation
k = 1;
r = xcorr(x);
rr = [];

for i = 1:1:M
    rr(i) = r(n-i+1);
end

R = toeplitz(rr);
ei = max(eig(R));
u = 1/ei;
p = xcorr(d,x);

for i = 1:1:M
   P(i) = p(n-i+1);
end
for i = 1:10
    wi = w + u*(P'- R*w);
    w  = wi;
end

% Estimating the signal
y = zeros(n,1);
for i = M:n
   y(i) = (wi'* x(i:-1:i-M+1)');
end

% Computing the errror Signal
error_signal = y' - d;

% Display of Signals
subplot(4,1,1);
plot(d, 'b');
title('Desired Signal');

subplot(4,1,2);
plot(x);
title('Signal Corrupted with Noise');

subplot(4,1,3);
plot(y,'g');
title('Estimated Signal');

subplot(4,1,4);
plot(error_signal,'r');
title('Error signal');
