 L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', pi/2);
L2 = Link('revolute', 'd', 0, 'a', 1, 'alpha', 0 );  
L3 = Link('revolute', 'd', 0, 'a', 1, 'alpha', 0  );  
L4 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0);
L5 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0 );  
L6 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0);  




T1 = transl(0.170, 0.022, -1.358) * rpy2tr(0, 0, 0, 'deg');
T2 = transl(0.799, -0.746, -1.504) * rpy2tr(0, 0, 0, 'deg');
T3 = transl(-1.093, -0.000, -1.504) * rpy2tr(0, 0, 0, 'deg');


q1 = ik_thisa(T1)
q2 = ik_thisa(T2)
q3 = ik_thisa(T3)
tg = jtraj(q1, q3, 250);
tg1 = jtraj(q3, q1, 250);



L=2; W = 1;
plotopt = {'noraise', 'nobase', 'noshadow', 'nowrist', 'nojaxes', 'delay', 0};
r(1) = SerialLink([L1 L2 L3 L4 L5 L6],'name', 'leg1');
r(2) = SerialLink([L1 L2 L3 L4 L5 L6],'name', 'leg2', 'base',transl(-L, 0, 0));
r(3) = SerialLink([L1 L2 L3 L4 L5 L6],'name', 'leg3', 'base',transl(-L, -W, 0));
r(4) = SerialLink([L1 L2 L3 L4 L5 L6],'name', 'leg4', 'base',transl(0, -W, 0));


hold on
patch([0 -L -L 0], [0 0 -W -W], [0 0 0 0], ...
    'FaceColor', 'r', 'FaceAlpha', 0.5)

for i=1:4
   r(i).plot(tg(1,:),plotopt{:});
   
 
  
end 

hold off 

k = 1;
for i=1:250
   r(2).animate( gait(tg, k, 0, 0));
   r(4).animate( gait(tg, k, 0, 1));
   
    drawnow
    k = k+1;
    
end

hold on 

m = 1;
while m<2

k = 1;
for i=1:250
   r(1).animate( gait(tg, k, 0, 0));
   r(2).animate( gait(tg1, k, 0, 0)); 
   r(3).animate( gait(tg, k, 0, 1));
   r(4).animate( gait(tg1, k, 0, 1));
   
    drawnow
    k = k+1;
    
end

hold on 

k = 1;
for i=1:250
   r(1).animate( gait(tg1, k, 0, 0));
   r(2).animate( gait(tg, k, 0, 0));
   r(3).animate( gait(tg1, k, 0, 1));
   r(4).animate( gait(tg, k, 0, 1));
   
    drawnow
    k = k+1;
    
end
m=m+1;
end

figure;
plot(tg)
figure;
plot(tg1)








