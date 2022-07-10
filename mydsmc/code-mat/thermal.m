hit_bot = z < 0;
dt_ac = z(hit_bot) / vz(hit_bot);
x(hit_bot) = x(hit_bot) - dt_ac * vx(hit_bot);
y(hit_bot) = y(hit_bot) - dt_ac * vy(hit_bot);
Nbot = sum(hit_bot);

vx(hit_bot) = sqrt(Tw) * randn(Nbot,1);
vy(hit_bot) = sqrt(Tw) * randn(Nbot,1) + uw;
vz(hit_bot) = sqrt(-2 * Tw *log(rand(Nbot,1)));

x(hit_bot) = x(hit_bot) + dt_ac * vx(hit_bot);
y(hit_bot) = y(hit_bot) + dt_ac * vy(hit_bot);
z(hit_bot) = dt_ac * vz(hit_bot);