
function [r,F,V,A,f]=calculation_shape(b2,r0,H,x,P,T)
dx = x(2)-x(1);
a1 = -2*b2; a2 = 2*b2; b1 = H-r0+a2;
r = r0+a1.*cos(x)+b1.*sin(x)+a2.*cos(2.*x)+b2.*sin(2.*x);
rp= -a1.*sin(x)+b1.*cos(x)-2.*a2.*sin(2.*x)+2.*b2.*cos(2.*x);rpp=-a1.*cos(x)-b1.*sin(x)-4.*a2.*cos(2.*x)-4.*b2.*sin(2.*x);
f = (2.*rp.^2+r.^2-r.*rpp)./(r.^2+rp.^2).^1.5+(1-((r0^3-r.^3)./r.^2)./r)./sqrt(r.^2+rp.^2); f= 2./f;
dVdR = (3.*r.^2.*(cos(x)).^3+2.*r.*rp.*(cos(x)).^2.*sin(x));
A = sum(r.*cos(x).*sqrt(r.^2+rp.^2).*dx);
V = sum((r.*cos(x)).^3+(r.*cos(x)).^2.*rp.*sin(x)).*pi.*dx;
F = ((P.*f-2*T)./dVdR); 