function [Umin, Umax] = umbral(obs)

fd=fitdist(obs(:,1),'Normal');
med=fd.mu;
sd=fd.sigma;
Umin=med-1.5*sd;
Umax=med+1.5*sd;

end