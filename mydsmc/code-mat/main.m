cca

variables

vy0 = zeros(Nsim,Nt);

fig=figure;
fig.Position=[215 388 821 478];

for sim = 1:Nsim
    disp(['Simulation ',num2str(sim),' of ',num2str(Nsim)])
    
    x = dz * rand(N,1);
    y = dz * rand(N,1);
    z = Lz * rand(N,1);
    
    sigma=chol(Tw);
    vx = randn(N,1)*sigma;
    vy = randn(N,1)*sigma;
    vz = randn(N,1)*sigma;
    
    vct=50;
    v = VideoWriter('~/projects/mydsmc/post/mydsmc','MPEG-4');
    v.FrameRate=15;
    open(v);

    for mi = 1:1000
        mi
        drift
        
        dspecular
        
        thermal
        
        collisions
        
        disp(['N_collisions: ',num2str(N_collisions)])
        
        x = mod(x,dz);
        y = mod(y,dz);
        vy0(sim,mi) = mean(vy( (0<z) & (z<dz)));
        
        subplot(1,2,1)
        
        sx=x(1:250:end);
        sy=y(1:250:end);
        sz=z(1:250:end);
        
        svy=vy(1:250:end)/max(abs(vy(1:250:end)));
        ssize=ones(size(sx))*50;
        scol=[1 0 0].*svy;
        
        scatter3(sx,sy,sz,ssize,scol,'filled')
        xlim([0 dz])
        ylim([0 dz])
        zlim([0 Lz*1.1])
        axis equal
        
        ax=gca;
        ax.View(1)=vct;
        vct=vct+.05;
        ax.XTick=[10 dz*.95];
        ax.YTick=[10 dz*.95];
        ax.ZTick=[50 Lz*.95];
        ax.XTickLabel=[];
        ax.YTickLabel=[];
        ax.ZTickLabel=[];
        %ylabel('Y direction')
        
        subplot(1,2,2)
        histogram(vy,100)
        xlim([-5 10])
        ylim([0 2500])
        hold on
        plot([0 0],[0 2500],'k--')
        hold off
        xlabel('Y Velocity of Particles')
        ylabel('Number of Particles')
        ax.FontSize=15;
        
        t1=text(-1.6691,-0.1074,'Credit: Philip Mocz: "Create Your Own Direct Simulation Monte Carlo (With Python)" ','units','normalized');

        drawnow
        %pause(0.01)
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
    
    close(v);
    
end