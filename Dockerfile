# Stage 1: Builder stage - prepare content
FROM nginx:alpine AS builder

# Copy custom index.html
COPY index.html /usr/share/nginx/html/index.html

# Stage 2: Final stage - production-ready nginx
FROM nginx:alpine

# Copy the prepared content from builder stage
COPY --from=builder /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Expose port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
