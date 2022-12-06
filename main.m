clear all;
clc;

load("parole_bruitee.mat");

load("decticelle.mat");



Fe = 8192;
wopt = [1, 1/2, 1/4].';
%figure(1)
% subplot(211), plot(x);
% subplot(212), plot(d);

% soundsc(x, Fe), pause;
% soundsc(d, Fe), pause;

[e, w] = algo_LMS(x, d, 3, 10^-10);


figure(2);
subplot(411), plot(e);
subplot(412), plot(w.');
subplot(413), plot(abs(w-wopt).')
subplot(414), plot(abs(w-wopt).^2.')
%disp(w)
soundsc(e, Fe);
