v_rel_max = 6;
N_collisions = 0;

for j =1:Ncell
    in_cell = (j*dz < z) & (z < (j+1)*dz);
    Nc = sum(in_cell);
    x_c = x(in_cell);
    y_c = y(in_cell);
    z_c = z(in_cell);
    vx_c = vx(in_cell);
    vy_c = vy(in_cell);
    vz_c = vz(in_cell);
    
    M_cand = ceil(Nc^2 * pi * v_rel_max * Ne * dt/(2*vol));
    
    for k = 1:M_cand
        r_fac = rand();
        i_prop=randi(Nc);
        j_prop=randi(Nc);
        
        v_rel = sqrt((vx_c(i_prop)-vx_c(j_prop))^2 + (vy_c(i_prop)-vy_c(j_prop))^2 + (vz_c(i_prop)-vz_c(j_prop))^2);
        
        if v_rel > r_fac*v_rel_max
            
            vx_cm = 0.5 * (vx_c(i_prop) + vx_c(j_prop));
            vy_cm = 0.5 * (vy_c(i_prop) + vy_c(j_prop));
            vz_cm = 0.5 * (vz_c(i_prop) + vz_c(j_prop));
            
            cos_theta = 2 * rand() - 1;
            sin_theta = sqrt(1 - cos_theta^2);
            phi = 2 * pi * rand();
            
            vx_p = v_rel * sin_theta * cos(phi);
            vy_p = v_rel * sin_theta * sin(phi);
            vz_p = v_rel * cos_theta;
            
            vx_c(i_prop) = vx_cm + 0.5*vx_p;
            vy_c(i_prop) = vy_cm + 0.5*vy_p;
            vz_c(i_prop) = vz_cm + 0.5*vz_p;

            vx_c(j_prop) = vx_cm - 0.5*vx_p;
            vy_c(j_prop) = vy_cm - 0.5*vy_p;
            vz_c(j_prop) = vz_cm - 0.5*vz_p;
            
            N_collisions = N_collisions + 1;
        end
    end
    
    x(in_cell) = x_c;
    y(in_cell) = y_c;
    z(in_cell) = z_c;
    
    vx(in_cell) = vx_c;
    vy(in_cell) = vy_c;
    vz(in_cell) = vz_c;
end