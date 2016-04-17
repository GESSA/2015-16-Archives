%% This code plots a surface and it's contour for a given equation with three variables

% Use to show use of Publish code, breakpoint, 

clc
% clear all
% close all


y = @(x)(x^2+3*x+2);
z = @(x)(x+3);

a = @(x)(y*z);


% t = 0:0.1:4*pi;
% y = sin(t);
% y2 = cos(t);
% y3 = tan(t);
% 
% plot(t,y)
% hold on
% plot(t,y2)
% hold on
% plot(t,y3)
% axis([0 4*pi -4 4])
% title('trigo functions')
% xlabel('time')
% ylabel('magnitude')
% legend('sin','cos','tan')
% grid on


% [X,Y] = meshgrid(-3:.2:2);
% Z = X .* exp(-X.^2 - Y.^2);
% surf(X,Y,Z)
% figure
% contour3(X,Y,Z)
% contour(Z)


%% User-defined functions
% 
% a = 2;
% b = 3;
% 
% [output1 output2] = calculateSum(a,b)



%% looping eg

% Use to show use of auto-indent

% conditionVariable = 2;

% if conditionVariable == 2
%     disp('2')
% else
%     disp('a')
%     disp('5')
% end

% while conditionVariable == 2        %braaces not required llike C
%     2;                  % show how to stop infinite running program 
% end

% sum = 2;

% tic
% for i = 1:1000000 
%     output = sum*i;
% end
% toc


% tic 
% 
% i = 1:1000000;
% output = sum*i;
% 
% toc    
%% Preallocation eg

% Use to show use of tic toc

% tic
% x = 0;
% for k = 2:1000000
%    x(k) = x(k-1) + 5;
% end
% toc
% 
% tic
% x = zeros(1,1000000);
% for k = 2:1000000
%    x(k) = x(k-1) + 5;
% end
% toc

% format long         %format short
% p = pi;
% a = 2;

%% FFT

% fs = 1000;
% t = 0:1/fs:2*pi;
% f1 = 10;
% f2 = 20;
% y = cos(f1*t) + cos(f2*t);
% yFft = fft(y);
% yFftMag = abs(yFft);
% plot(yFftMag)

 

    
    
    
    
    
    
    
    
    
    
    
 