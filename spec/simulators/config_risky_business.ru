require 'json'

run Proc.new { |env|
  req = Rack::Request.new(env)
  puts req.inspect
  req_body = JSON.parse(req.body.read)
  if req['REQUEST_PATH'] == '/health'
    ['200', {}, 'OK']
  else
    if (req_body) == {username: 'jimmy', password: 'theRightPassword'}
      ['200', {'Content-Type' => 'application/json'}, [status: 'Logged in', worker: {user_id: 1, role: 'supervisor'}.to_json]]
    else
      ['200', {'Content-Type' => 'application/json'}, [status: 'Not logged in', worker: nil]]
    end
  end
}
