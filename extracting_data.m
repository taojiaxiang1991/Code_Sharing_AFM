function [xL, yL, coeff] = extracting_data (Data,r,rd, d_min, o)
% From Dr Jim Tao hyung
% good to make sure at strain = 1, stress = 0, so beginning fit is better

% r is the uncompressed cell height (cell radius) about 8 micrometer
% rd is the prob radius, 1000 pm
% o is order

% Normalizing data in H/D, and pN/nm^2
d = Data(:,1).*10^9; F = Data(:,2).*10^12; % in nm and pN
d = (r-d)./r; F = F./(pi*rd^2); % in H/D, and pN/nm^2 (strain, pressure)

% setting range for pressure
F = F(d>=d_min); d = d(d>=d_min);
F = F(d<=1); d = d(d<=1);

coeff = polyfit(d,log(F),o);
xL = linspace(min(d),1,1000);
for i = 1:length(xL)
    for j = 1:length(coeff)
        ak(j) = coeff(j)*xL(i)^(length(coeff)-j);
    end
    yL(i) = exp(sum(ak));
end

% saving minimum yL (for constant)
coeff(length(coeff) + 1) = min(yL);

%setting yL(1) = 0
yL = yL - min(yL);

% plotting
%plot(d,F,'.b',xL,yL,'r-');
%legend('data','fit')
%xlabel('^{H}/_{D}');
%ylabel('^{pN}/_{nm^2}')

