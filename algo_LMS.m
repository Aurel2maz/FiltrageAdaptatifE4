function [e,w] = algo_LMS(x,d,P,mu)


N = length(x);
X = zeros(P,N);
w = zeros(P,N);
e = zeros(N,1);
y = zeros(N,1);

for n = P:N-P+1
    X(:,n) = x(n:n+P-1).';


    y(n-1) = w(:,n-1).'*X(:,n-1);
    e(n-1) = d(n-1)-y(n-1);
    w(:,n) = w(:,n-1) + mu*conj(X(:,n-1))*e(n-1);
end



end