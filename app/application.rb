class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # binding.pry

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      item1 = req.params["item"]
      if @@items.include?(item1)
        @@cart << item1
        resp.write "added #{item1}"
      else
        resp.write "We don't have that item."
      end

    elsif req.path.match(/cart/)
      if @@cart.length > 0
        # cart = @@cart.flatten
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty."
      end

    else
      resp.write "Path Not Found"
    end


    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
