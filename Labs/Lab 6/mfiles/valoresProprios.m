R = cov(y,'centered');
[V D] = eig(R);
[Ddec I] = sort(diag(D))