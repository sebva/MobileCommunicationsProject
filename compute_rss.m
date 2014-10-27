function[rss]=compute_rss(dist, noise, alpha, P_0, d_0)
%
%Computes the received signal strength from the path loss model
%for 4 signals transmitted from the source node to the anchor nodes
%for a radio signal travelling from a source node to four anchor nodes
%dist: vector containing distances from source to 4 anchors
%noise: vector of normally distributed random variables that models the shadowing phenomenon
%alpha: path loss exponent 
%P_0: reference power at reference distance d_0
%d_0: reference distance
%
for i=1:4;
	rss(i) = P_0 - (10*alpha*log10(dist(i)/d_0)) + noise(i);
end;