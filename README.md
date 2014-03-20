# Modulo de Pupppet para Puppet

## Introducción
Este módulo se encarga de instalar y configurar los servicios de puppet, tanto el master como los agentes.

* Permite una configuración conjunta de master y agent
* Configuración mediante define de diferentes entornos personalizables
* Instalación del REPO

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

```
  class { 'puppet::agent':
    report       => 'true',
    certname     => 'puppet1.vag.ardemans.int',
    masterserver => 'puppet1.vag.ardemans.int',
  }
  
  class { 'puppet::master':
    manifestdir    => '/vagrant/puppet/manifests',
    manifest       => '/vagrant/puppet/manifests/site.pp',
	modulepath     => '/vagrant/puppet/modules',
    reports        => 'puppetdb',
    dns_alt_names  => 'puppet.vag.ardemans.int',
  }
  
  class { 'puppet::configmain':
    certname       => 'puppet1.vag.ardemans.int',
	rundir         => '/var/run/puppet',
	ssldir         => '/var/lib/puppet/ssl',
  }
  
  puppet::environment { 'dev':
    manifestdir    => '/etc/puppet/environments/dev/manifests',
    manifest       => 'site.pp',
    modulepath     => '/etc/puppet/environments/dev/modules',
  }
```
   
## Autores

Pedro Miguel Blanco 
   
## Changelog

### v.0.1. 20/03/2014
