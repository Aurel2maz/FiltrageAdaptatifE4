function [e,w,mu] = algo_LMS_dec(x,d,P,mu_init)


N = length(x);
mu = zeros(N,1);
mu(1)=mu_init;
w = zeros(P,N+1);
e = zeros(N,1);
y = zeros(N,1);
X = zeros(P,1);


for n = 2:N+1
    mu(n)=mu(n-1)/1.0001;
    X = [x(n-1);X(1:P-1)];

    y(n-1) = w(:,n-1).'*X;
    e(n-1) = d(n-1)-y(n-1);
    w(:,n) = w(:,n-1) + mu(n)*conj(X)*e(n-1);
end