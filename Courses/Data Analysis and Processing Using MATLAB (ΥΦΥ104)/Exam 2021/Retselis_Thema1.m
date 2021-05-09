% Thema 1
% Anastasios-Faidon Retselis

clear;clc;close all;

sample = [14 28 15 16 14 15 31 20 17 23 18 24 18 26 17 24 11 18 41 32 23 27 31 40 9 19 18 28 19 20];

N = length(sample);
M = 100;

[obs,edges]= histcounts(sample,3);
bins = zeros(length(edges)-1,1);
for i=1:(length(edges)-1)
    center = edges(i)+((edges(i+1)-edges(i))/2);
    bins(i,1) = center;
end
figure;
histfit(sample,3,'poisson');
pd = fitdist(bins, 'poisson','Frequency',obs);
lambda_poisson = pd.lambda;
data = pdf(pd,bins)*sum(bins);

[~,~,st] = chi2gof(bins,'ctrs',bins,'frequency',obs,'expected',data,'nParams',1);
chi_stats_alone = st.chi2stat;

chi_stats = zeros(M,1);
numbers = zeros(N,1);
for j=1:M
    numbers = poissrnd(lambda_poisson,N,1);
    [obs,edges]= histcounts(numbers,edges);
    bins = zeros(length(edges)-1,1);
    for i=1:(length(edges)-1)
        center = edges(i)+((edges(i+1)-edges(i))/2);
        bins(i,1) = center;
    end
    pd = fitdist(bins, 'poisson','Frequency',obs);
    data = pdf(pd,bins)*sum(bins);
    [~,~,st] = chi2gof(bins,'Ctrs',bins,'Frequency',obs,'Expected',data,'NParams',1);
    chi_stats(j) = st.chi2stat;
end

figure;
histfit(chi_stats,10,'poisson');
xline(chi_stats_alone,'-g','LineWidth',1);
legend('χ^2 stats from resampling', sprintf('Original χ^2= %.4f', chi_stats_alone));

[obs,edges]= histcounts(chi_stats);
bins = zeros(length(edges)-1,1);
for i=1:(length(edges)-1)
    center = edges(i)+((edges(i+1)-edges(i))/2);
    bins(i,1) = center;
end
pd = fitdist(bins, 'poisson','Frequency',obs);
lambda = pd.lambda;
data = pdf(pd,bins)*sum(bins);
[~,p,~] = chi2gof(bins,'Ctrs',bins, 'Frequency',obs,'Expected',data,'NParams',1)

%1. Efoson xrhsimopoioume 3 kelia kai exoume katanomi poisson, dof=3-1-1=1
% dhladh exoume 1 bathmo eleftherias
%
%2. Me basi monaxa to figure 1, mporoume na isxyristoume pos to deigma
% proerxetai apo katanomi poisson
%
%3. Sindiazontas to figure 2 kathos kai thn poly mikrh timh p, den
% mporoume na isxyristoume pos ta dedomena proerxontai apo katanomi poisson
%
%4. Oi apanthseis den simfonoun, efoson o mi parametrikos elegxos einai
% ligotero akribis gia dedomena pou prosarmozontai se katanomi
