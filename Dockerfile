FROM debian:bookworm-slim

# Instalar herramientas básicas, sudo y dependencias
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    sudo \
    procps \
    htop \
    nano \
    vim \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar la terminal web ttyd
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Crear usuario 'appuser' y darle permisos root completos con sudo sin contraseña
RUN useradd -m -s /bin/bash appuser && \
    echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/appuser
USER appuser

# Render asigna el puerto mediante la variable de entorno $PORT (por defecto 10000)
ENV PORT=10000

# Iniciar ttyd configurado para teclados de pantallas táctiles y celulares
CMD ["sh", "-c", "ttyd -p $PORT -t fontSize=16 -t enableTrzsz=true -o bash"]
