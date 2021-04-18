clear

%***********************************************************************
%     Fundamental constants
%***********************************************************************

cc=2.99792458e8;            %speed of light in free space
muz=4.0*pi*1.0e-7;          %permeability of free space
epsz=1.0/(cc*cc*muz);       %permittivity of free space

freq=500e+6;                %center frequency of source excitation
lambda=cc/freq;             %center wavelength of source excitation
omega=2.0*pi*freq;          

%***********************************************************************
%     Grid parameters
%***********************************************************************

ie=100;                 %number of grid cells in x-direction
je=100;                 %number of grid cells in y-direction

ib=ie+1;
jb=je+1;

is=40;                  %location of source
js=je/2;                %location of source

ir=15;                  %location of field recording
jr=15;                  %location of field recording

dx=0.01;                %space increment of square lattice
dy=0.01;
dt=0.99*dx/(sqrt(2.0)*cc);    %time step

nmax=10000;              %total number of time steps

%***********************************************************************
%     Material parameters
%     This is used for adding a lossy material in the cavity
%***********************************************************************

media=2;

%The first element corresponds to media 1 and the second to media 2:
eps=[1.0 1.0];         %relative electric permittivity
sig=[0.0 1.0e+7];      %electric conductivity (S/m)
mur=[1.0 1.0];         %relative permeability
sim=[0.0 0.0];         %equivalent magnetic loss (Ù/m)

%***********************************************************************
%     Wave excitation
%***********************************************************************

rtau=500.0e-9;
tau=rtau/dt;
delay=3*tau;

source=zeros(1,nmax);
for n=1:7.0*tau
  source(n)=sin(omega*(n-delay)*dt)*exp(-((n-delay)^2/tau^2));
end

%***********************************************************************
%     Field arrays
%***********************************************************************

ex=zeros(ie,jb);           %fields in main grid 
ey=zeros(ib,je);
hz=zeros(ie,je);
erec=zeros(1,nmax);

%***********************************************************************
%     Updating coefficients
%***********************************************************************

for i=1:media
  eaf  =dt*sig(i)/(2.0*epsz*eps(i));
  ca(i)=(1.0-eaf)/(1.0+eaf);
  cb(i)=dt/epsz/eps(i)/dx/(1.0+eaf);
  haf  =dt*sim(i)/(2.0*muz*mur(i));
  da(i)=(1.0-haf)/(1.0+haf);
  db(i)=dt/muz/mur(i)/dx/(1.0+haf);
end

%***********************************************************************
%     Geometry specification (main grid)
%***********************************************************************

%     Initialize entire main grid to free space

caex(1:ie,1:jb)=ca(1);     
cbex(1:ie,1:jb)=cb(1);

caey(1:ib,1:je)=ca(1);
cbey(1:ib,1:je)=cb(1);

dahz(1:ie,1:je)=da(1);
dbhz(1:ie,1:je)=db(1);

%     Add cylinder made of medium 2

% diam=20;          % diameter of cylinder
% rad=diam/2.0;     % radius of cylinder
% icenter=4*ie/5;   % i-coordinate of cylinder's center
% jcenter=je/2;     % j-coordinate of cylinder's center
% 
% for i=1:ie
% for j=1:je
%   dist2=(i+0.5-icenter)^2 + (j-jcenter)^2;
%   if dist2 <= rad^2 
%      caex(i,j)=ca(2);
%      cbex(i,j)=cb(2);
%   end
%   dist2=(i-icenter)^2 + (j+0.5-jcenter)^2;
%   if dist2 <= rad^2 
%      caey(i,j)=ca(2);
%      cbey(i,j)=cb(2);
%   end
% end
% end

%***********************************************************************
%     BEGIN TIME-STEPPING LOOP
%***********************************************************************

for n=1:nmax

%***********************************************************************
%     Update electric fields (EX and EY) in main grid
%***********************************************************************

ex(:,2:je)=caex(:,2:je).*ex(:,2:je)+...
           cbex(:,2:je).*(hz(:,2:je)-hz(:,1:je-1));

ey(2:ie,:)=caey(2:ie,:).*ey(2:ie,:)+...
           cbey(2:ie,:).*(hz(1:ie-1,:)-hz(2:ie,:));
           
ey(is,2:je) = ey(is,2:je) + source(n)/dy;

field_recording(n) = ey(ir,jr);

%***********************************************************************
%     Update magnetic fields (HZ) in main grid
%***********************************************************************

hz(1:ie,1:je)=dahz(1:ie,1:je).*hz(1:ie,1:je)+... 
              dbhz(1:ie,1:je).*(ex(1:ie,2:jb)-ex(1:ie,1:je)+...
                                ey(1:ie,1:je)-ey(2:ib,1:je));

%***********************************************************************
%     Visualize fields
%***********************************************************************

% if mod(n,250)==0; %visualize every 250 time steps
% 
% timestep=int2str(n);
% 
% subplot(1,3,1),pcolor(ex'); drawnow;
% shading flat;
% axis([1 ie 1 jb]);
% axis image;
% axis off;
% title(['Ex at time step = ',timestep]);
% 
% subplot(1,3,2),pcolor(ey'); drawnow;
% shading flat;
% axis([1 ib 1 je]);
% axis image;
% axis off;
% title(['Ey at time step = ',timestep]);
% 
% subplot(1,3,3),pcolor(hz'); drawnow;
% shading flat;
% axis([1 ie 1 je]);
% axis image;
% axis off;
% title(['Hz at time step = ',timestep]);
% 
% end;

%***********************************************************************
%     END TIME-STEPPING LOOP
%***********************************************************************

end

Y = fft(field_recording);
Fs = 1/dt;
L = nmax;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure;
plot(f, P1);
xlim([0,1*10e8]);
xlabel('Frequency, f, [Hz]');
title({'Fourier Spectrum of Sampled Electric Field in',...
    'PEC Bound Cavity Excited by TEz wave + Source'});
grid on;