# Messenger

## Introducción

La aplicación consiste en un servicio de mensajerı́a que permite intercambiar mensajes
entre los usuarios logueados en el sistema. Los mensajes enviados son cifrados
con el fin de evitar que usuarios ajenos a la aplicación los intercepten.

## Arquitectura

Se combinan tres tipos de arquitectura distintos:

- **Maestro/Esclavo:** Emplea un servidor maestro, el cual se ocupa de coordinar los
servidores esclavo, a los que les redirige los mensajes. Ésto permite liberar de gran
parte del trabajo al servidor maestro, ası́ como para facilitar la búsqueda de los
clientes en el árbol de servidores utilizado.

- **Cliente/Servidor:** Los clientes reciben mensajes del servidor al que pertenecen y
se comunican a través de éste con el resto de usuarios. Con esto se consigue que los
servidores sean independientes.

- **Capas:** Los servidores esclavos emplean la arquitectura por capas para añadir fun-
cionalidades de forma más simple, como el cifrado de los mensajes. Ésto permite
dividir las responsabilidades y, a su vez, aislar los cambios a nivel de capa, lo que
nos permite realizar modificaciones de forma rápida y eficaz.

## Tácticas

- **Disponiblidad:** Al emplear la arquitectura Maestro/Esclavo, se permite la cone-
xión de los usuarios al sistema y el funcionamiento de la aplicación de forma ininte-
rrumpida. Como táctica de recuperación de errores utilizamos la redundancia activa
en todos los servidores, de forma que, en caso de producirse una caı́da, disponer de
un backup y permitir una rápida recuperación del sistema. Como táctica de preven-
ción de errores utilizamos un supervisor por servidor, de forma que, si se produce
un fallo, mientras se inicia el funcionamiento del servidor de backup el supervisor
reinicia el servidor en el cual se produce el fallo. Los servidores se reinician cada
cierto tiempo para evitar quedarse sin memoria.

- **Flexibilidad al cambio:** Gracias a la arquitectura por capas, realizar un cambio
en la aplicación produce que el número de componentes afectados sea mı́nimo. Por
ejemplo, el algoritmo de cifrado se podrı́a sustituir por una implementación más
segura solo modificando el módulo de cifrado, sin necesidad de modificar ningún
otro componente.

- **Rendimiento:** La aplicación es totalmente ası́ncrona (incremento de la eficiencia),
solo empleamos intermediarios en la primera conexión y en la búsqueda de usuarios
(reducción de la sobrecarga) y el tiempo de espera es nulo debido al asincronismo
de las comunicaciones.

- **Seguridad:** Se proporciona confidencialidad a los usuarios, ya que las comunicacio-
nes se realizan cifradas utilizando el cifrado César.

- **Usabilidad:** La aplicación es sencilla y no dispone de aspectos complejos que re-
quieran un aprendizaje por parte del usuario. De todas formas, se detalla a continuación
el funcionamiento de dicha aplicación.

## Instrucciones

- En el fichero cliente.erl, reemplazar en la cadena de texto "servidor@hostname"
en la función `server_node()` la palabra hostname por el hostname de tu equipo.

- Abrir una consola por cada cliente que se quiera poner a funcionar y una más
en la que se ejecutará el servidor.

- Iniciar las consolas de Erlang con el parametro -sname (erlang -sname nombre).
Obligatorio que el nombre del servidor sea servidor: **erlang -sname servidor**.

- Se inicia el servidor ejecutando la función `servidor:start()` y los clientes
con la función `cliente:start("nombre_de_usuario")` para registrarlos en el servidor.

- Una vez iniciados los clientes y el servidor, ejecutamos en el cliente la función
`cliente:send("destino", "mensaje")`, siendo "destino" el usuario al que queremos enviar
la cadena de caracteres "mensaje".

- Para desconectar un usuario del programa se debe ejecutar la función `cliente:logout()`.