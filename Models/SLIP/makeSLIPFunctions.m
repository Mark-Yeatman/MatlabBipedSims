function makeSLIPFunctions()
% Turns the mathematica derivation of the robot dynamics into optimized executable matlab functions. 

    %Where to put the matlab functions
    mylocation = which(mfilename);
    [thisdir,~,~] = fileparts(mylocation);
    idcs   = strfind(thisdir,'\');
    configFolder = thisdir;%(1:idcs(end)-1);

    %Where to get the "mathematica" functions
    SymFuncsPath = (strcat(pwd,'\Derivations\ToMatlabOutputs\SLIP'));
    addpath(genpath(SymFuncsPath))

    syms m g k xf yf L0
    params_keys = {'m', 'g'};
    params_values = {m, g};
    temp = containers.Map(params_keys,params_values);
    temp = temp.values();
    biped_params = [temp{:}]; %gets the ordering right   
    
    params_keys = {'k', 'L0'};
    params_values = {k, L0};
    temp = containers.Map(params_keys,params_values);
    temp = temp.values();   
    spring_params = [temp{:}]; %gets the ordering right   
    
    x = sym('x',[4,1]);   
    
    s = [x;xf;yf];
    
    M_matrix
    C_matrix
    G_matrix
    Spring_Force
    
    folder = strcat(configFolder,'\SimulationFunctions\DynamicsFunctions\');
    status = mkdir(folder);
    matlabFunction(M,   'File',strcat(folder,'M_func'),'Vars',{x,biped_params})
    matlabFunction(sym(Cmat),'File',strcat(folder,'C_func'),'Vars',{x,biped_params})
    matlabFunction(G,   'File',strcat(folder,'G_func'),'Vars',{x,biped_params})
    matlabFunction(Fval,   'File',strcat(folder,'Spring_Force_func'),'Vars',{s,spring_params})
    
    Kinetic_energy
    Potential_energy
    Spring_energy
    
    folder = strcat(configFolder,'\SimulationFunctions\EnergyFunctions\');
    status = mkdir(folder);
    matlabFunction(ke,'File',strcat(folder,'KE_func'),'Vars',{x,biped_params})
    matlabFunction(Pe,'File',strcat(folder,'PE_func'),'Vars',{x,biped_params})
    matlabFunction(pespring,'File',strcat(folder,'PE_func'),'Vars',{s,spring_params})
    
    Spring_Length
    Spring_Velocity
    Spring_Jacobian
    
    folder = strcat(configFolder,'\SimulationFunctions\KinematicFunctions\');
    status = mkdir(folder);
    matlabFunction(l,  'File',strcat(folder,'Spring_Length_func'),'Vars',{s,spring_params})
    matlabFunction(ldot,  'File',strcat(folder,'Spring_Velocity_func'),'Vars',{s,spring_params})
    matlabFunction(jacob,'File',strcat(folder,'Spring_Jacobian_func'),'Vars',{s,spring_params})
     
end
