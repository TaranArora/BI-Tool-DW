# Use the base image from the docker-compose.yml
FROM jupyter/scipy-notebook:latest

# Install additional libraries
RUN pip install yfinance sqlalchemy psycopg2-binary pandas matplotlib seaborn

# Set the default command to start Jupyter Lab
CMD ["start-notebook.sh", "--NotebookApp.token=''"]