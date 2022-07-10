hit_top = z > Lz;
dt_ac = (z(hit_top) - Lz) / vz (hit_top);
vz(hit_top) = -vz(hit_top);
z(hit_top) = Lz + dt_ac * vz(hit_top);