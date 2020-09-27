tic
clear all;

% Initial states
x = [20;120;3;2;5;3];

% Output matrix
C=eye(6);

% Designer tuning parameter Q
Q = [10 0 0 0 0 0;
     0 1000 0 0 0 0;
     0 0 100 0 0 0;
     0 0 0 1 0 0;
     0 0 0 0 10 0;
     0 0 0 0 0 1000];
 
% Designer tuning parameter R
R = [0.1 0 0;
    0 5 0;
    0 0 0.01];

Ptf = 0.25*eye(6)
% % Ptf=[1.2535 0.5609 0.0087 0.5657 0.0015 0.0018;
%     0.2687 0.1038 0.0133 0.0015 0.5587 0.2;
%     0 0 0 0 0 0;
%     15.8572 0.9702 0.5783 0.0111 0.0008 0.003;
%     0 0 0 0 0 0;
%     0 0 0 0 0 0];


% tf = 10;
% Initial time
t = 0;
h=1;

% time increment
delta = 0.001;

% Initial wind velocity
v=7;
Ztf = [5;3;1;1;1;1];
gtf=C'*Ptf*Ztf;

% Initial Input 
u = [0;0;];

% Final time
tf = 25;

% Tip speed ratio of the turbine
lamda = 8.1;



while (t<=tf)      
    
      v1(h) = v;
      
      % Turbine Parameters
      R1 = 2.5;
      jr = 2.88;
      rho = 1.25;
      R1 = 2.5;
      cp_1 =0.4;
      eta = 1;
      jg = 0.22;
      p=3;
      fm = 0.4382;
      bg = 0.3;
      i=6;
      kg = 75;
      
      a1 = 0.5109; a2 = 116; a3 = 0.4; a4 = 5; a5 = 21;
      a6 = 0.0068; a7 = 0.08; a8 = 0.035;
      
      desired2(h) = (8.1*v*6)/R1;
      desired1(h) = desired2(h)/6;
      lamda(h) = x(1)*R1/v;
      nn = lamda(h);
            
      beta1 = 0;    
      lamda_bar_1 = 1/(1/(nn+a7*beta1)-a8/(beta1^3+1));
      cp_1 = a1*(a2/lamda_bar_1-a3*beta1-a4)*exp(-a5/lamda_bar_1)+a6*nn;
      cp_2(h)=cp_1;
         
      h_start=h;
    
      l1_SDRE(h) = x(1);
      l2_SDRE(h) = x(2);
      l3_SDRE(h) = x(3);
      l4_SDRE(h) = x(4);
      l5_SDRE(h) = x(5);
      l6_SDRE(h) = x(6);
      h;
       
      l = [l1_SDRE(h);l2_SDRE(h);l3_SDRE(h);l4_SDRE(h);l5_SDRE(h);l6_SDRE(h)];
   
%     z(q)=t1;
      z1(h) = t;
       

      % elements of A matrix 

      %A11 = (2*v^3)/((x(1))^2);
      A11 = ((1/(2*jr))*(pi*rho*R1^2*cp_1*v^3)/((x(1))^2));
      A12 = 0;
      %A13 = -2.0833;
      A13 = -i/(eta*jr);
      A14 = 0;
      A15 = 0;
      A16 = 0;

      A21 = 0;
      A22 = 0;
      %A23 = 4.5454;
      A23 = (1/jg);
      A24 = 0;
      A25 = 0;
      %A26 = -5.9754;
      A26 = -(1.5/jg)*p*fm;
       

      %A31 = 450+((3.60*v^3)/((x(1))^2));
      A31 = 450 + (((i*bg)/(2*jr))*((pi*rho*R1^2*cp_1*v^3)/((x(1))^2)));
      A32 = -kg;
      A33 = -bg*(1/jg + (i^2)/(eta*jr));
      A34 = 0;
      A35 = 0;
      %A36 = 1.79;
      A36 = (bg*1.5/jg)*p*fm;
       
      A41 = 0;
      A42 = 0;
      A43 = 0;
      A44 = -0.25;
      A45 = 0;
      A46 = 0;

      A51 = 0;
      A52 = 3*x(6);
      A53 = 0;
      A54 = 0;
      A55 = -79.4033;
      A56 = 0;

      A61 = 0;
      A62 = -72.1848*(0.04156*x(5)-0.4382);
      A63 = 0;
      A64 = 0;
      A65 = 0; 
      A66 = -79.4033;

     
      % elements of matrix B 

%     B11 = 10.65*a0*v;
      B12 = 0;
      B13 = 0;
      B14 = 0;

%     B21 = 0;
      B22 = 0;
      B23 = 0;
      B24 = 0;

%     B31 = 19.17*(a0*v);
      B32 = 0;
      B33 = 0;
      B34 = 0;

%     B41 = 0;
      B42 = 0;
      B43 = 0;
      B44 = 0.25;

%     B51 = 0;
      B52 = -24.0616;
      B53 = 0;
      B54 = 0;
       
%     B61 = 0;
      B62 = 0;
      B63 = -24.0616;
      B64 = 0;

      A = [A11 A12 A13 A14 A15 A16;
          A21 A22 A23 A24 A25 A26;
          A31 A32 A33 A34 A35 A36;
          A41 A42 A43 A44 A45 A46;
          A51 A52 A53 A54 A55 A56;
          A61 A62 A63 A64 A65 A66];

      B = [B12 B13 B14;
           B22 B23 B24;
           B32 B33 B34;
           B42 B43 B44;
           B52 B53 B54;
           B62 B63 B64];
    
     
      Pss = -care(-A,B,Q,R);
      Ktf = inv(Ptf-Pss);
      E= B*inv(R)*B';
      Acl = A - E*Pss;
      D = lyap(Acl,-E);

        
      z = [desired1(h);desired2(h);0;0;0;0];
      m1(h)=z(1);
%     m2(h)=z(2);
      m4(h)=z(4);
      KK = expm(Acl*(t-tf))*(Ktf-D)*expm(Acl'*(t-tf)) +D;
      Pe = inv(KK) + Pss;
      gss = -inv(A - B*(inv(R))*B'*Pe)'*C'*Q*z;
      AA = A - B*inv(R)*B'*Pe;
      BB = B*inv(R)*B';
      Kg = expm((A-AA)'*(t-tf))*(gtf-gss);
      ge =   gss + Kg;
      xdot = AA*x + BB*ge;
      control_u = -inv(R)*B'*(Pe*x - ge);  
      c1(h) = control_u(1);
      c2(h) = control_u(2);
      c3(h) = control_u(3);
%     c4(h) = control_u(4);
      state1(h)=x(1);
      state2(h)=x(2);
      state4(h)=x(4);
%     state4(h)=x(4);
      ll=control_u(3)


      error1(h) = desired1(h) - state1(h);
%     error4(h) = desired2(h) - state2(h);
      x =x+delta *xdot
      u
 
        
% run set        
      h=h+1
      t = t + delta;

      if t<=4;
         v = 7;
      elseif t<=8;
         v = 8;
      elseif t<=12;
         v=9;
      elseif t<=16;
         v=8;
      elseif t<=20;
         v=7;
      end
      v1(h) = v; 
 end

% figure,plot(z1,lamda)
% legend('lamda')
% 
% figure,plot(z1,Tg)
% legend('Gen Torque')
% figure,plot(z1,cp_1)
% legend('power coefficient')
% figure,plot(z1,state1,z1,m1,'r-.','LineWidth',3);
% legend('actual','desired')
% % figure,plot(z1,state2,z1,m2,'r-.','LineWidth',3);
% % legend('actual','desired')
% figure,plot(z1,state4,z1,m4,'r-.','LineWidth',3);
% legend('actual','desired')
% figure,plot(z1,error1)
% legend('error signal')
% figure,plot(z1,c1,'g',z1,c2,'b',z1,c3,'y','LineWidth',3);
% legend('ud','uq','\beta_d','0')


figure,plot(z1(1:20000),v1(1:20000),'LineWidth',3)
grid on;
legend('Wind speed profile')
axis ([0 20 4 10])
ylabel('Wind speed(m/s)')
xlabel('Time(sec)')
%figure,plot(z1(1:20000),Tg(1:20000),'LineWidth',3)
%legend('Gen Torque')
figure,plot(z1(1:20000),lamda(1:20000),'LineWidth',3)
% legend('lamda')
axis ([0 20 0 10])
xlabel('Time(sec)')
ylabel('Tip speed ratio')
figure,plot(z1(1:20000),cp_2(1:20000),'LineWidth',3)
legend('power coefficient')
axis ([0 20 0.2 0.6])
xlabel('Time(sec)')
ylabel('Power coefficient')
figure,plot(z1(1:20000),state1(1:20000),z1(1:20000),m1(1:20000),'r-.','LineWidth',3);
legend('actual speed','refernce speed')
axis ([0 20 15 35])
xlabel('Time(sec)')
ylabel('Wind rotor speed(rad/sec)')
figure,plot(z1(1:20000),state4(1:20000),z1(1:20000),m4(1:20000),'r-.','LineWidth',3);
legend('actual','desired')
axis ([0 20 -3 3])
xlabel('Time(sec)')
ylabel('Pitch angle(deg)')
figure,plot(z1(1:20000),error1(1:20000),'LineWidth',3)
legend('error signal')
axis ([0 20 -15 15])
xlabel('Time(sec)')
ylabel('Tracking error(rad/sec)')
figure,plot(z1(1:20000),c1(1:20000),'r',z1(1:20000),c2(1:20000),'b',z1(1:20000),c3(1:20000),'g','LineWidth',3);
legend('ud (volts)','uq (volts)','\beta_d (deg)','0')
axis ([0 20 -400 700])
xlabel('Time(sec)')
ylabel('Optimal inputs')
axes('Position',[0.7 0.7 0.2 0.2])
box on;
plot(z1(7.80:0.01:9.0),c1(50:2:290));
axis tight
