function [out] = dynamics(t, x, flag)
% Input: x = [pos, vel]
%        
global flowdata
    %Default flag behavior
    if nargin < 3
        flag = 's'; 
    end

    switch flag
        case{'s','u','b','L','H','Z','W'}    %This case statement used to make more sense when there were more flags
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate the dynamics 's'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            dim = flowdata.Parameters.dim;
            params = cell2mat(flowdata.Parameters.Biped.values);
            
            if any(isnan(x))
                warning('Got some nans in the input')
            end
            q = x(1:dim/2);         %position
            qdot = x(dim/2+1:dim);  %velocity
          
            %Contact constraints 
            [A,Adot] = flowdata.getConstraintMtxs(x,params);

            %Dynamics matrices
%             M = M_func(x);
%             C = C_func(x);
%             G = G_func(x);           
            
            M = M_func(x,params);
            C = C_func(x,params);
            G = G_func(x,params); 
            
            %Control Functions
            u = zeros(dim/2,1);
            u_array = zeros(length(flowdata.Controls.Internal)+length(flowdata.Controls.External),1,dim/2);
            for i = 1:length(flowdata.Controls.Internal)
                temp = flowdata.Controls.Internal{i}(x);
                u_array(i,:,:) = temp';
                u = u + temp;
                if any(isnan(temp)) || any(isinf(temp))
                    warning('Bad control')
                end
            end

            u_ext = zeros(dim/2,1);
            for i = 1:length(flowdata.Controls.External)
                temp = flowdata.Controls.External{i}(x);
                u_array(i+length(flowdata.Controls.Internal),:,:) = temp';
                u_ext = u_ext + temp;
                if any(isnan(temp)) || any(isinf(temp))
                    warning('Bad control')
                end
            end          
            
            %Constraint Multipliers and Joint accelerations
            if (rank(A) == min(size(A))) && (rank(A)<dim/2) && ~isempty(A)
                Lambda = ((A/M)*A')\((A/M)*(u + u_ext - C*qdot - G) + Adot*qdot);
            elseif isempty(A)
                warning("Biped is a projectile")
                A = 0;
                Lambda = 0;
            else
                warning("Biped is possibly over constrained")
                Lambda = zeros(min(size(A)),1);
            end
            accel = M\( -C*qdot -G - A'*Lambda + u + u_ext);
            
            if any(isnan(accel))
                warning('Got some nans in the dynamics')
            end
            
            %set velocity, acceleration outputs
            out(1:dim/2) = qdot;
            out(dim/2+1:dim) = accel;        
            out = out';

            %set external Power input
            out(dim+1) = qdot' * u_ext;
     
            %Output torques
            if flag == 'u'
                out = u;
            end
            
            if flag == 'W'
                out = out(dim+1);
                return;
            end
            
            if flag == 'Z'
                out = u_array;
                return
            end
            
            %Momentum dot
            if flag == 'H'
                out = (C'+C)*qdot -C*qdot - G -A'*Lambda + u;
            end
            
            %Constraint forces
            if flag == 'L'
                out=-Lambda; 
            end       
            out = out(:); %ensure column vector output
        otherwise
            disp('invalid flag')
    end

end