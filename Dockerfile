# Start from a lightweight base image like Alpine Linux
FROM alpine:latest

# Set a working directory inside the container
WORKDIR /app

# Copy your PocketBase executable (which should be in the same directory as this Dockerfile)
# into the container's /app directory
COPY ./pocketbase /app/pocketbase

# Make the PocketBase executable runnable
RUN chmod +x /app/pocketbase

# PocketBase will store its data in /pb_data by default when using the --dir flag.
# Declare this as a volume so Railway can mount persistent storage here.
# This is CRUCIAL for your data to persist across deployments/restarts.
VOLUME /pb_data

# Expose the port PocketBase will listen on inside the container.
# Railway will automatically map traffic from its public URL to this port.
EXPOSE 8090

# Command to run when the container starts.
# --dir=/pb_data: Tells PocketBase where to store its data (this path will be mounted to your Railway volume).
# --http="0.0.0.0:8090": Makes PocketBase listen on all network interfaces within the container on port 8090.
CMD ["/app/pocketbase", "serve", "--dir=/pb_data", "--http=0.0.0.0:8090"]