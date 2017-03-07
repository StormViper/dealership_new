require 'mysql'
class DatabaseConnection

  def initialize
    #Start making a connection to the database
    connection =  Mysql.new('localhost', 'root', '', 'dealership')
    #If there is no connection, return straight away and notify the logs
    return if !connection
    #if there is a connection set the class variable with the connection
    @@connection = connection if connection

  end
#Fetch all data from a table provided
#We set the error and result to empty each time and then run our 'check_if_connection' just to be more sure
#If that is true(has a connection) then we will get the results corrosponding to the table provided
#If that is false(has no connection) then we will update the error message

#After this we check if the result in empty and if the error is not empty
#If the above conditions are true we then return the error message to the user
#If the result is not empty and the error is empty, we provide the user with the results containg the data from the table they provided.
#If neither of these conditions are met, we tell the user to contact a higher-up about this issue.
  def fetch_all_from(table)
    error = ""
    result = []
    check_if_connection ? result = @@connection.query("SELECT * FROM #{table}") : error="****No connection to database****"
    result = result.fetch_row if result

    if result.empty? && !error.empty?
      return "ERROR: #{error}"
    elsif !result.empty? && error.empty?
      return result
    else
      return "****ERROR: UNKNOWN ISSUE, PLEASE CONTACT ADMIN****"
    end
  end
#This is the method we mentioned above, inside here we check the class @@connection variable
#If there is a connection we return true, if there is not a connection we return false, and
#if neither of these are met or it is met with something else, we return false as well as this would be an error.
  def check_if_connection
    if @@connection
      return true
    elsif !@@connection
      return false
    else
      return false
    end
  end

  def retrieve_connection
    return @@connection
  end

end
#Below we make a new 'DatabaseConnection' object and set our local 'cars' and 'members' using our fetch_all_from(input) method
#By providing this method with our 'vehicle' and 'member' table

#d = DatabaseConnection.new
#cars = d.fetch_all_from('vehicle')
#members = d.fetch_all_from('member')
#p cars, members
