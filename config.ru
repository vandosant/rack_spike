class ToUpper
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body  = @app.call(env)

    upcased_body = body.map { |chunk| chunk.upcase }

    [status, headers, upcased_body]
  end
end

#class Hello
#  def self.call(env)
#    [ 200, {"Content-Type" => "text/plain"}, ["Hello from Rack!"] ]
#  end
#end

# use a convenience class Rack::Response
class Hello
  def self.call(env)
    res = Rack::Response.new

    # This will automatically set the Content-Length header for you
    res.write "Hello from Rack!"

    # returns the standard [status, headers, body] array
    res.finish

    # You can get/set headers with square bracket syntax:
    #   res["Content-Type"] = "text/plain"

    # You can set and delete cookies
    #   res.set_cookie("user_id", 1)
    #   res.delete_cookie("user_id")
  end
end

use ToUpper
run Hello