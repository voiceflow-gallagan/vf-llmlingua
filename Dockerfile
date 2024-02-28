# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install numpy, llmlingua, and accelerate Python libraries
RUN pip3 install numpy llmlingua accelerate

# Copy the rest of the application to the working directory
COPY . .

# Run the Python script with some default parameters to trigger the download
RUN python3 compress_prompt.py '{"context":"This is needed to download pre-trained models and other necessary data from the internet","instruction":"Answer user","question":"What are you doing?"}'

# Make port 3000 available to the outside world
EXPOSE 3000

# Run the application when the container launches
CMD [ "node", "app.js" ]
