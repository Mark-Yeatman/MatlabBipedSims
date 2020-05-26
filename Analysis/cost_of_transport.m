function COT = cost_of_transport(x,tau,t,mtotal,g,d)
    %COST_OF_TRANSPORT_P Compute cost of tranport of a step using power and average
    %walking velocity
    % x = system trajectories [pos;vel]' vector
    % tau = external forces and torques vector
    % t = time vector
    % mtotal = total biped mass
    % g = gravitational acceleration constant
    % d = COM travel distance over a step
    % from https://en.wikipedia.org/wiki/Cost_of_transport
    dim = length(x)/2;
    E = trapz(x(dim+1:end).*tau,t);
    COT = E/(mtotal*g*d)
end

