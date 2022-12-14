function [e,w_LS] = algo_RLS(x,d,P,lambda, delta)

N = length(x);
w_LS = zeros(P,N+1);
xi = zeros(N,1);
e = zeros(N,1);
% w = zeros(P,N+1);

X = zeros(P,1);
K = eye(P)/delta;

for n = 1:N

    X = [x(n);X(1:P-1)];
    K = 1/lambda * (K - (K*conj(X)*X.'*K)/(lambda+X.'*K*conj(X)));
    
    if n==1
        xi(n) = d(n);
        w_LS(:,n) = 0;
    else
        xi(n) = d(n)-(X.'*w_LS(:,n-1));
        w_LS(:,n) = w_LS(:,n-1)+K*conj(X)*xi(n);
    end
    
    e(n) = d(n)-(X.'*w_LS(:,n));

end

end