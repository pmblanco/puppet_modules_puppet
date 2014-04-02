# Modulo de Pupppet para Puppet

## Introducción
Este módulo se encarga de instalar y configurar los servicios de puppet, tanto el master como los agentes.

* Permite una configuración conjunta de master y agent
* Instalación del REPO
* Configuración personalizada de "environments"
* Instalacion y configuracion de PuppetDB (en el mismo servidor o en servidores separados)


El motivo por el que he creado este módulo ha sido el de crearlo lo más sencillo posible para el despliegue en máquinas vagrant, y poder generar entornos de desarrollo de puppet

## Compatibilidad

* De momento solo es compatible con Ubuntu, pero está preparado para que se pueda usar para más S.O. con pocos cambios.

## Requirimientos

* Para la instalación de paquetería en ubuntu hace falta que esté disponible el módulo puppet para apt de puppetlabs:
   https://github.com/puppetlabs/puppetlabs-apt.git
* También son necesarios los módulos standar de puppetlabs
   - concat  (https://github.com/puppetlabs/puppetlabs-concat)
   - stdlib  (https://github.com/puppetlabs/puppetlabs-stdlib.git)
   
## Ejemplos de uso

La instalacion del repo de puppetlabs desde este módulo es opcional. Se puede hacer de la siguiente manera:

```
  class { 'puppet::repo':
  }
```

Una configuración típica de un agente sería la siguiente:
```
  class { 'puppet::agent':
    report         => 'true',
    masterserver   => 'puppet1.vag.ardemans.int',
	service_status => 'stopped',
	rundir         => '/var/run/puppet',
	ssldir         => '/etc/puppet/ssl',
  }
```

Y una configuración clásica de master sería:
```  
  class { 'puppet::master':
    manifestdir          => '/vagrant/puppet/manifests',
    manifest             => '/vagrant/puppet/manifests/site.pp',
	modulepath           => '/vagrant/puppet/modules',
    dns_alt_names        => 'puppet.vag.ardemans.int',
	puppetdb_server      => 'puppet1.vag.ardemans.int',
	reports              => 'store,puppetdb',
	storeconfigs         => 'true',
	storeconfigs_backend => 'puppetdb',
	autosign             => ['*','*.prueba.com'],
    report               => 'true',
    certname             => 'puppet1.vag.ardemans.int',
    masterserver         => 'puppet1.vag.ardemans.int',
	agent_status         => 'stopped',
	rundir               => '/var/run/puppet',
	ssldir               => '/var/lib/puppet/ssl',
  }
  
  puppet::environment { 'dev':
    manifestdir          => '/etc/puppet/environments/dev/manifests',
    manifest             => 'site.pp',
    modulepath           => '/etc/puppet/environments/dev/modules',
  }
```

Y al final de la configuracion del master se puede ver el ejemplo de añadir un entorno a la configuración.

   
## Autores

Pedro Miguel Blanco 
   
## Changelog

### v.0.3. 02/04/2014
- Se trabaja en la compatibilidad con Centos. Se añade nuevo repo de Centos de puppetlabs
- Dependencia de la clase puppet::db de la clase puppet::agent. Para que el primero funcione ha de estar declarado el segundo. Esto es debido a que puppetdb necesita de certificados para funcionar y este los coge de los que genera el agente de puppet

### v.0.2. 28/03/2014
Instalación de puppetdb y personalizacion en master de puppetdb.
Cambio en filosofía de instalación de master: siempre se instalará el agent cuando se instala el master y no sepuede definir las dos clases (master y agent) en la misma máquina

### v.0.1. 20/03/2014
