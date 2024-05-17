clc; clear; close all;

% Program of a LMS algorithm

% Generating Desired Signal 
t = 0.001:0.001:1 ;
d = 2*sin(2*pi*50*t); 

% Generating a corrupted signal with Noise 
n = numel(d); % Generate same number of element as desired signal
x = d(1,n) + 0.9*randn(1,n);

% Parameter
M = 2; % Filter_Order of the adaptive filter

w = zeros(1,M); % Initialize variables with zero

wi = zeros(1,M); % Initialize the updated variable with zero

e = [];  % Initialize the Error matrix with null

mu = 0.001;  % Step size

% LMS algoritham
for i = M:n
    e(i) = d(i) - wi * x(i:-1:i-M+1)';
    wi = wi + 2*mu*e(i)*x(i:-1:i-M+1);
end

% Estimated signal
y = zeros(n,1);
for i = M:n
   y(i) = (wi* x(i:-1:i-M+1)');
end

% Computing the errror Signal
error_signal = y' - d;

% Display of the signal
subplot(4,1,1);
plot(d, 'b');
title('Desired Signal');

subplot(4,1,2);
plot(x);
title('Corrupted Signal');

subplot(4,1,3);
plot(y,'g');
title('Estimated Signal');

subplot(4,1,4);
plot(error_signal,'r');
title('Error signal');

