%% This code plots a surface and it's contour for a given equation with three variables

% Use to show use of Publish code, breakpoint, 


% clear all
close all

% [X,Y] = meshgrid(-3:.2:2);
% Z = X .* exp(-X.^2 - Y.^2);
% surf(X,Y,Z)
% figure
% contour3(X,Y,Z)

x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)
grid on


%% User-defined functions

% a = 2;
% b = 3;
% 
% [res1] = calculateSum(a,b)




%% looping eg

% Use to show use of auto-indent

conditionVariable = 2;

% if conditionVariable == 2
%     disp('2')
% else
%     disp('3')
% end

% while conditionVariable == 2        %braaces not required llike C
%     disp('2')                   % show how to stop infinite running program 
% end

sum = 2;

tic
for i = 1:10000
    sumUpdated = sum*i;
end
toc

tic 
i = 1:10000;
sumUpdated = sum*i;
toc    
%% Preallocation eg

% Use to show use of tic toc

% tic
% x = 0;
% for k = 2:1000000
%    x(k) = x(k-1) + 5;
% end
% toc

% tic
% x = zeros(1,1000000);
% for k = 2:1000000
%    x(k) = x(k-1) + 5;
% end
% toc



%% FFT

% fs = 1000;
% t = 0:1/fs:2*pi;
% f1 = 10;
% f2 = 20;
% y = cos(f1*t) + cos(f2*t);
% yFft = fft(y);
% yFftMag = abs(yFft);
% plot(yFftMag)

 

    
    
    
    
    
    
    
    
    
    
    
 