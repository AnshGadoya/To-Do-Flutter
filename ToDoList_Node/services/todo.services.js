const todoModel = require('../model/todo.model');


class ToDoServices{
    static async createtodo(userId, title, desc){
        const createtodo = new todoModel({userId, title, desc});
        return await createtodo.save();

    }
    static async getTodoData(userId){
        const tododata = await todoModel.find({userId});
        return tododata;

    }
    
    static async deleted(id){
        const deleteddata = await todoModel.findByIdAndDelete({_id: id});
        return deleteddata;

    }
}
module.exports = ToDoServices;