function[filtered_coord] = apply_kf(estimated_coord, initial_state, T_s)

%Intialises the model parameters for the Kalman Filter from the initial
%state and the sampling interval;
%calls kf function on the specified state sequence;
%returns the list of coordinates from kf output.
%Input:
%estimated_coord: a nb_states-by-2 matrix returned by LLS or WLS
%intial_state: intial state estimate, needed to start the Kalman Filter
%it is either [0, 0, 0 , 0] or [0,0]
%T_s: sampling interval, or distance travelled between two states
%Output:
%filtered_coord: a nb_states-by-2 matrix with the estimated coordinates
%passed through the Kalman Filter


%Initialisations
 
nb_states = size(estimated_coord, 1);
state_size = size(initial_state, 2);
t_init = transpose(initial_state);
% only two or four value states are well-formed
% a two value state has the form: [x, y], where x and y are the coordinates
% of the mobile node; a four value state has the form [x, x', y, y'], where
% x and y are as in the two value state, and x' and y' are the speed values
% on the x and y axis, respectively
assert(state_size == 2 || state_size == 4);

p_noise = cell(nb_states);
for i = 1:nb_states;
   p_noise{i} = zeros(size(t_init));
end;

m_noise = cell(nb_states);
for i = 1:nb_states;
   m_noise{i} = zeros(size(estimated_coord, 2));
end;

%initialise transition matrix A and matrix H for the measurement model
if state_size == 2
    A = diag(1,1);
    H = diag(1,1);
    %TODO: not yet clear how to set the error covariance and the noise
    P_0 = null;
    p_noise = null;
    m_noise = zeros(nb_states, 2);
else
    A = [1 T_s 0 0; 0 1 0 0; 0 0 1 T_s; 0 0 0 1];
    H = [1 0 0 0; 0 0 1 0];
    %TODO: not yet clear how to set the error covariance and the noise
    P_0 = [5, 0, 0, 0; 0, 1, 0, 0; 0, 0, 5, 0; 0, 0, 0, 1]
    p_noise = null;
    m_noise = null;
end

%call kf on the initialised parameters
filtered_states = kf(estimated_coord, t_init, P_0, A, H, p_noise, m_noise);

%if needed parse filtered_states to produce the necessary output
if state_size == 2
   filtered_coord = filtered_states;
else
   filtered_coord = horzcat(filtered_states(:,1), filtered_states(:,3));
end