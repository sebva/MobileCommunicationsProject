function[error]=compute_error(actual_coord,estimated_coord)

%compute the distance between the actual and estimated coordinates
%actual_coord: actual coordinates of source node A(n,2)
%estimated_coord: estimated coord of source node B(n,2)

assert(size(actual_coord, 1) == size(estimated_coord, 1));
num_results = size(actual_coord, 1);

for i=1:num_results;
    error(i) = eucl_dist(actual_coord(i, 1), actual_coord(i,2), estimated_coord(i,1), estimated_coord(i,2));
end;
    