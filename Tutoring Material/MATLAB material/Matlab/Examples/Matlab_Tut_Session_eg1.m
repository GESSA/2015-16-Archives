clc;
clear all;
close all;


x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)



[X,Y] = meshgrid(-2:.2:2);
Z = X .* exp(-X.^2 - Y.^2);
surf(X,Y,Z)


t = 0:pi/10:2*pi;
[X,Y,Z] = cylinder(4*cos(t));
subplot(2,2,1); mesh(X); title('X');
subplot(2,2,2); mesh(Y); title('Y');
subplot(2,2,3); mesh(Z); title('Z');
subplot(2,2,4); mesh(X,Y,Z); title('X,Y,Z');



a = [1 2 3 4]
a = [1 2 3; 4 5 6; 7 8 10]
z = zeros(5,1)
a + 10
sin(a)
a'
p = a*inv(a)

format long
p = a*inv(a)

p = a.*a

a.^3

A = [a,a]

A = [a; a]

sqrt(-1)

c = [3+4i, 4+3j; -i, 10j]

A = [1 3 5];
max(A)

B = [10 6 4];
max(A,B)

maxA = max(A)
[maxA,location] = max(A)
disp('hello world')

A = magic(4)

A(4,2)
A(8)
A(4,5) = 17
A(1:3,2)
A(3,:)
B = 0:10:100

myText = 'Hello, world';
otherText = 'You''re right'
whos myText

longText = [myText,' - ',otherText]
f = 71;
c = (f-32)/1.8;
tempText = ['Temperature is ',num2str(c),'C']

t=0:.01:1

whos

y = sin(2*pi*t)

data=rand(5,5)

size(data)

b = a'
c = a*b
c = a.*b

inv(a)



