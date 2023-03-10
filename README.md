# Infraestructura como código

Es un enfoque para la automatización de infraestructura basado en los principios del desarrollo de software. Esto nos permite declarar
sentencias como código para posteriormente crear estos recursos.

## Principios de la Infraestructura como código

* Los sistemas se pueden reproducir fácilmente gracias a archivos de definición donde indicamos lo que deseamos crear.
* Son desechables ya que si un sistema falla, este se puede destruir y volverlo a crear rápidamente gracias a los archivos de definición.
* Son consistentes porque los archivos de definición indican como debe estar configurado.
* Son repetibles ya que los archivos de definición se pueden ejecutar n-veces.
* El diseño siempre está cambiando porque la infraestructura puede ser modificable.

## Prácticas generales

* Utilizar un archivo de definición.
* Sistemas y procesos autodocumentados para que los otros desarrolladores puedan comprenderlo.
* Versionar todo para tener una trazabilidad de todos los cambios que sufre la infraestructura.
* Preferir cambios pequeños para no generar un alto impacto.
* Mantener los servicios continuamente disponibles.


## Tipos de herramientas para infraestructura como código

## Herramientas para la definición de infraestructura

Estas herramientas nos permiten especificar los recursos de infraestructura que necesitamos crear y que configuraciones deben tener.
Cuando hablamos de definición de infraestructura nos referimos a lo más básico como: VM, interfaces de red, discos duros, plataformas como servicios.

La definición se la realiza en archivos de configuración y cada herramienta tiene un formato definido.

Herramientas: Terraform, Cloud Formation, Open stack heat


## Herramientas para la configuración de servidores

Estas herramientas nos permiten configurar los servidores con el estado deseado, ya que una vez aprovisionado el servidor normalmente 
podemos necesitar de librerías, paquetes o configuraciones para ejecutar nuestras aplicaciones.

> **Aprovisionamiento:** Es el proceso que permite que un elemento esté listo para ser usado.

## Enfoques para la gestión de servidores

* Configuración de servidores
* Empaquetar plantillas de servidores
* Ejecutar comandos en los servidores
* Configuración desde un registro central

Herramientas: Ansible, Chef, Puppet


## Beneficios de la infraestructura como código

* Creación rápida bajo demanda ya que creamos una sóla vez un archivo de configuraciones y lo podemos replicar
* Automatización para crear y configurar la infraestructura sin intervención humana
* Visibilidad y trazabilidad para registrar los cambios que sufre la infraestructura a lo largo del tiempo con un control de versiones
* Ambientes homogeneos para recrear ambientes a partir de las mismas definiciones
* Fácil de testear ta que existen herramientas que permiten validar y probar la infraestructura


# Terraform

Es una herramienta Open Source creada por HashiCorp que está desarrollada en Go con el objetivo de crear y administrar infraestructura mediante código.

## Cómo funciona?

Terraform es un binario que interactura con las APIs de los distintos proveedores de Nube públicas o privadas.

## Estructura de un archivo de definición

* Se define el provider al cual se va a conectar terraform
* Se definen los recursos y las configuraciones de cada recurso

## Infraestructura mutable

Es cuando el estado o confguraciones de un servidor cambian.

## Infraestructura inmutable

Es cuando se destrue el servidor anterior y se crea un nuevo servidor con los cambios.

### Packer

Packer es una herramienta para construir infraestructura inmutable desarrollada por HashiCorp que nos va a permitir crear imágenes en cualquier proveedor de nube. Por ejemplo en AWS nos permite crear AMIs.

#### Elementos de definición de Packer

> variables: tal como su nombre lo indica, aquí definimos las variables que vamos a utilizar.

> builders: indicamos de donde vamos a construir nuestra imagen base.

> provisioners: acá personalizamos nuestra imagen, añadir paquetes, crear directorios, definir el estado de la infraestructura, etc.

> post-processors: podemos tener archivos de salida y ejecutar comandos después de haber creado la infraestructura, todo corre de manera local.


# Ejecutar un archivo de definición de Terraform

> **Nota:** se debe validar que nuestro sistema tenga configurado como variables de ambiente las credenciales de nuestro proveedor, como en este caso es AWS, nuestras variables de ambiente deben ser: **AWS_ACCESS_KEY_ID** y **AWS_SECRET_ACESS_KEY**

Una vez que se haya creado el o los archivos de definición de Terraform, se debe ejecutar el siguiente comando para que terraform instale las librerías o dependencias necesarias:

```shell
$ terraform init
```

Cuando las dependencias se hayan instalado correctamente, debemos ejecutar el siguiente comando para validar que el archivo de definición esté correctamente creado:

```shell
$ terraform validate
```

Si el archivo de definición es correcto, procedemos a ejecutar el siguiente comando que nos indicará cuales son las modificaciones, correcciones o caracteristicas con las cuales se va aprovisionar nuestro recurso:

```shell
$ terraform plan
```

Una vez validadas las configuraciones, para aprovisionar nuestro recurso debemos ejecutar el siguiente comando:

```shell
$ terraform apply
```
# Variables en Terraform

Cuando todos los valores se encuentran ya definidos en un archivo de configuración ocasiona que la configuración no sea escalable. Para esto, Terraform nos permite que en lugar de añadir valores estáticos podamos definir nuestro archivo con variables.

Las variables dentro de Terraform se deben definir e instanciar, una buena práctica es tener definidas las variables en un archivo e instanciarse en otro.

Terraform nos permite usar variables de tipo String, List y Map. A cada variable podemos añadirle un valor por default, una descripción y el tipo de la variable, actualmente Terraform identifica el tipo de variable automáticamente.

El archivo donde asignamos los valores de las variables debe terminar en .tfvars.

## Ejecutar un archivo de definición con variables

Validamos el archivo de definición que hemos creado indicado el archivo donde se ecuentran definidas nuestras variables

```shell
$ terraform plan -var-file dev.tfvars
```

Si el archivo es válido, procedemos a ejecutarlo indicado el archivo donde se ecuentran definidas nuestras variables

```shell
$ terraform apply -var-file dev.tfvars
```

