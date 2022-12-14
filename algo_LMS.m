function [e,w] = algo_LMS(x,d,P,mu)


N = length(x);
w = zeros(P,N+1);
e = zeros(N,1);
y = zeros(N,1);
X = zeros(P,1);

for n = 2:N+1

    X = [x(n-1);X(1:P-1)];

    y(n-1) = w(:,n-1).'*X;
    e(n-1) = d(n-1)-y(n-1);
    w(:,n) = w(:,n-1) + mu*conj(X)*e(n-1);
end

end