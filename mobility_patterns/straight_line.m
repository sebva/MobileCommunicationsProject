function [ x, y, s ] = straight_line ( nb_locations )
%LINEAR Quick and dirty line mobility pattern

    x = zeros(1, nb_locations);
    y = zeros(1, nb_locations);
    
    for i = 1:nb_locations;
        x(i) = i * (1000 / nb_locations);
        y(i) = i * (1000 / nb_locations);
    end;
    
    s = sqrt(1000 / nb_locations);

end

