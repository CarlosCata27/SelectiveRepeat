function Contador = Protocolo(NR,Ventana,NumeroTramas)
Contador=zeros(1,4);
Bandera=0;
Bandera1=0;
Bandera2=0;
Tramas=1:NumeroTramas;
index=Ventana+1;
Contador(1)=NumeroTramas;
Errores=0;
for i=1:Ventana
    fprintf('Frame %d Transferred\n',Tramas(i));
end
while Bandera==0
    Dado=rand(1);
    if Dado>NR
        fprintf('PAK of frame %d received\n',Tramas(index-Ventana));
    else
        fprintf('NAK of frame %d received\n',Tramas(index-Ventana));
        Errores=Errores+1;
        Contador(2)=Contador(2)+1;
        for i=NumeroTramas+Errores:-1:index+1
            Tramas(i)=Tramas(i-1);
            Contador(3)=Contador(3)+1;
        end
        Tramas(index)=Tramas(index-Ventana);
    end
    fprintf('Frame %d Transferred\n',Tramas(index));
    if Tramas(index)==NumeroTramas
        Bandera=1;
    end
    index=index+1;
end
k=index-Ventana;
while Bandera2==0
    Dado=rand(1);
    if Bandera1==1
        fprintf('Frame %d Transmitted\n',Tramas(k));
        Bandera1=0;
    end
    if Dado>NR
        fprintf('PAK of frame %d received\n',Tramas(k));
        k=k+1;
    else
        fprintf('NAK of frame %d received\n',Tramas(k));
        Bandera1=1;
    end
    if k==NumeroTramas+Errores+1
        Bandera2=1;
    end
end
Contador(4)=Contador(1)-Contador(2);
end