function[estimated_dist]=estimate_dist(rss, noise, alpha, P_0, d_0)

%estimate distances from the source to the anchor nodes using the lognomal path loss model
%rss: vector of RSS from 4 anchor nodes
%noise: noise values for 4 anchors
%alpha: path loss exponent
%P_0: reference power at reference distance (dB)
%d_0: reference distance (m)

for i = 1:4;
	estimated_dist[i] = ((P_0+n[i]-rss[i])/10*alpha)^10*d_0
end;