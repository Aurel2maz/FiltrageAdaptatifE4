clear all;
clc;


%% Initialisation

load("parole_bruitee.mat");
load("decticelle.mat");

Fe = 8192;
T = [1:length(d)]/Fe;

figure(1)
subplot(211), plot(T,x);
title("Signal de bruit");
subplot(212), plot(T,d);
title("Signal de parole bruité");


%% Algorithme LMS

P = 3;
wopt = [1, 1/2, 1/4].';
mu = 10^-10;


[e, w] = algo_LMS(x, d, P, mu);


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


%% Ecoutes algo LMS

soundsc(x, Fe), pause; % Ecoute signal bruit seul
soundsc(d, Fe), pause; % Ecoute signal de parole bruité
soundsc(e, Fe), pause; % Ecoute signal de parole débruité

%% Algo LMS avec le pas d'adaptation du pire cas


P = 3;
wopt = [1, 1/2, 1/4].';

alpha = 2;
mu = 2/(alpha*P*max(abs(x).^2));

[e, w] = algo_LMS(x, d, P, mu);


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


%% Algo LMS avec un pas d'adaptation décroissant

mu_init = 10^-9;
[e, w, mu] = algo_LMS_dec(x, d, P, mu_init);


figure(2);
subplot(511),
plot(e);
title("Signal d'erreur e_n");
legend("e_n");

subplot(512),
plot(w.');
title("Evolution des coefficients du filtre w_n au cours du temps");
legend("w_1","w_2","w_3");

subplot(513), 
plot(abs(w-wopt).');
title("Evolution de l’erreur sur les coefficients du filtre |w_n-w_{opt}|");
legend("|w_1-w_{opt}|","|w_2-w_{opt}|","|w_3-w_{opt}|");

subplot(514), 
plot(abs(w-wopt).^2.')
title("Evolution de la norme 2 au carré de l’erreur sur le filtre")
legend("|w_1-w_{opt}|^2","|w_2-w_{opt}|^2","|w_3-w_{opt}|^2");

subplot(515), plot(mu);
title("Evolution du pas d'adaptation mu");
legend("mu");

%% Algo LMS avec P = 2

P=2;
wopt = [1 1/2].';
mu = 10^-10;
[e, w] = algo_LMS(x, d, P, mu);

%% Algo LMS avec P = 5

P = 5;
wopt = [1 1/2 1/4 0 0].';
mu = 10^-10;
[e, w] = algo_LMS(x, d, P, mu);

%% Affichages

figure(3);
subplot(411),
plot(e);
title("Signal d'erreur e_n");
legend("e_n");

subplot(412),
plot(w.');
title("Evolution des coefficients du filtre w_n au cours du temps");
legend("w_1","w_2","w_3", "w_4", "w_5");

subplot(413), 
plot(abs(w-wopt).');
title("Evolution de l’erreur sur les coefficients du filtre |w_n-w_{opt}|");
legend("|w_1-w_{opt}|","|w_2-w_{opt}|","|w_3-w_{opt}|", "|w_4-w_{opt}|", "|w_5-w_{opt}|");

subplot(414), 
plot(abs(w-wopt).^2.')
title("Evolution de la norme 2 au carré de l’erreur sur le filtre")
legend("|w_1-w_{opt}|^2","|w_2-w_{opt}|^2","|w_3-w_{opt}|^2", "|w_4-w_{opt}|^2", "|w_5-w_{opt}|^2");

%% Algo RLS

P = 3;
delta = 0.01;
lambda = 1;
wopt = [1 1/2 1/4].';
[e,w] = algo_RLS(x, d, P, lambda, delta);


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

soundsc(e, Fe) % Ecoute signal de parole débruité

%% Filtrage optimal au sens des moindres carrés

P = 3;
rxx = xcorr(x, P-1);
rdx = xcorr(d,x,P-1);

Rxx = toeplitz(rxx(P:-1:1), rxx(P:1:2*P-1));
Rdx = toeplitz(rdx(P:-1:1), rdx(P:1:2*P-1));

w_LS = inv(conj(Rxx)) * Rdx;

