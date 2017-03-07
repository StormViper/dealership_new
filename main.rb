require_relative 'db/database_search.rb'

class EmployeeScreen
  def initialize
    connect = DatabaseConnection.new
    return if !connect
    connection = connect.retrieve_connection if connect
    return if !connection
    @@insert = connection if connect
    @@connection = connect if connect
    @@check_if_connect = connect.check_if_connection if connect
    @@search = DatabaseSearch.new
    run
  end

  def run
    puts "Welcome Employee! \nPlease select an option from the list \n1) Browse all members\n2) Browse All Vehicles\nAdd new member or vehicle"
    input = gets.chomp.to_i

    if input ==  1
      member_script
    elsif input == 2
      vehicle_script
    elsif input == 3
      new_member_vehicle
    else
      p "Please input either 1 or 2!"
      run
    end
  end

  def member_script
    puts "Would you like to view all members, or search for by email?\n1) View all members\n2) Search by email"
    table, type = "member", "email"
    input = gets.chomp.to_i

    if input == 1
      members = @@connection.fetch_all_from(table)
      p ""
      p members
      puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
      run
    elsif input == 2
      p "Please enter the member's email address:"
      input = gets.chomp
      member = @@search.search_tables(type, input, table)
      p member
      puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
      run
    else
      p "Please enter a valid response of 1 or 2!"
      member_script
    end
  end

  def vehicle_script
    puts "Would you like to view all vehicles, or search for vehicles by make, model, or year?\n1) View all vehicles\n2) Search by make, model or year"
    table = "vehicle"
    input = gets.chomp.to_i

    if input == 1
      vehicles = @@connection.fetch_all_from(table)
      p ""
      p vehicles
      puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
      run
    elsif input == 2
      puts "Please pick one of the following three:\n1) Search by make\n2)Search by model\n3)Search by Year"
      input = gets.chomp.to_i

      if input == 1
        type = "make"
        p "Please input make"
        input = gets.chomp
        vehicles = @@search.search_tables(type, input, table)

        p vehicles
        puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
        run
      elsif input == 2
        type = "model"
        p "Please input model"
        input = gets.chomp
        vehicles = @@search.search_tables(type, input, table)

        p vehicles
        puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
        run
      elsif input == 3
        type = "year"
        p "Please input year"
        input = gets.chomp.to_i
        vehicles = @@search.search_tables(type, input, table)

        p vehicles
        puts "Thank you for using Adam's search engine\nRedirecting you back to the main menu"
        run
      else
        "Please enter a valid response of 1, 2 or, 3!"
        vehicle_script
      end
    else
    end
  end
end

EmployeeScreen.new
