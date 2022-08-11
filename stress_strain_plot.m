%Taeki Kim
%plotting Force vs. displacement

% prob radius ~ 1 micrometer
% cell height ~ 8 micrometer

% D ~ meters
% F ~ N

% do in pico meter

% find Delta P time median

% Delta P * r / 2 = T
function [K_mean, K_median] = stress_strain_plot(filename,sheet,cellnkl);

%f1 = figure(1);f2 = figure(2);f3 = figure(3);

%% reading data
%filename = 'AFM Data_new.xlsx';
%sheet = '12 kPa';
%celln = input('enter cell number: ');
c = char('B' + (cellnkl - 1)*3);
if c == 'Z'
    range = [c,':','AA'];
elseif c > 'Z'
    c = char('A' + c - 'Z' - 1);
    range = ['A', c, ':', 'A',char(c+1)];
else
    range = [c, ':', char(c+1)];
end


data = xlsread(filename, sheet, range);
celln = data(1);

%trimming data
data([1:3],:) = [];

% getting theoritical curve
% Data_theory
load('Theory.mat')
%% fitting data and theory

% plot/fitting data
% cell height
r = 8000; % pm
% prob radius
rd = 1000; % pm
% order of magnitude for fitting purposes
o = 2;
d_range = 0.9;
%etc: a*exp(b*x)
% a = 1.7841e+12;
% b = -31.763;


%f1 = figure(1);
[xL, yL, coeff_data] = extracting_data(data, r, rd, d_range, o); %first order
%title('data and its fit')

% get coeff for theory
d_theory = Data_theory(:,1);
F_theory = Data_theory(:,2);
d_min = min(xL);
if d_min < d_range
    d_min = d_range;
end


F_theory = F_theory(d_theory >= d_min);
d_theory = d_theory(d_theory >= d_min);
F_theory = F_theory(d_theory < 1);
d_theory = d_theory(d_theory < 1);

coeff_theory = polyfit(d_theory, log(F_theory), o);
x = linspace(min(d_theory),1,1000);
for i = 1:length(x)
    for j = 1:length(coeff_theory)
        ak(j) = coeff_theory(j)*x(i)^(length(coeff_theory)-j);
    end
    y(i) = exp(sum(ak));
end

%f2 = figure(2);
%hold on
%plot(x,y)
%plot(d_theory,F_theory)
%legend('fit','theory')
%title('theory and fit')
%xlim([d_min,1])
%hold off
%finding constant K
a = coeff_theory(1) - coeff_data(1);
b = coeff_theory(2) - coeff_data(2);
c = coeff_theory(3) - coeff_data(3);
fun = @(x) (exp(a.*x.^2 + b.*x + c));
K_mean = real(mean(F_theory(d_theory >= d_min))/mean(yL));
K_median = real(median(F_theory(d_theory >= d_min))/median(yL));
%fun1 = @(x) a*exp(b*x) ./ exp(coeff_data(1)*x + coeff_data(2));
%f3 = figure(3);
%hold on
%title('data and theory')
%plot(xL,yL * K_mean,'g');
%plot(xL,yL * K_median,'b');
%plot(Data_theory(:,1),Data_theory(:,2), 'k');
%plot(x,y - min(y)) %fit theory
%xlim([d_min,1])
%legend('fit_{avg}','fit_{mean}','fit_{median}','theory');
%hold off

%disp("avg: " + K_avg)
%disp("mean: " + K_mean)
%disp("median: " + K_median)