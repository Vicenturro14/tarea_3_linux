# Tarea 3: Despliegue de servicios en Linux utilizando Docker
Tercera tarea del ramo Administración de Sistemas Linux.


## Configuración del Host con dnsmasq

### Paso 1: Instalar dnsmasq

```bash
sudo apt update
sudo apt install dnsmasq
```

### Paso 2: Configurar dnsmasq para subdominios tarea3

Crear un archivo de configuración:

```bash
echo "address=/tarea3/127.0.0.1" | sudo tee /etc/dnsmasq.d/tarea3.conf
```

Esto hará que todos los dominios que terminen en .tarea3 apunten a localhost.

### Paso 3: Reiniciar dnsmasq

```bash
sudo systemctl restart dnsmasq
```

Para verificar que está corriendo:

```bash
sudo systemctl status dnsmasq
```

### Paso 4: Configurar el sistema para usar dnsmasq como resolver DNS configurando NetworkManager

Crear archivo de configuración para NetworkManager:

```bash
sudo nano /etc/NetworkManager/conf.d/dnsmasq.conf
```

Agrega el siguiente contenido:

```
[main]
dns=dnsmasq
```

Reiniciar NetworkManager para aplicar los cambios:

```bash
sudo systemctl restart NetworkManager
```

### Paso 5: Verificar funcionamiento de resolución de subdominios

Ejecutando

```bash
dig moodle.tarea3 +short
```

Se debería obtener:

```bash
127.0.0.1
```