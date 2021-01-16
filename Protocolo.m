function [Contador, Tiempo] = Protocolo(NR,Ventana,NumeroTramas)
Contador=zeros(1,4);
Contador(1)=NumeroTramas;
index=Ventana+1;
Tiempo=zeros(1,NumeroTramas);
time=1;
Bandera=0;
Errores=0;
Bandera1=0;
Bandera2=0;
Tramas=1:NumeroTramas;
for i=1:Ventana
    fprintf('Transmitiendo trama %d\n',Tramas(i));
end
while Bandera==0
    tic
    Dado=rand(1);
    if Dado>NR
        fprintf('ACK recibido de la trama %d \n',Tramas(index-Ventana));
    else
        fprintf('Error al recibir ACK  en trama %d\n',Tramas(index-Ventana));
        Errores=Errores+1;
        Contador(2)=Contador(2)+1;
        for i=NumeroTramas+Errores:-1:index+1
            Tramas(i)=Tramas(i-1);
        end
        Tramas(index)=Tramas(index-Ventana);
        Contador(3)=Contador(3)+1;
    end
    fprintf('Transmitiendo trama %d\n',Tramas(index));
    if Tramas(index)==NumeroTramas
        Bandera=1;
    end
    index=index+1;
    Tiempo(time)=toc;
    time=time+1;
end
%Se transmiten por separado las ultimas tramas contenidas en la ventana
k=index-Ventana;
while Bandera2==0
    tic
    Dado=rand(1);
    if Bandera1==1
        fprintf('Trama %d transmitida\n',Tramas(k));
        Contador(3)=Contador(3)+1;
        Bandera1=0;
    end
    if Dado>NR
        fprintf('Recibido ACK de trama %d\n',Tramas(k));
        k=k+1;
    else
        fprintf('Error al recibir ACK de la trama %d\n',Tramas(k));
        Contador(2)=Contador(2)+1;
        Bandera1=1;
    end
    if k==NumeroTramas+Errores+1
        Bandera2=1;
    end
    Tiempo(time)=toc;
    time=time+1;
end
Contador(4)=Contador(1)-Contador(2);
end








