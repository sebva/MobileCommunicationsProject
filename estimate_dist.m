function[estimated_dist]=estimate_dist(rss, noise, alpha, P_0, d_0)

%estimate distances from the source to the anchor nodes using the lognomal path loss model
%rss: vector of RSS from 4 anchor nodes
%noise: noise values for 4 anchors
%alpha: path loss exponent
%P_0: reference power at reference distance (dB)
%d_0: reference distance (m)

for i = 1:4;
	estimated_dist(i) = 10^((P_0+noise(i)-rss(i))/(10*alpha))*d_0;
end;