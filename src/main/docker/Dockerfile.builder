# Usar una imagen base de Red Hat Universal Base Image (UBI) con GraalVM y JDK 21
FROM quay.io/quarkus/ubi-quarkus-native-image:latest

# Instalar Maven y herramientas necesarias (usando dnf, que es compatible con UBI)
RUN dnf install -y maven \
    gcc-c++ \
    make \
    && rm -rf /var/cache/dnf

# Establecer el directorio de trabajo
WORKDIR /workspace

# Copiar el código fuente del proyecto al contenedor
COPY . /workspace

# Establecer las variables de entorno para GraalVM
ENV GRAALVM_HOME=/opt/graalvm-ce-java21
ENV PATH=$GRAALVM_HOME/bin:$PATH

# Copiar el archivo pom.xml para que Maven resuelva las dependencias antes de copiar el resto
#COPY pom.xml /workspace/

# Ejecutar la compilación del proyecto
#RUN mvn clean install -DskipTests

# Exponer el puerto que usará la aplicación
EXPOSE 8080

# Ejecutar la aplicación Quarkus en modo desarrollo
#ENTRYPOINT ["mvn", "quarkus:dev"]