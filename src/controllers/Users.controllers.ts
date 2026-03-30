import { Request, Response } from 'express';

import getpool from "../db/config"
import { lstat } from 'node:fs';


//Bad code for user controller// This is just a placeholder and should be replaced with actual logic to handle user-related operations.
export const getAllUsers = async (req: Request, res: Response) => {
    try {
        const pool= await getpool();
        const result=await pool.query('SELECT * FROM Users')
        res.status(200).json(result.recordset);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }


}
//ading users
export const AddUserController = async (req: Request, res: Response) => {
    const{first_name,last_name,email,phone,Password,role_name,is_active,created_at}=req.body;
    try {
        const pool=await getpool();//opening connection to the database
        await pool.request()//creating a new request to the database
        .input('first_name',first_name)
        .input('last_name',last_name)
        .input('email',email)
        .input('phone',phone)
        .input('Password',Password)
        .input('role_name',role_name)
        .input('is_active',is_active)
        .input('created_at',created_at)
        .query('INSERT INTO Users (first_name, last_name, email, phone, Password, role_name, is_active, created_at) VALUES (@first_name, @last_name, @email, @phone, @Password, @role_name, @is_active, @created_at)')//executing the SQL query to insert a new user into the database
        res.status(201).json({ message: 'User added successfully' });//sending a response back to the client indicating that the user was added successfully    
        req
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Internal server error' });//sending a response back to the client indicating that there was an internal server error 
    }
}