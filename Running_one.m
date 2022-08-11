close all; clear,clc;
filename = 'AFM_strain_stress_data.xlsx';
Kp = []; K12 = []; K_Y = [];
%% Old Plastic round
for i = 1:5
    [m, ~] = stress_strain_plot(filename,'5dU_P1',i);
    Kp = [Kp,m]; clear m;
end
for i = 1:4
    [m, ~] = stress_strain_plot(filename,'5dU_P2',i);
    Kp = [Kp,m]; clear m;
end
for i = 1:3
    [m, ~] = stress_strain_plot(filename,'5dU_P3',i);
    Kp = [Kp,m]; clear m;
end

%% Trail round
for i= 1:4
    [m, ~] = stress_strain_plot(filename,'5dU_P4',i);
    Kp = [Kp,m]; clear m;
end
for i = 1:2
    [m, ~] = stress_strain_plot(filename,'5dU_P5',i);
    Kp = [Kp,m]; clear m;
end
for i= 1:5
    [m, ~] = stress_strain_plot(filename,'5dU_P6',i);
    Kp = [Kp,m]; clear m;
end
[m,~] = stress_strain_plot(filename,'5dU_P7',1);
Kp = [Kp,m]; clear m;
for i = 1:4
    [m, ~] = stress_strain_plot(filename,'5dU_P8',i);
    Kp = [Kp,m]; clear m;

end

%% Recent Plastic Round
for i = 1:7
    [m, ~] = stress_strain_plot(filename,'5dU_P9',i);
    Kp = [Kp,m]; clear m;
end

P_plastic = 10^6./Kp;

%% Old 12 KPa round
for i = 1:5
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa1',i);
    K12 = [K12,m]; clear m;
end
for i = 1:3
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa2',i);
    K12 = [K12,m]; clear m;
end
for i = 1:2
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa3',i);
    K12 = [K12,m]; clear m;
end

%% 12 KPa new round
for i = 1:7
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa4',i);
    K12 = [K12,m]; clear m;
end
for i = 1:5
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa5',i);
    K12 = [K12,m]; clear m;
end
for i = 1:4
    [m, ~] = stress_strain_plot(filename,'5dU_12KPa6',i);
    K12 = [K12,m]; clear m;
end
for i = 1:2
    [m,~] = stress_strain_plot(filename,'5dU_12KPa7',i);
    K12 = [K12,m]; clear m;
end



%% Ycompound
for i =1:7
    [K_Y(i), ~] = stress_strain_plot(filename,'2+3dY1',i);
end
for i = 1:6
    [m, ~] = stress_strain_plot(filename,'2+3dY2',i);
    K_Y = [K_Y,m]; clear m;
end
for i = 1:6
    [m, ~] = stress_strain_plot(filename,'2+3dY3',i);
    K_Y = [K_Y,m]; clear m;
end
for i = 1:5
    [m, ~] = stress_strain_plot(filename,'2+3dY4',i);
    K_Y = [K_Y,m]; clear m;
end

%% New round: july 29th, 2022

for i = 1:5
    [m,~] = stress_strain_plot(filename,'5dU_12KPa8',i);
    K12 = [K12,m]; clear m;
end
for i = 1:3
    [m,~] = stress_strain_plot(filename,'5dU_12KPa9',i);
    K12 = [K12,m]; clear m;
end
P_12KPa = 10^6./K12;

for i = 1:3
    [m,~] = stress_strain_plot(filename,'2+3dY5',i);
    K_Y = [K_Y,m]; clear m;
end
for i = 1:4
    [m,~] = stress_strain_plot(filename,'2+3dY6',i);
    K_Y = [K_Y,m]; clear m;
end
for i = 1:4
    [m,~] = stress_strain_plot(filename,'2+3dY7',i);
    K_Y = [K_Y,m]; clear m;
end
P_Y = 10^6./K_Y;


s.Plastic = P_plastic./mean(P_plastic); s.Soft = P_12KPa./mean(P_plastic); s.Ycompound = P_Y./mean(P_plastic);

violinplot(s);
errorbar(1,mean(P_plastic./mean(P_plastic)),std(P_plastic./mean(P_plastic)),'bd-');
errorbar(2,mean(P_12KPa./mean(P_plastic)),std(P_12KPa./mean(P_plastic)),'bd-');
errorbar(3,mean(P_Y./mean(P_plastic)),std(P_Y./mean(P_plastic)),'bd-');



