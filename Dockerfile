# Usa una imagen base de nginx
FROM nginx:alpine

# Copia el archivo HTML al directorio de documentos de nginx
COPY index.html /usr/share/nginx/html

# Expón el puerto 80
EXPOSE 80
