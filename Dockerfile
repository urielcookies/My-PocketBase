FROM alpine:latest

# Add essential dependencies (for SSL and timezones)
RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

# Copy binary and make sure it's executable
COPY ./pocketbase /app/pocketbase
RUN chmod +x /app/pocketbase

# Optional: create pb_data folder inside container (Railway will mount over it)
RUN mkdir -p /pb_data

EXPOSE 8090

# Serve PocketBase on all interfaces and custom data dir
CMD ["/app/pocketbase", "serve", "--dir=/pb_data", "--http=0.0.0.0:8090"]
