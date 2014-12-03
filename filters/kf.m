function[filtered_states] = kf(measured_states, X_0, P_0, A, H, p_noise, m_noise)
%kf applies kalman filter to a vector of coordinates of mobile node estimated by lls or wls
%Input:
%measured_states: the estimated coordinates of the mobile node in each state provided by LLS or WLS.
%A: transition matrix predicting the current state based on the previous one
%H: projection matrix relating the current state estimation to the
%corresponding  measured state
%X_0: initial state
%P_0: initial covariance matrix
%Output:
%filtered_states: improved estimated coordinates of the mobile node

%Initialisations:
nb_states = size(measured_states, 1);
Ht = transpose(H);
At = transpose(A);

%pre-allocate the output matrix of estimated states
filtered_states = zeros(nb_states, size(X_0,1));

%initialise matrix of covariance matrices for all states
P = cell(nb_states);
for i = 1:nb_states;
   P{i} = zeros(size(P_0));
end;

% intialise state update and covariance matrix update to the passed initial values
state_update = X_0;
P_update = P_0;


%Process Loop
%for each state perform time update and measurement update
for k=1:nb_states;
    %Time Update: project the state and the covariance matrix ahead
    if  k > 1
        state_update = A * transpose(filtered_states(k-1,1:end));
        %TODO: add process noise to P_update
        %P_update = A * P{k-1} * At + transpose(p_noise);
        P_update = A * P{k-1} * At;
    end
    %Measurement Update: update the state estimate and covariance by using
    %Kalman Gain
    
    %compute Kalman Gain for k
    KG = (P_update*Ht)/(H*P_update*Ht + transpose(m_noise));
    %update the estimate
    filtered_states(k, 1:end) = transpose(state_update + KG * (transpose(measured_states(k)) - (H * state_update)));
    %update error covariance
    P{k} = (P_0 - (KG * H)) * P_update;     
end;
    
