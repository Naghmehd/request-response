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
  {"first_name" => "Bill" ,  "last_name" => "Gates",   "age" => 46},
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
      puts @request.inspect
      if @request[:method] == "GET" && @params[:resource] == "users"
        puts "HTTP/1.1 200 OK"
        puts
        USERS.each do |user|
          user.each do |_, value|
            print value
          end
        end
      elsif @request[:method] == "GET" && @params[:id] == "users"
        puts "HTTP/1.1 200 OK"
        puts
        puts USERS[:id]
      else @request[:method] == "GET" && @params[:resource] == "users"
        puts "HTTP/1.1 404"
        USERS.select { |z| e.is_a? Hash}
        puts "This name is not on the list"
      end

  end
end

#
#
#
# else "@request[:method] == "GET" && @params[:resource] == "users"
 #  puts "HTTP/1.1 404"
#  USERS.select { |z| e.is_a? Hash}
# puts "This name is not on the list"
#   end
