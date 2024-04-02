# Use an official base image
FROM ubuntu:latest

# Install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your website files into the default apache directory
COPY index.html /var/www/html/ 

# Set the working directory to the apache2 directory
WORKDIR /var/www/html

# Expose port 80 to the outside
EXPOSE 80

# Start Apache2 in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]