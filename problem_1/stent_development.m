clc; 
clear; 

L_vals=5:1:30;               %Lifetime of the stent
D_vals=10:1:50;              %Drug dosage
N_tot=1000;                    %MonteCarlo sample number

P = zeros(length(L_vals), length(D_vals));    %preassigning zeros matrix

for i = 1:length(L_vals)     %outer for loop with L values
    L = L_vals(i);           %counter 

    for j = 1:length(D_vals) %nested for loop with D values
        D = D_vals(j);       %setting second counter


        mu = 0.02 * L * D^2; %obtain mean from given avg eq
        sigma = 6;           %given s_dev from problem

        S=normrnd(mu, sigma, [N_tot, 1]); %create L,D pairs w avg and s_dev

        E=24*log(L*D^2)+0.18*L*D^2-9.5*(S+4); 
                             %given effectiveness equation 
        
        successes = sum(E >= 100);
                             %how many times the given pairs will equal 100
       
        P(i, j)= successes / N_tot;
                             %probability eq
    end
end

%matlab fxn call that creates 3D grid
[L_grid, D_grid] = meshgrid(L_vals, D_vals); 

%plotting 3D surface
figure()
surf(L_grid, D_grid, P');
shading interp;               %applies shading to graph      
colormap pink;                %for visual
colorbar;                     %legend for color 



