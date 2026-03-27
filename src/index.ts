import express from 'express';

import getPool from './db/config'; 
import { get } from 'node:http'  
const app = express();// Create an Express application

app.get('/', (req, res) => {
  res.send('Hello, Express server is running!');// Send a response to the client
});

const PORT = 3000;// Define the port number for the server to listen on

app.listen(PORT, () => {// Start the server and listen on the specified port
  console.log(`Server is running on port :http://localhost:${PORT}`);// Log a message when the server starts
});

//fetch users with minimal error hndling to test the database connection
app.get('/Users', (req, res) => {
  getPool()
    .then(pool => {
      return pool.request().query("SELECT * FROM Users");
    })
    .then(result => {
      console.log("results", result);
      res.json(result.recordset);
    })
    .catch(err => {
      console.error("Error fetching users:", err);
      res.status(500).send("Server error");
    });
});
     


getPool()// Establish a connection pool to the database
.then(()=>console.log('Database connection pool established successfully.'))// Log a message when the database connection pool is established
.catch((error:any) => console.log('Error establishing database connection ', error));// Log any errors that occur while establishing the database connection pool