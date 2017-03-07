require_relative 'database_connect.rb'
class DatabaseSearch < DatabaseConnection
  #We first create a new instance of our 'DatabaseConnection' and then return if we do not create this new instance
  #We then set our connection to retrieve the connection from 'DatabaseConnect' object, and return if we can not retrive this
  #After this, we set our class '@@connection' variable, but only if there is a connection so we don't run into any errors.
  #Then we set our class '@@check_if_connect' to the 'DatabaseConnection's check_if_connect so we can see check if we are connected to the database.
  def initialize
    connect = DatabaseConnection.new
    return if !connect
    connection = connect.retrieve_connection if connect
    return if !connection
    @@connection = connection if connection
    @@check_if_connect = connect.check_if_connection if connect
  end
#We created our 'search_tables' method that takes type, input and table as our required paramaters for this method.
#We set all of our local variables to what we need, and we return if we do not have a type, input or table as this would cause issues
#After this, we check if the type is equal to 'year' and if it is, we set the input to an integer as we will need to use an integer when we search for the year in our database.
#Similar to our 'fetch_all_from' method in our 'DatabaseConnection' we use the same code but replace the table name with the table, the field with the 'type' and the input
#we have given to find the relative vehicle or member, while doing so we use the same method for checking if our result is empty or if our error is empty.
  def search_tables(type, input, table)
    type, table, error, result = type.downcase, table, "", []
    if type != "year"
      input = input.downcase
    else
      input = input
    end
    
    return if !type
    return if !input
    return if !table

    if type == "year"
      input = input.to_i
    end

    @@check_if_connect ? result = @@connection.query("SELECT * FROM #{table} WHERE #{type}='#{input}'") : error = "****No connection to database****"
    result = result.fetch_row if result

    if result.empty? && !error.empty?
      return "ERROR: #{error}"
    elsif !result.empty? && error.empty?
      return result
    else
      return "****ERROR: UNKNOWN ISSUE, PLEASE CONTACT ADMIN****"
  end
end

end
