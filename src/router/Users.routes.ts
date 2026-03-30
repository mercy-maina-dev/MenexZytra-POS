

import {Express} from 'express';
import * as usersController from '../controllers/Users.controllers';


const getAllUsersRoutes = (app: Express) => {
    app.get('/users', usersController.getAllUsers);
    app.post('/user', usersController.AddUserController);
}

export default getAllUsersRoutes;