# Use an official Node.js runtime as the base image
FROM node:14
# Set the working directory in the container
WORKDIR /app
# Copy the current directory contents into the container at /app
COPY server.js .
# Make port 8080 available to the world outside this container
EXPOSE 8080
# Define environment variables
ENV NODE_ENV=production
# Run the application
CMD ["node", "server.js"]

