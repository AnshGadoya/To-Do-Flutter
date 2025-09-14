const todoModel = require('../model/todo.model');


class ToDoServices{
    static async createtodo(userId, title, desc){
        const createtodo = new todoModel({userId, title, desc});
        return await createtodo.save();

    }
}
module.exports = ToDoServices;