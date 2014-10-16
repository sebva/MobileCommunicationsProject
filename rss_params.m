%coordinates of the anchor nodes and the source
%the anchors form a rectange;
%the source is positioned within a rectangle
 
%x coordinates of anchors
a_x = [0, 0, 200, 200]
%y coordinates of anchors
a_y = [0, 200, 200, 0]
%x coordinate of source
s_x = 56
%y coordinate of target
s_y = 72

%dvector containing distances from source to anchors
for i = 1:4;
	dist[i] = sqr((s_x-a_x[i])^2+(s_y-a_y[i])^2)
end;

%normally distributed random variable that models the shadowing phenomenonin dB
mu=0;sigma=1;
noise = sigma *randn(1,4)+mu

%path loss exponent in dB
alpha = 3

%reference power at reference distance in dB
P_0 = 0

%reference distance in m
d_0 = 1