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
subplot(411),
plot(e);
title("Signal d'erreur e_n");
legend("e_n");

subplot(412),
plot(w.');
title("Evolution des coefficients du filtre w_n au cours du temps");
legend("w_1","w_2","w_3");

subplot(413), 
plot(abs(w-wopt).');
title("Evolution de l’erreur sur les coefficients du filtre |w_n-w_{opt}|");
legend("|w_1-w_{opt}|","|w_2-w_{opt}|","|w_3-w_{opt}|");

subplot(414), 
plot(abs(w-wopt).^2.')
title("Evolution de la norme 2 au carré de l’erreur sur le filtre")
legend("|w_1-w_{opt}|^2","|w_2-w_{opt}|^2","|w_3-w_{opt}|^2");

%disp(w)
soundsc(e, Fe);
