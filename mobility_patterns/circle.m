function [ x, y, s ] = circle ( x0, y0, r, angle )
%Parameters: 
% initial x,y coordinate for generating the circle pattern
% (r)adius of the circle, angle in degrees
% Returns a matrix (2xn) with the coordinates (x,y) of the circle
% where row 1 has the x values, and row 2 the y values 
% s time interval

%Assuming that the center of the coordinates of the circle will be always
%in the first quadrant
xf=x0+(r*2);

%Computing the center of the circle
a = (xf+x0)/2;
b = y0;

x = zeros(1,10); %To avoid matlab becoming crazy
y = zeros(1,10);
x(1) = x0;
y(1) = y0;
j=2;

n=angle * pi / 180.;%Computes the arc length
s = n*r; %Interval 

%Draws the upsize of the circle (clockwise)
for i=pi-n:-n:0 %(i.e. from 0 to 180 degrees)
    x(j)=a+(r*cos(i));
    y(j)=b+(r*sin(i));
    j=j+1;
end;

%The next reference point 
x(j-1) = xf;
y(j-1) = y0;
 
%Draws the downsize part of the circle (clockwise)
for i=(pi*2)-n:-n:pi %(i.e. from 180 to 360 degrees)
     x(j)=a+(r*cos(i));
     y(j)=b+(r*sin(i));
     if x(j) < x0 || y(j) > y0 %Control in order to have consistent coordinates
        break;
     end;
     j=j+1;     
end;

%The last point should be the initial one 
x(j) = x0;
y(j) = y0;

