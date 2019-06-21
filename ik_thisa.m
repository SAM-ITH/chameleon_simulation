function q = thisa_ik (K)

% DH 
a1=0;           % [m]
a2=1;         % [m]
a3=1;         % [m]
d6=0;           % [m]
alfa1=pi/2;     % [rad]
alfa2=0;        % [rad]
alfa3=0;        % [rad]

% dk=[n s a p; 0 0 0 1] 

dk=K;          %Homogrnous Transformation Mat. of end-effector
n=dk(1:3,1);
s=dk(1:3,2);
a=dk(1:3,3);
R=[n s a];
dk=K;          

% Inverse Kinematic
p_ot=dk(1:3,4);
pw=p_ot-d6*a;  
pw_x=dk(1,4);   
pw_y=dk(2,4);
pw_z=dk(3,4);

c3=(pw_x^2+pw_y^2+pw_z^2-a2^2-a3^2)/(2*a2*a3);  % cos(teta3)
s3=-sqrt(1-c3^2);        % sin(teta3)
teta3=atan2(s3,c3);

c2=(sqrt(pw_x^2+pw_y^2)*(a2+a3*c3)+pw_z*a3*s3)/(a2^2+a3^2+2*a2*a3*c3);      % cos(teta2)
s2=(pw_z*(a2+a3*c3)-sqrt(pw_x^2+pw_y^2)*a3*s3)/(a2^2+a3^2+2*a2*a3*c3);      % sin(teta2)
teta2=atan2((a2+a3*c3)*pw_z-a3*s3*sqrt(pw_x^2+pw_y^2),(a2+a3*c3)*sqrt(pw_x^2+pw_y^2)+a3*s3*pw_z);

teta1=atan2(pw_y,pw_x);

R3_0=[cos(teta1)*cos(teta2+teta3) -cos(teta1)*sin(teta2+teta3) sin(teta1);      
    sin(teta1)*cos(teta2+teta3) -sin(teta1)*sin(teta2+teta3) -cos(teta1);
    sin(teta2+teta3) cos(teta2+teta3) 0];

R6_3=R3_0'*R;        % Matrix for the Euler's angle of spherical wrist


teta4=atan2(R6_3(2,3),R6_3(1,3));
teta5=atan2(sqrt((R6_3(1,3))^2+(R6_3(2,3))^2),R6_3(3,3));
teta6=atan2(R6_3(3,2),R6_3(3,1));

q=[teta1 teta2 teta3 teta4 teta5 teta6]';      % Solutions in radiant