function [ x, y, s ] = square( )
%SQUARE Quick & dirty square pattern

    x = zeros(1, 200);
    y = zeros(1, 200);
    
    for i = 1:200;
        if i <= 50;
            x(i) = i * 20;
            y(i) = 20;
        elseif i <= 100;
            x(i) = 1000;
            y(i) = (i -100) * 20;
        elseif i <= 150;
            x(i) = 1000 - (i - 150) * 20;
            y(i) = 1000;
        elseif i <= 200
            x(i) = 20;
            y(i) = 1000 - (i - 200) * 20;
        end;
    end;
    
    s = 20;


end

