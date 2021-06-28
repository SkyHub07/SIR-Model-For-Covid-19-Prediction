function ode =ode(t,y)
b = 0.1425 ;%obtained beta value  
g = 0.01269  ;%obtained gamma value 
ode(1) =-b*y(1)*y(2);
ode(2) = b*y(1)*y(2)-g*y(2);
ode(3) = g*y(2);
ode = [ode(1) ode(2) ode(3)]';