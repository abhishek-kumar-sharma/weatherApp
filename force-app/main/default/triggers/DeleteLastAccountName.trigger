trigger DeleteLastAccountName on Contact (before delete , after update) {
    deleteHandler.removeLastName(Trigger.Old);
    
}