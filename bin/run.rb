# Remember to put the requires here for all the classes you write and want to use

def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end
# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[2]
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end


USERS = [
  {"first_name" => "Justin", "last_name" => "Herrick", "age" => 12},
  {"first_name" => "Rohit",  "last_name" => "Prabu",   "age" => 18},
  {"first_name" => "Lily",   "last_name" => "Smith",   "age" => 24},
  {"first_name" => "Cameron","last_name" => "Black",   "age" => 28},
  {"first_name" => "Andrea" ,"last_name" => "Logan",   "age" => 34},
  {"first_name" => "Naghmeh","last_name" => "Shirazi", "age" => 32},
  {"first_name" => "Roy",    "last_name" => "Desi",    "age" => 19},
  {"first_name" => "Joy",    "last_name" => "Roger",   "age" => 25},
  {"first_name" => "Cathy",  "last_name" => "white",   "age" => 38},
  {"first_name" => "Sam" ,   "last_name" => "Gates",   "age" => 46},
  {"first_name" => "Aaron",  "last_name" => "Scott",   "age" => 12},
  {"first_name" => "Reema",  "last_name" => "Sandu",   "age" => 18},
  {"first_name" => "Marry",  "last_name" => "Darby",   "age" => 24},
  {"first_name" => "Chetan", "last_name" => "Rai",     "age" => 28},
  {"first_name" => "Alex" ,  "last_name" => "lamba",   "age" => 34},
  {"first_name" => "Nick",   "last_name" => "Jones",   "age" => 32},
  {"first_name" => "Dave",   "last_name" => "Watts",   "age" => 19},
  {"first_name" => "Eric",   "last_name" => "McNinch", "age" => 25},
  {"first_name" => "Kim",    "last_name" => "Smallwood","age" => 38},
  {"first_name" => "Lisa" ,  "last_name" => "Munter",   "age" => 46},
]


system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
    else
      @request = parse(raw_request)
      @params  = @request[:params]
# below code prints the error. works.
      if @request[:method] == "GET" &&
         @params[:resource] == "users" &&
        (@params[:id].to_i - 1) > USERS.length
         puts "HTTP/1.1 404"
         puts
         puts "It was not found."
#below code for printng by one index number.works
      elsif @request[:method] == "GET" &&
            @params[:resource] == "users" &&
           (@params[:id].to_i - 1) >= 0
        id = @params[:id].to_i - 1
        puts "HTTP/1.1 200 OK"
        puts
        puts USERS[id].values.join(" ")
#below is the code for printing user with "s" in first name. Runs but doesn't print name
      elsif @request[:method] == "GET" &&
            @params[:resource] == "users"
        puts "HTTP/1.1 200 OK"
        puts
        puts USERS.select { |user| "S" == user }
#below is the code for delete ID from array, it's deleting but not printing the new list.
      elsif @request[:method] == "DELETE" &&
            @params[:resource] == "users" &&
           (@params[:id].to_i - 1) >= 0
        id = @params[:id].to_i - 1
        USERS.delete_at(2)
        puts "HTTP/1.1 200 OK"
        puts
        puts USERS.each do |user|
          user.each do |_, value|
            print "#{value} "
          end
          print "\n"
        end
# below is the code for only 10 users with id of greater than 10. Gives an error.
      elsif @request[:method] == "GET" &&
            @params[:resource] == "users" &&
           (@params[:id].to_i - 1) >= 10
        id = @params[:id].to_i - 1
        puts "HTTP/1.1 200 OK"
        puts
        puts USERS.each do |user|
          user.each do |_, value|
            print "#{value} "
          end
          print "\n"
        end
#below is the code to print all the initial 10 users. Works.
      elsif @request[:method] == "GET" &&
            @params[:resource] == "users"
        puts "HTTP/1.1 200 OK"
        puts
        USERS.each do |user|
          user.each do |_, value|
            print "#{value} "
          end
          print "\n"
        end

      else @request[:method] == "GET" &&
           @params[:resource] == "user"&&
           (@params[:id].to_i - 1) == 0
           puts "ERROR!! 404"
      end
  end
end
