adopto(martin,pepa,2014).
adopto(martin,frida,2015).
adopto(martin,kali,2016).
adopto(martin,olivia,2014).
adopto(constanza,mambo,2015).
adopto(hector,abril,2015).
adopto(hector,mambo,2015).
adopto(hector,buenaventura,1971).
adopto(hector,severino,2007).
adopto(hector,simon,2016).
leRegalaron(constanza,abril,2016).
leRegalaron(silvio,quinchin,1990).
compro(martin,piru,2010).
compro(hector,abril,2006).

% perro(tamaño)
% gato(sexo, cantidad de personas que lo acariciaron)
% tortuga(carácter)

tiene(Persona,Mascota,Anio):-adopto(Persona,Mascota,Anio).
tiene(Persona,Mascota,Anio):-leRegalaron(Persona,Mascota,Anio).
tiene(Persona,Mascota,Anio):-compro(Persona,Mascota,Anio).

mascota(pepa, perro(mediano)).
mascota(frida, perro(grande)).
mascota(piru, gato(macho,15)).
mascota(kali, gato(macho,3)).
mascota(olivia, gato(hembra,16)).
mascota(mambo, gato(macho,2)).
mascota(abril, gato(hembra,4)).
mascota(buenaventura, tortuga(agresiva)).
mascota(severino, tortuga(agresiva)).
mascota(simon, tortuga(tranquila)).
mascota(quinchin, gato(macho,0)).

cumplidores(Persona1,Persona2):-
adopto(Persona1,Mascota,Anio),
adopto(Persona2,Mascota,Anio),
Persona1\=Persona2.

esGato(Mascota):-
mascota(Mascota,gato(_,_)).

tieneMasDeUnGato(Persona,Mascota):-
tiene(Persona,Mascota,_),
tiene(Persona,OtraMascota,_),
mascota(Mascota,gato(_,_)),
mascota(OtraMascota,gato(_,_)),
Mascota\=OtraMascota.


locoDeLosGatos(Persona):-
tieneMasDeUnGato(Persona,_),
forall(tiene(Persona,Mascota,_),esGato(Mascota)).

puedeDormir(Persona):-
tiene(Persona,_,_),
forall(tiene(Persona,Mascota,_),not(chapita(Mascota))).

chapita(Mascota):-mascota(Mascota,perro(chico)).
chapita(Mascota):-mascota(Mascota,tortuga(_)).
chapita(Mascota):-mascota(Mascota,gato(macho,CantCarioniosos)),CantCarioniosos<10.

crisisNerviosa(Persona,Anio):-
tiene(Persona,Mascota,_),
chapita(Mascota),
tiene(Persona,OtraMascota,OtroAnio),
chapita(OtraMascota),
Anio is OtroAnio+1,
Mascota\=OtraMascota,
Anio\=OtroAnio.

/*En crisisNerviosa se puede hacer consultas existenciales ya OtroAnio es generado en tiene y llega logado al is
 */

mascotaAlfa(Persona,NombreMascota):-
tiene(Persona,NombreMascota,_),
forall((tiene(Persona,OtraMascota,_),OtraMascota\=NombreMascota),domina(NombreMascota,OtraMascota)).

mismoDuenio(Persona,Mascota1,Mascota2):-
tiene(Persona,Mascota1,_),
tiene(Persona,Mascota2,_),
Mascota1\=Mascota2.

domina(Mascota1,Mascota2):-
mascota(Mascota1,gato(_)),
mascota(Mascota2,perro(_)),
Mascota1\=Mascota2.



domina(Mascota1,Mascota2):-
mascota(Mascota1,perro(grande)),
mascota(Mascota2,perro(chico)),
Mascota1\=Mascota2.



domina(Mascota1,Mascota2):-
chapita(Mascota1),
not(chapita(Mascota2)),
Mascota1\=Mascota2.



domina(Mascota1,Mascota2):-
mascota(Mascota1,tortuga(agresiva)),
mascota(Mascota2,_),
Mascota1\=Mascota2.

materialista(Persona):-
not(tiene(Persona,_,_)).

materialista(Persona):-
tiene(Persona,_,_),
cantAdopta(Persona,Cant1),
cantCompra(Persona,Cant2),
Cant2>Cant1.

cantAdopta(Persona,Cant):-
findall(Mascota,adopto(Persona,Mascota,_),Mascotas),
length(Mascotas,Cant).

cantCompra(Persona,Cant):-
findall(Mascota,compro(Persona,Mascota,_),Mascotas),
length(Mascotas,Cant).