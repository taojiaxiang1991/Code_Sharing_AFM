clear,clc;
theta = linspace(0,pi/2,2000); r0 = 20*1000; Hl =[0.7:0.01:1];% [[0.7:0.005:0.9], [0.9005:0.005:1]];
P = 300*10^-4; T = r0/2*P;



Hksks = Hl.*r0;
for j = 1:length(Hl)
  
    H = Hksks(j);
    [r,lambda_force(j),V(j),Ak(j),f] = shape_estimate(r0,H,theta,P,T);
    rk(j,:) = r./r0;
    fk(j) = f(theta==pi/2);
    clear H r f
end
Force = P+lambda_force-2.*T./fk;
id1 = 1; id2 =find(Hl==0.9); id4 = length(Hl);
subplot(2,2,1); hold on;
plot(rk(id1,:).*cos(theta),rk(id1,:).*sin(theta),'b-',-rk(id1,:).*cos(theta),rk(id1,:).*sin(theta),'b-','linewidth',2);
plot(rk(id2,:).*cos(theta),rk(id2,:).*sin(theta),'r-',-rk(id2,:).*cos(theta),rk(id2,:).*sin(theta),'r-','linewidth',2);
%plot(rk(id3,:).*cos(theta),rk(id3,:).*sin(theta),'m-',-rk(id3,:).*cos(theta),rk(id3,:).*sin(theta),'m-','linewidth',2);
plot(rk(id4,:).*cos(theta),rk(id4,:).*sin(theta),'k-',-rk(id4,:).*cos(theta),rk(id4,:).*sin(theta),'k-','linewidth',2);
set(gca,'fontsize',14,'linewidth',2); xlim([-1.2 1.2]); ylim([0 2.4]);
subplot(2,2,2);hold on;  plot(Hl,lambda_force./P,'b-','linewidth',2);
set(gca,'fontsize',14,'linewidth',2); xlim([0.7 1]);

subplot(2,2,3); hold on; plot(Hl,Force./P,'b-','linewidth',2);set(gca,'fontsize',14,'linewidth',2); xlim([0.7 1]);

