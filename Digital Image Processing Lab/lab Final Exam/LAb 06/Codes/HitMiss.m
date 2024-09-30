 %% Section 1
a=[1 1 1 1 1 1 1 1 1 1;
1 1 1 1 1 1 1 1 1 1;
0 0 0 0 0 0 1 1 1 1;
0 0 0 0 0 1 0 1 1 1;
0 0 0 0 0 0 0 0 0 0;
0 0 0 1 1 0 1 1 1 1];

SE1=[0 1 0;
1 1 1;
0 1 0];

b=imerode(a,SE1);

 

%% Section 2
c=imcomplement(a);

SE2=SE1;

d=imerode (c,SE2);

 

%% final result
e=b & d; % b intersect d

 

subplot(3,3,1),imshow (a);title('a');subplot(3,3,2),imshow (SE1);title('SE1');subplot(3,3,3),imshow (b);title('b (imerode a and SE 1)');
subplot(3,3,4),imshow (c);title('c (complement of a)');subplot(3,3,5),imshow (SE2);title('SE2');subplot(3,3,6),imshow (d);title('d (imerode c and SE 2)');
subplot(3,3,7),imshow (e);title('intersect b and d');