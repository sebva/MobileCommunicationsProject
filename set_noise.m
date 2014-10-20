function[noise]=set_noise(mu, sigma, length)
%
%Generates white noise of secified length using 'randn' function,
%which produces random numbers that follow a Gaussian distribution
%A white noise signal (process) is constituted by a set of independent
%and identically distributed random variables.
%length: the length of the noise vector
%mu: mean
%sigma: deviation

noise = sigma*randn(1,length)+mu;
