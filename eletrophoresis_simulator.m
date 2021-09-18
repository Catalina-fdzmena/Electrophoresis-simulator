% Andrea Catalina Fernández Mena A01197705    Programador 
% Thomas Freund Paternostro A00831997   Porgramador 
% Carlos Guardiola A01383966   Encargado parte física y mecanica
% William Frank Monroy Mamani A00829796  Programador auxiliar
% Cedric Diego Ortega Jiménez A01025012  Encargado parte física y mecanica


%variables definidas:
Ke= 8.99.*(10^9); %valor de Coulomb
radioDisp = .5;%radio del circulo
dY = 0; %Distancia en Y



%valores dados por el usuario:

%da la carga de las particulas, donde las positivas son iguales que 
%las negativas
Q=input("Escribe el valor de la carga: " );

lPos=input("Escribe la longitud del alambre positivo: " );
lNeg=input("Escribe la longitud del alambre negativo: " );



disp("Vamos a poner la coordenada de los dipolos: ")

%Si ponemos valores muy grandes no se va a mostrar correctamente ya que se
%saldria del meshgrid
xPos=input("Coordenada x de la carga positiva(+): " ); %pos de la carga positiva en x
yPos=input("Coordenada y de la carga positiva(+): " ); %pos de la carga positiva en y

%Distancia horizontal entre la carga positiva y negativa
dX= input("Cual es la distancia entre las dos cargas: " );

xNeg= xPos + dX; %pos de la carga - en x
yNeg= yPos + dY; %pos de la carga - en y

%Separacion de las cargas positivas y negativas
distanciaExPos =  lPos./ 100; %son 100 particulas por lo tanto se divide por lPos para encontrar la distancia
distanciaExNeg = lNeg./100; %son 100 particulas por lo tanto se divide por lNeg para encontrar la distancia

%Definimos los ejes de la figura al igual que los valores maximos y minimos de X e Y
if Q > 0 
    maxX = Q + (distanciaExPos .* 2) + 20;
    minX = - (distanciaExPos .* 2) - 20;
elseif Q < 0
    maxX = (distanciaExNeg.*2) + 20;
    minX = Q - (distanciaExNeg.*2) - 20;
end 
% maxY = QNegativaY + 10;
% minY = QNegativaY - 10;

%Definimos un meshgrid  

xPuntos = minX:0.5:maxX; %matriz punto x 
yPuntos = minX:0.5:maxX; %matriz punto y

%Creamos un meshpoint con el min y max dependiendo de la carga 
[XPunto, YPunto] = meshgrid(xPuntos,yPuntos); 



%Definimos dos variables que van a almacenar la suma de el campo electrico
%en x y y igual a 0 para empezar.
VecEx=0;
VecEy=0;

for i =-50:1:50
    % Campo electrico ejercido debido a una carga negativa
    Rxp = XPunto-xPos; %(x - x+)
    Ryp = YPunto- (yPos+ (i*distanciaExPos)); %Nos da la pos. en y que varia para vada punto con la distanciaExPos
    Rxn = XPunto- xNeg; %(x - x-)
    Ryn = YPunto- (yNeg + (i*distanciaExNeg));%Nos da la pos. en y que varia para vada punto con la distanciaExNeg
    %sumamos el campo electrico de la particula positiva y negativa en x
    VecEx = VecEx + ((Ke.*Q.*Rxp)./((Rxp.^2 + Ryp.^2).^(3/2))) - ((Ke.*Q.*Rxn)./((Rxn.^2 + Ryn.^2).^(3/2)));
    %sumamos el campo electrico de la particula positiva y negativa en x
    VecEy = VecEy + ((Ke.*Q.*Ryp)./((Rxp.^2 + Ryp.^2).^(3/2))) - ((Ke.*Q.*Ryn)./((Rxn.^2 + Ryn.^2).^(3/2)));
end


%Obtenemos los vectores del campo electrico dividindo por la magnitud del campo electrico al dividir 

E = (VecEx.^2 + VecEy.^2).^(1/2); %sacamos magnitud de la carga electrica total
Ex = (VecEx)./E; %obtenemos la magnitud apropiada en la x
Ey = (VecEy)./E; %obtenemos la magnitud apropiada en la y


%Creamos el campo vectorial
figure();
quiver(XPunto,YPunto,Ex,Ey)
title('Campo electrico de dos cargas lineales opuesuestas ')
axis equal;
box on


for i = -50:1:50
    posPos = [(xPos - radioDisp) ((yPos+ (i*distanciaExPos) - radioDisp)) 1 1]; 
    %Cículo rojo representa carga positiva 
    cirPos = rectangle('Position',posPos,'FaceColor',[1 0 0],'Curvature',[1 1]);
    set(cirPos);
    %text('Position',[xPos (yPos+ (i*distanciaExPos))],'string','+','FontSize', 15);
    posNeg = [(xNeg - radioDisp) ((yNeg + (i*distanciaExNeg) - radioDisp)) 1 1 ];
    %Cículo rojo representa carga negativa 
    cirNeg = rectangle('Position',posNeg,'FaceColor',[0 0 1],'Curvature',[1 1]);
    set(cirNeg)
    %text('Position',[xNeg (yNeg + (i*distanciaExNeg))],'string','-','Color','white','FontSize', 15)
end 
