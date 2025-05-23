# Práctica 4 - Escena y cámaras
- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad de Granada


## Preparación del santuario
La escena es muy semejante a la de la práctica 3 debido a que ya se avanzó esto ahí. En cualquier caso, las modificaciones que se han hecho son muy leves en cuanto a luces o fog.
- Se ha decidido continuar con la niebla puesta en lugar de colocar fondo al mundo porque da un acabado más mágico que es lo que se busca.
- Las luces erróneas que se indicaron en la evaluación de la P3 no se han modificado aún (para la P5 sí estarán arregladas)


## Cámaras
Existen dos cámaras colocadas en escenas separadas para facilitar su uso:
- Avatar: Cámara del personaje. Está colocada a la altura de un supuesto avatar. Se mueve con el ratón y tiene un zoom incorporado con la ruedecilla de este. Para moverse por la habitación se utilizan las teclas WASD. 
- Vigilante: Cámara de vigilancia colocada en el pasillo. En lugar de una animación como se sugiere hacer en el ejercicio, he hecho para que se mueva también con el ratón, con su zoom porque me ha parecido más interesante e interactivo (he supuesto que no era necesario porque dice "Puedes aprovechar para...". Esta cámara permanece quieta en la pared del pasillo y tiene límites en los extremos horizontales y verticales para evitar mirar a la pared o dar la vuelta por arriba o abajo.

Las cámaras se cambian con el botón "C". Se ha realizado la modificación para impedir que la cámara que no está activa gire.
Se ha añadido un panel de instrucciones en la interfaz donde al cambiar de cámara, desaparece el texto de desplazamiento y se modifica el del cabio de cámara.

Por último, con el botón ESC sales de la pantalla para mayor comodidad.
