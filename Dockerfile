# Start from a lightweight base image like Alpine Linux
FROM alpine:latest

# Set a working directory inside the container
WORKDIR /app

# Copy your PocketBase executable (which should be in the same directory as this Dockerfile)
# into the container's /app directory
COPY ./pocketbase /app/pocketbase

# Make the PocketBase executable runnable
RUN chmod +x /app/pocketbase

# DO NOT declare VOLUME here for Railway.
# You will define the volume and its mount path in the Railway dashboard.

# Expose the default port PocketBase will listen on inside the container.
# Railway will automatically map traffic from its public URL to this port.
EXPOSE 8090

# Command to run when the container starts.
# --dir=/pb_data: Tells PocketBase where to store its data (this path will be mounted to your Railway volume).
# --http="0.0.0.0:8090": Makes PocketBase listen on all network interfaces within the container on port 8090.
CMD ["/app/pocketbase", "serve", "--dir=/pb_data", "--http=0.0.0.0:8090"]