MobileCommunicationsProject
===========================

Mobile communications Autumn 2014 - Project n°5

Team: Sébastien Vaucher, Sveta Krasikova, Danilo Burbano, Jose Luis Carrera

This is a MATLAB simulation for the RSS-based channel modelling localization and tracking.

General Setup:
4 anchor nodes (AN) and one mobile node (MN) with fixed coordinates.

Files:
rss_params.m contains parameters for estimating the RSS using the lognomal path loss model
compute_dist.m computes Euclidean distance btw MN and ANs
compute_rss.m computes rss from ANs to MN
estimate_dist.m estimates distances given the rss vector
set_noise.m creates an array of the given number of uniformly distributed random variables
lls.m estimates MN coordinates using the lls algorithm
lls_main_loop.m estimates MN coordinates 100 times

to be completed
