function [e,w] = algo_RLS(x,d,P,lambda, delta)

N = length(x);
w = zeros(P,N+1);
e = zeros(N,1);
y = zeros(N,1);
X = zeros(P,1);
K = zeros(N);
for n = 2:N
    
end

end