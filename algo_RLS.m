function [e,w] = algo_RLS(x,d,P,lambda, delta)

N = length(x);
w = zeros(P,N+1);
e = zeros(N,1);

X = zeros(P,1);
K = eye(P)/delta;


for n = 2:N
    X = [x(n-1);X(1:P-1)];
    K = 1/lambda * (K - (K*conj(X)*X.'*K)/(lambda+X.'*K*conj(X)));
    e(n) = d(n)-X.'*w(:,n-1);
    w(:,n) = w(:,n-1)+K*conj(X)*e(n);

end

end