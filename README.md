# Modulo de Puppet para Puppet

## Introducci�n
Este m�dulo se encarga de instalar y configurar los servicios de puppet, tanto el master como los agentes.

* Permite una configuraci�n conjunta de master y agent
* Instalaci�n del REPO
* Configuraci�n personalizada de "environments"
* Instalacion y configuracion de PuppetDB (en el mismo servidor o en servidores separados)


El motivo por el que he creado este m�dulo ha sido el de crearlo lo m�s sencillo posible para el despliegue en m�quinas vagrant, y poder generar entornos de desarrollo de puppet

## Compatibilidad

* Ubuntu Family
* RedHat 6 Family

## Requirimientos

* Para la instalaci�n de paqueter�a en ubuntu hace falta que est� disponible el m�dulo puppet para apt de puppetlabs:

   **https://github.com/puppetlabs/puppetlabs-apt.git**

* Tambi�n son necesarios los m�dulos standar de puppetlabs
   - concat  (https://github.com/puppetlabs/puppetlabs-concat)
   - stdlib  (https://github.com/puppetlabs/puppetlabs-stdlib.git)
   
## Ejemplos de uso

La instalacion del repo de puppetlabs desde este m�dulo es opcional. Se puede hacer de la siguiente manera:

```puppet
  class { 'puppet::repo':
  }
```

Una configuraci�n t�pica de un agente ser�a la siguiente:

```puppet
  class { 'puppet::agent':
    report         => 'true',
    masterserver   => 'puppet1.vag.ardemans.int',
    service_status => 'stopped',
    rundir         => '/var/run/puppet',
    ssldir         => '/etc/puppet/ssl',
  }
```

Y una configuraci�n cl�sica de master ser�a:

```puppet  
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

Y al final de la configuracion del master se puede ver el ejemplo de a�adir un entorno a la configuraci�n.

   
## Autores

Pedro Miguel Blanco 
   
## Changelog

### v.0.6. 03/08/2015

- Nuevo par�metro hiera_config en el master, para poder personalizar ubicaci�n de hiera
- Nuevo par�metro basemodulepath en master, para definier path de m�dulos generales a los environment
- Compatibilidad con Debian (a�adido en el params.pp)

### v.0.5. 24/04/2015

- Se a�ade par�metro environmentpat, para ir tendiendo a quitar la definici�n de los environments de las vesiones antiguas. En la versi�n 4 de puppet ya no ser� posible usar definiciones de environments y habr� que usar un directorio de environments.

### v.0.4. 13/11/2014

- Solventamos un problema de dependencias con puppetdb, con los certificados necesarios para arrancar el servicio. Ahora estos certificados tienen  un notify al servicio puppetdb, por lo que deber�n ser copiados antes de arrancar el servicio.

### v.0.3. 02/04/2014

- Se trabaja en la compatibilidad con Centos. Se a�ade nuevo repo de Centos de puppetlabs
- Dependencia de la clase puppet::db de la clase puppet::agent. Para que el primero funcione ha de estar declarado el segundo. Esto es debido a que puppetdb necesita de certificados para funcionar y este los coge de los que genera el agente de puppet

### v.0.2. 28/03/2014

- Instalaci�n de puppetdb y personalizacion en master de puppetdb.
- Cambio en filosof�a de instalaci�n de master: siempre se instalar� el agent cuando se instala el master y no sepuede definir las dos clases (master y agent) en la misma m�quina

### v.0.1. 20/03/2014

- Versi�n inicial