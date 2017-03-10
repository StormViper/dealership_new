require_relative 'db/database_search.rb'
require_relative 'main_methods.rb'

class EmployeeScreen < MainMethods
  def initialize
    connect = DatabaseConnection.new
    return if !connect
    connection = connect.retrieve_connection if connect
    return if !connection
    @@insert = connection if connect
    @@connection = connect if connect
    @@check_if_connect = connect.check_if_connection if connect
    @@search = DatabaseSearch.new

    @@methods = MainMethods.new(@@connection, @@check_if_connect, @@search, @@insert)

    run
  end

  def run
    @@methods.run
  end

  def member_script
    @@methods.member_script
  end

  def vehicle_script
    @@methods.vehicle_script
  end
end

EmployeeScreen.new
