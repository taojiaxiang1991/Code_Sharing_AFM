%r0 = 9000; H = 0.7*r0; x = linspace(0,pi/2,200); P = 300*10^-6; T = r0/2*P;
function [r,lambda,V,A,f] = shape_estimate(r0,H,x,P,T)
dx = (x(2)-x(1)); V0 = sum(pi.*(r0.*cos(x)).^3.*dx);
b2 = 0; a1 = -2*b2; a2 = 2*b2; b1 = H-r0+a2;
r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);
V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
E = abs(V-V0)/V0; count = 2; B2 = b2;
while E(count-1)>0.005
    clear b2 a1 a2 b1 r rp V Eros
    b2 = B2(count-1)+H.*(2*rand-1);a1 = -2*b2; a2 = 2*b2;b1 = H-r0+a2;
    r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
    rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);
    V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
    Eros= abs(V-V0)/V0;
    if Eros<=E(count-1)
        B2(count) = b2; E(count)= Eros; count = count+1;
    end
end

b2 = B2(length(B2));a1 = -2*b2; a2 = 2*b2;b1 = H-r0+a2;
% r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
% rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);
% rpp=-a1.*cos(x)-b1.*sin(x)-4.*a2.*cos(2.*x)-4.*b2.*sin(2.*x);
% V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
% A = sum(r.*cos(x).*sqrt(r.^2+rp.^2).*dx);
% f = (2.*rp.^2+r.^2-r.*rpp)./(r.^2+rp.^2).^1.5+(1-((r0^3-r.^3)./r.^2)./r)./sqrt(r.^2+rp.^2); f= 2./f;
% dVdR = (3.*r.^2.*(cos(x)).^3+2.*r.*rp.*(cos(x)).^2.*sin(x));
% lam = (P.*f-2*T)./dVdR; lam = lam.*V./A; lam = lam(x<=0.6); fk = ((max(lam)-min(lam))/max(abs(lam)))^2;
% B1 = b1; fk = fk+abs(V-V0)/V0; count = 2; B2 = b2;
% while count<=6
%     clear b1 a1 a2 r rp rpp V A f dVdR lam fkl;
%     %if rand>0.5
%         b1 = B1(count-1)+r0*(2*rand-1); 
%     %else
%     %    b1 = B1(count-1); b2 = B2(count-1)+H*(2*rand-1);
%     %end
%     a2 = b1-H+r0; a1 = -a2;
%     r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
%     rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);
%     rpp=-a1.*cos(x)-b1.*sin(x)-4.*a2.*cos(2.*x)-4.*b2.*sin(2.*x);
%     V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
%     A = sum(r.*cos(x).*sqrt(r.^2+rp.^2).*dx);
%     f = (2.*rp.^2+r.^2-r.*rpp)./(r.^2+rp.^2).^1.5+(1-((r0^3-r.^3)./r.^2)./r)./sqrt(r.^2+rp.^2); f= 2./f;
%     dVdR = (3.*r.^2.*(cos(x)).^3+2.*r.*rp.*(cos(x)).^2.*sin(x));
%     lam = (P.*f-2*T)./dVdR; lam = lam.*V./A; lam = lam(x<=0.6); fkl =abs(V-V0)/V0+((max(lam)-min(lam))/max(abs(lam)))^2;
%     if fkl<=fk(count-1)
%         B1(count) = b1; fk(count) = fkl;count = count+1;
%     end
% end
% 
% 
% b1 = B1(length(B1));b2 = B2(length(B2));
% a2 = b1-H+r0; a1 = -a2;
r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);
rpp=-a1.*cos(x)-b1.*sin(x)-4.*a2.*cos(2.*x)-4.*b2.*sin(2.*x);
V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
A = sum(r.*cos(x).*sqrt(r.^2+rp.^2).*dx);
f = (2.*rp.^2+r.^2-r.*rpp)./(r.^2+rp.^2).^1.5+(1-((r0^3-r.^3)./r.^2)./r)./sqrt(r.^2+rp.^2); f= 2./f;
dVdR = (3.*r.^2.*(cos(x)).^3+2.*r.*rp.*(cos(x)).^2.*sin(x));
lam = (P.*f-2*T)./dVdR; lam = lam.*V./A;
id = find(x<=0.6);
lam = lam(id); x = x(id);
lambda = sum(lam.*dx)./max(x);
lambda = -lambda;


