FROM debian:bookworm-slim

# Instalar herramientas básicas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    procps \
    htop \
    nano \
    vim \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar la terminal web ttyd
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

WORKDIR /root

# Render asigna el puerto mediante la variable de entorno $PORT (por defecto 10000)
ENV PORT=10000

# Iniciar la terminal DIRECTAMENTE como ROOT conservando el soporte completo para teclado táctil
USER root
CMD ["sh", "-c", "ttyd -p $PORT -t fontSize=16 -t enableTrzsz=true -o bash"]
