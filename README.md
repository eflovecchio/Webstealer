Este script sirve para parsear cada X tiempo las una lista grande de IP's y parsea por todas las palabras que quieras agarradas de una lista.

Ejemplo de ejecución:

web_stealer.sh lista_ip.txt lista_palabras_a_buscar.txt 60

El primer parametro indica la lista de IP's (aclarar puerto).
El segundo parametro indica que va a Grepear sobre el resultado de la request web.
El tercer parametro indica la cantidad de segundos que va a pasar hasta que vuelva a buscar otra vez las palabras.

Cabe destacar que si la página tiene mucho delay o generas una lista muy grande no va a poder esperar 60 segundos por ejemplo entre la anterior request y esta.

estos resultados se van a ir poniendo en formato texto en la carpeta donde la ejecutes y la ejecucion va a ser constante hasta que uno la frene.
